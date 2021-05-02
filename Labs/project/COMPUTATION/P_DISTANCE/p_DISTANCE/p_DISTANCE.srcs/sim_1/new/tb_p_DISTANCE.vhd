----------------------------------------------------------------------------------
-- Company: VUT FEKT
-- Engineer: Rajm Jan, Mat?j Podanı
-- 
-- Design Name: p_DISTANCE
-- Module Name: COMPUTATION
-- Project Name: Cyclo tachometer
-- Target Devices: Nexys A7-35
-- 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------------------
entity tb_distance is
    -- Entity of testbench is always empty
end entity tb_distance;

------------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------
architecture testbench of tb_distance is

    signal s_signal     :  std_logic;
    signal reset        :  std_logic;
    signal s_distance   :  std_logic_vector(10-1 downto 0);
    
begin
    uut_driver_7_seg: entity work.distance
        port map (
            
            sensor_i     =>  s_signal,
            reset_i    =>  reset,
            distance_o => s_distance
        );
    p_reset_gen : process
    begin
        reset <= '0';
        wait for 500 ns;
        reset <= '1';
        wait for 53 ns;
        reset <= '0';
        wait;
    end process p_reset_gen;
    
    p_stimulus : process
    begin
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';     
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';     
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';     
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        
        wait;
    end process p_stimulus;
end architecture testbench;