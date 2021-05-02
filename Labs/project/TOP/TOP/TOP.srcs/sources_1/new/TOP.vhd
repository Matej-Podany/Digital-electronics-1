----------------------------------------------------------------------------------
-- Company: VUT FEKT
-- Engineer: Mat?j Podanı
-- 
-- Design Name: TOP
-- Module Name: TOP
-- Project Name: Cyclo tachometer
-- Target Devices: Nexys A7-35
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
  Port ( 
        button1_i     : in std_logic;
        button2_i     : in std_logic;
        hall_i        : in std_logic;
        adress_o      : out std_logic_vector(3-1 downto 0);
        number_o      : out std_logic_vector(4-1 downto 0)
        );
end top;

architecture Behavioral of top is
        signal s_clk125hz        : std_logic;
        signal s_clk1hz          : std_logic;
        signal s_value           : std_logic_vector(10-1 downto 0);
        signal s_status          : std_logic_vector(2-1 downto 0);
begin
OPTION : entity work.option
        port map(
            btn_i    => button1_i,
            choose_o => s_status
        );

CLOCK : entity work.clock 
        port map(
            clk1hz_o   => s_clk1hz,
            clk125hz_o => s_clk125hz
        );
        
COMPUTATION : entity work.computation 
        port map(
            clk1hz_i => s_clk1hz,
            reset_i  => button2_i,
            sensor_i => hall_i,
            status_i => s_status,
            value_o  => s_value
        );
        
DISPLAYER : entity work.displayer 
        port map(
            value_i    => s_value,
            clk125hz_i => s_clk125hz,
            display_o  => number_o,
            seg_o      => adress_o
        );
end Behavioral;