----------------------------------------------------------------------------------
-- Company: VUT FEKT
-- Engineer: Rajm Jan
-- 
-- Design Name: p_AVG_VELOCITY
-- Module Name: COMPUTATION
-- Project Name: Cyclo tachometer
-- Target Devices: Nexys A7-35
-- 
----------------------------------------------------------------------------------

library ieee;
use IEEE.math_real.all;                 -- Needed for power
use ieee.std_logic_1164.all;            -- Basic library
use ieee.numeric_std.all;               -- Needed for shifts

entity e_avg_velocity is
    Port (
        clk1hz_i       : in std_logic;
        reset_i        : in std_logic;
        vel2avg_i      : in std_logic_vector(10-1 downto 0);
        avg_velocity_o : out std_logic_vector(10-1 downto 0)  := "0000000000"  
    );
end e_avg_velocity;
 
architecture behave of e_avg_velocity is

  signal sum_of_velocities     : unsigned(10-1 downto 0) := "0000000000";
  
begin
 
p_avg_velocity : process(clk1hz_i, reset_i)

  variable count_of_shifts     : integer    := 1;
  variable clk_cycles          : integer    := 2; -- states for how many clock cycles does signal sum_of_velocities adds samples of 
                                                  --   velocity and for how long does process wait for division
    begin
    
    if rising_edge(reset_i) then
        avg_velocity_o      <= "0000000000"; -- zeroing value of avarage velocity
        sum_of_velocities   <= "0000000000"; -- zeroing of sum of velocities
        count_of_shifts := 1;
        clk_cycles      := 2; -- shift of one bit correspondents with waiting for two samples os velocity to be summed
    else
        if rising_edge(clk1hz_i) then 
                    
            sum_of_velocities <= sum_of_velocities + unsigned(vel2avg_i);             
                
            if clk_cycles = 0 then
                avg_velocity_o <= std_logic_vector(shift_right(unsigned(sum_of_velocities), count_of_shifts)); -- division of summed velocities 
                count_of_shifts := count_of_shifts + 1;                                    --   in order to compute avarage velocity
                clk_cycles := 2**(count_of_shifts - 1); 
            end if;
        
            clk_cycles := clk_cycles - 1;        
          
        end if;
    end if;
  end process p_avg_velocity;
end architecture behave;