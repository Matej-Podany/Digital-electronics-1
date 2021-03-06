----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.03.2021 18:05:34
-- Design Name: 
-- Module Name: tb_top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_top is
--  Port ( );
end tb_top;

architecture Behavioral of tb_top is
    -- Local signals
       signal SW  : STD_LOGIC_VECTOR (4 - 1 downto 0);
       signal LED : STD_LOGIC_VECTOR (8 - 1 downto 0);
        
begin
-- Connecting testbench signals with hex_7seg entity (Unit Under Test)
    uut_hex_7seg : entity work.hex_7seg
        port map(
            hex_i  => SW
        );

    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        -- Report a note at the beginning of stimulus process
        report "Stimulus process started" severity note;

        SW <= "0000"; wait for 62.5 ns;
        
        SW <= "0001"; wait for 62.5 ns;
        
        SW <= "0010"; wait for 62.5 ns;
        
        SW <= "0011"; wait for 62.5 ns;
        
        SW <= "0100"; wait for 62.5 ns;
        
        SW <= "0101"; wait for 62.5 ns;
        
        SW <= "0110"; wait for 62.5 ns;
        
        SW <= "0111"; wait for 62.5 ns;
        
        SW <= "1000"; wait for 62.5 ns;
        
        SW <= "1001"; wait for 62.5 ns;
        
        SW <= "1010"; wait for 62.5 ns;
        
        SW <= "1011"; wait for 62.5 ns;
        
        SW <= "1100"; wait for 62.5 ns;
        
        SW <= "1101"; wait for 62.5 ns;
        
        SW <= "1110"; wait for 62.5 ns;
        
        SW <= "1111"; wait for 62.5 ns;
        
        -- Report a note at the end of stimulus process
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end Behavioral;
