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

entity clock is
    generic(
            num_cycles : natural := 1 -- Number of generated cycles
    );
    Port ( clk1hz_o   : out STD_LOGIC; -- Output signal
           clk125hz_o : out STD_LOGIC -- Output signal
    );
    signal clk1hz   : std_logic; -- Output signal
    signal clk125hz : std_logic;-- Output signal
end clock;

architecture Behavioral of clock is

begin
    p_clk1hz : process
    begin
        for i in 1 to num_cycles loop -- Loop generating 1 hz pulse
            clk1hz_o <= '1';          
            wait for 500 ms;
            clk1hz_o <= '0';
            wait for 500 ms;          
        end loop;
    end process p_clk1hz;

    p_clk125hz : process
    begin
        for i in 1 to num_cycles loop -- Loop generating 125 hz pulse
            clk125hz_o <= '1';          
            wait for 4 ms;
            clk125hz_o <= '0';
            wait for 4 ms;          
        end loop;
    end process p_clk125hz;
end Behavioral;