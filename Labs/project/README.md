# clock
```vhdl
----------------------------------------------------------------------------------
-- Company: VUT FEKT
-- Engineer: Matěj Podaný
-- 
-- Create Date: 26.04.2021 17:16:04
-- Design Name: clock
-- Module Name: clock - Behavioral
-- Project Name: bicycle tachometer
-- Target Devices: Nexys A7-35
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

entity clock is
    generic(
            num_cycles : natural := 1
    );
    Port ( clk1hz_o : out STD_LOGIC;
           clk125hz_o : out STD_LOGIC
    );
    signal clk1hz : std_logic := '1';
    signal clk125hz : std_logic := '1';
end clock;

architecture Behavioral of clock is

begin
    p_clk1hz : process
    begin
        for i in 1 to num_cycles loop
            clk1hz_o <= not clk1hz;
            wait for 1000 ms;
            clk1hz_o <= not clk1hz;
            wait for 1000 ms;
        end loop;
    end process p_clk1hz;

    p_clk125hz : process
    begin
        for i in 1 to num_cycles loop
            clk125hz_o <= not clk125hz;
            wait for 8 ms;
            clk125hz_o <= not clk125hz;
            wait for 8 ms;
        end loop;
    end process p_clk125hz;
end Behavioral;

```
# tb_clock
```vhdl
----------------------------------------------------------------------------------
-- Company: VUT FEKT
-- Engineer: Matěj Podaný
-- 
-- Create Date: 26.04.2021 17:16:04
-- Design Name: clock
-- Module Name: clock - Behavioral
-- Project Name: bicycle tachometer
-- Target Devices: Nexys A7-35
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

entity tb_clock is
--  Port ( );
end tb_clock;

architecture Behavioral of tb_clock is
    signal s_clk1hz : std_logic;
    signal s_clk125hz : std_logic;
begin
    uut_clock : entity work.clock
        port map(
            clk1hz_o => s_clk1hz,
            clk125hz_o => s_clk125hz
                );
    p_clk1hz_gen : process
    begin
        while now < 2000 ms loop
            s_clk1hz <= '0';
            wait for 1000 ms;
            s_clk1hz <= '1';
            wait for 1000 ms;
        end loop;
        wait;
    end process p_clk1hz_gen;
    
    p_clk125hz_gen : process
    begin
        while now < 2000 ms loop
            s_clk125hz <= '0';
            wait for 8 ms;
            s_clk125hz <= '1';
            wait for 8 ms;
        end loop;
        wait;
    end process p_clk125hz_gen;
    
end Behavioral;

```
# simulation
![Simulation](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/project/images/Simulation.jpg "Simulation")
