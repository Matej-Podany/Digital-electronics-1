----------------------------------------------------------------------------------
-- Company: VUT FEKT
-- Engineer: Mat?j Podaný, Rajm Jan
-- 
-- Design Name: CLOCK
-- Module Name: CLOCK
-- Project Name: Cyclo tachometer
-- Target Devices: Nexys A7-35
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_clock is
--  Port ( );
end tb_clock;

architecture Behavioral of tb_clock is
    signal s_clk1hz : std_logic;
    signal s_clk125hz : std_logic;
begin
    uut_clock : entity work.clock
        port map(
            clk1hz_o   => s_clk1hz,
            clk125hz_o => s_clk125hz
                );
end Behavioral;