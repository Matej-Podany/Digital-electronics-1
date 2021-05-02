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

entity tb_top is
--  Testbench entity is always empty
end tb_top;

architecture Behavioral of tb_top is
    signal s_button1     : std_logic;
    signal s_button2     : std_logic;
    signal s_hall        : std_logic;
    signal s_adress      : std_logic_vector(3-1 downto 0);
    signal s_number      : std_logic_vector(4-1 downto 0);
    
begin
uut_top: entity work.top
        port map (
           button1_i => s_button1,
           button2_i => s_button2,
           hall_i    => s_hall,
           adress_o  => s_adress, 
           number_o  => s_number 
        );

p_reset_gen : process
    begin
        s_button2 <= '0';
        --wait for 7128 ms;
        --s_button2 <= '1'; -- one push of the reset button
        --wait for 53 ms;
        --s_button2 <= '0';
        wait;
    end process p_reset_gen;
    
p_status : process
    begin
        s_button1 <= '0'; 
        wait for 4000 ms;
        s_button1 <= '1'; -- first button push
        wait for 500 ms;
        s_button1 <= '0';
        wait for 3500 ms;
        s_button1 <= '1'; -- second button push
        wait for 500 ms;
        s_button1 <= '0';
        wait for 3500 ms;
        s_button1 <= '1'; -- thirt button push
        wait for 500 ms;
        s_button1 <= '0';
        wait;
    end process p_status;
    
p_sensor : process
    begin
        s_hall <= '0'; -- accelerating
        wait for 500 ms;
        s_hall <= '1';
        wait for 10 ms;
        s_hall <= '0';
        wait for 400 ms;
        s_hall <= '1';
        wait for 10 ms;
        s_hall <= '0';
        wait for 300 ms;
        s_hall <= '1';
        wait for 10 ms;
        s_hall <= '0';
        wait for 200 ms;
        s_hall <= '1';
        wait for 10 ms;
        s_hall <= '0';
        wait for 100 ms;
        s_hall <= '1';
        wait for 10 ms;
        s_hall <= '0';
        wait for 100 ms; 
        while now < 16000 ms loop  -- stable     
            s_hall <= '1';
            wait for 10 ms;
            s_hall <= '0';
            wait for 190 ms;
        end loop;
        wait;
    end process p_sensor;


end Behavioral;