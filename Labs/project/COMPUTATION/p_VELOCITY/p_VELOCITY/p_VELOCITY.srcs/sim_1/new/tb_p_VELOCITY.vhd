----------------------------------------------------------------------------------
-- Company: VUT FEKT
-- Engineer: Pelka Jan, Mat?j Podaný
-- 
-- Design Name: p_VELOCITY
-- Module Name: COMPUTATION
-- Project Name: Cyclo tachometer
-- Target Devices: Nexys A7-35
-- 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity tb_distance is
end entity tb_distance;

architecture testbench of tb_distance is

    signal s_sensor     :  std_logic;
    signal s_clk1hz     :  std_logic;
    signal s_velocity   :  std_logic_vector(10-1 downto 0);
    
    
begin
    uut_velocity: entity work.velocity
        port map (
            
        clk1hz_i => s_clk1hz,  
        velocity_o => s_velocity,
        sensor_i => s_sensor
        );
        
    gen_clock : process
    begin
        s_clk1hz <= '1';
        wait for 500ms;
        s_clk1hz <= '0';
        wait for 500ms;
        s_clk1hz <= '1';
        wait for 500ms;
        s_clk1hz <= '0';
        wait for 500ms;
        s_clk1hz <= '1';
        wait for 500ms;
        s_clk1hz <= '0';
        wait for 500ms;
        s_clk1hz <= '1';
        wait for 500ms;
        s_clk1hz <= '0';
        wait for 500ms;
        wait;
    end process gen_clock;

    p_stimulus : process
    begin
        s_sensor <= '1';
        wait for 500ms;
        s_sensor <= '0';
        wait for 500ms;
        
        s_sensor <= '1';
        wait for 250ms;
        s_sensor <= '0';
        wait for 250ms;
        s_sensor <= '1';
        wait for 250ms;
        s_sensor <= '0';
        wait for 250ms;
        s_sensor <= '1';
        wait for 250ms;
        s_sensor <= '0';
        wait for 250ms;
        s_sensor <= '1';
        wait for 250ms;
        s_sensor <= '0';
        wait for 250ms;

        s_sensor <= '1';
        wait for 100ms;
        s_sensor <= '0';
        wait for 100ms;
        s_sensor <= '1';
        wait for 100ms;
        s_sensor <= '0';
        wait for 100ms;
        s_sensor <= '1';
        wait for 100ms;
        s_sensor <= '0';
        wait for 100ms;
        s_sensor <= '1';
        wait for 100ms;
        s_sensor <= '0';
        wait for 100ms;
        s_sensor <= '1';
        wait for 100ms;
        s_sensor <= '0';
        wait for 100ms;
        
        wait;
    end process p_stimulus;
end architecture testbench;