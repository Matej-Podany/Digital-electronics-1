----------------------------------------------------------------------------------
-- Company: VUT FEKT
-- Engineer: Rajm Jan
-- 
-- Design Name: COMPUTATION
-- Module Name: COMPUTATION
-- Project Name: Cyclo tachometer
-- Target Devices: Nexys A7-35
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity computation is
  Port ( 
    status_i   : in std_logic_vector(2-1 downto 0);
    reset_i    : in std_logic;
    clk1hz_i   : in std_logic;
    sensor_i   : in std_logic;
    value_o    : out std_logic_vector(10-1 downto 0)
  );
end computation;

architecture Behavioral of computation is
    signal s_avg_velocity : std_logic_vector(10-1 downto 0);
    signal s_velocity     : std_logic_vector(10-1 downto 0);
    signal s_distance     : std_logic_vector(10-1 downto 0);
    signal s_value        : std_logic_vector(10-1 downto 0);
begin
p_velocity : entity work.velocity
        port map(
        -- submodule => top module
            clk1hz_i   => clk1hz_i,
            sensor_i   => sensor_i,
            velocity_o => s_velocity
        );

p_avg_velocity : entity work.e_avg_velocity 
        port map(
            clk1hz_i       => clk1hz_i,
            reset_i        => reset_i,
            vel2avg_i      => s_velocity,
            avg_velocity_o => s_avg_velocity
        );
        
p_distance : entity work.distance 
        port map(
            sensor_i   => sensor_i,
            reset_i    => reset_i,
            distance_o => s_distance
        );
        
p_output : entity work.output 
        port map(
            clk1hz_i       => clk1hz_i,
            status_i       => status_i,
            distance_i     => s_distance,
            avg_velocity_i => s_avg_velocity,
            velocity_i     => s_velocity,
            value_o        => s_value
        );
end Behavioral;