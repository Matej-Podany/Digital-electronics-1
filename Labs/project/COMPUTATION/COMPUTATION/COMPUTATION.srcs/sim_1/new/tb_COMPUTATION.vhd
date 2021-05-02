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

entity tb_computation is
--  Port ( );
end tb_computation;

architecture Behavioral of tb_computation is
    signal s_status : std_logic_vector(2-1 downto 0);
    signal s_reset  : std_logic;
    signal s_clk    : std_logic;
    signal s_sensor : std_logic;
    
begin
uut_computation: entity work.computation
        port map (
            status_i => s_status,
            reset_i  => s_reset,
            clk1hz_i => s_clk,
            sensor_i => s_sensor
            
        );

p_reset_gen : process
    begin
        s_reset <= '0';
        wait for 7128 ms; -- reset during avarage velocity
        s_reset <= '1';
        wait for 53 ms;
        s_reset <= '0';
        wait for 4128 ms; -- reset during distance
        s_reset <= '1';
        wait for 53 ms;
        s_reset <= '0';
        wait;
    end process p_reset_gen;
    
p_status : process
    begin
        s_status <= "00"; -- velocity
        wait for 4000 ms;
        s_status <= "01"; -- avg. velocity
        wait for 4000 ms;
        s_status <= "10";
        wait for 4000 ms; -- distance
        s_status <= "11"; -- intentionaly unexpected value, should display velocity
        wait for 4000 ms;
        wait;
    end process p_status;
    
p_clk1hz : process
    begin
        while now < 16000 ms loop         
            s_clk <= '1';
            wait for 500 ms;
            s_clk <= '0';
            wait for 500 ms;
        end loop;
        wait;
    end process p_clk1hz;
    
p_sensor : process
    begin
    -----------------------------
    -- many signal assignments --
    -----------------------------
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        
        -- slower 300 ms
        
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        
        --
        
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        
        -- 
        
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        
        --
        
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        
        -- slower 300 ms
        
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        
        --
        
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        
        -- 
        
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        
        wait;
end process p_sensor;

end Behavioral;