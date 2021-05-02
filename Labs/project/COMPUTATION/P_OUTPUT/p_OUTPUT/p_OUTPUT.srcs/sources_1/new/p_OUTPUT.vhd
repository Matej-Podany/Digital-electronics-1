----------------------------------------------------------------------------------
-- Company: VUT FEKT
-- Engineer: Rajm Jan, Mat?j Podaný
-- 
-- Design Name: p_OUTPUT
-- Module Name: COMPUTATION
-- Project Name: Cyclo tachometer
-- Target Devices: Nexys A7-35
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity output is
  Port ( 
    clk1hz_i          : in  std_logic;
    status_i       : in  std_logic_vector(2-1 downto 0);
    distance_i     : in  std_logic_vector(10-1 downto 0);
    avg_velocity_i : in  std_logic_vector(10-1 downto 0);
    velocity_i     : in  std_logic_vector(10-1 downto 0);
    value_o        : out std_logic_vector(10-1 downto 0) := "0000000000"
  );
end output;

architecture Behavioral of output is

begin
p_output : process(status_i, clk1hz_i)
    begin
        if rising_edge(clk1hz_i) then
            case status_i is
                when "00" =>
                    value_o <= velocity_i;
                when "01" =>
                    value_o <= avg_velocity_i;
                when "10" =>
                    value_o <= distance_i;
                when others =>
                    value_o <= velocity_i;
            end case;
        end if;
    end process p_output;

end Behavioral;