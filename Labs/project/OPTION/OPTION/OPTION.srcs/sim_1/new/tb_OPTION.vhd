----------------------------------------------------------------------------------
-- Company: VUT FEKT
-- Engineer: Rajm Jan
-- 
-- Design Name: OPTION
-- Module Name: OPTION
-- Project Name: Cyclo tachometer
-- Target Devices: Nexys A7-35
-- 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------------------
entity tb_option is
    -- Entity of testbench is always empty
end entity tb_option;

------------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------
architecture testbench of tb_option is

    --Local signals
   
    signal s_btn_i        :  std_logic;
    signal s_choose_o     :  std_logic_vector(2-1 downto 0);
    --signal s_state        :  std_logic;
    signal s_state        :  std_logic; 

begin
    uut_option: entity work.option
        port map (
           
            btn_i     => s_btn_i,
            choose_o  => s_choose_o
            --state   => s_state
        );
   
    --------------------------------------------------------------------
    -- Data generation process - simulation button presses
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
            s_btn_i <= '0';
            wait for 200 ns;
            s_btn_i <= '1';
            wait for 20 ns;
            s_btn_i <= '0';
            wait for 50 ns;
            s_btn_i <= '1';
            wait for 10 ns;
            s_btn_i <= '0';
            wait for 350 ns;
            s_btn_i <= '1';
            wait for 10 ns;
            s_btn_i <= '0';
            wait for 150 ns;
            s_btn_i <= '1';
            wait for 10 ns;
            s_btn_i <= '0';
            wait for 20 ns;
            s_btn_i <= '1';
            wait for 20 ns;
            s_btn_i <= '0';
            wait;
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
end architecture testbench;