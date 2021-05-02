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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity option is
  Port ( 
    btn_i    : in std_logic;                        -- input from button
    choose_o : out std_logic_vector(2 - 1 downto 0) -- output determinating which value will appear on display
  );
end option;

architecture Behavioral of option is
    -- definiton of states avaiable to be displayed
    type   state is (VELOCITY, AVG_VELOCITY,  DISTANCE);
                       
    signal s_state  : state;
    
begin
    p_choose_state : process(btn_i)
    begin
        case s_state is
            when VELOCITY =>
                if rising_edge(btn_i) then -- state is changed by every rising edge of button signal
                    s_state <= AVG_VELOCITY;
                end if;
            when AVG_VELOCITY =>
                if rising_edge(btn_i) then
                    s_state <= DISTANCE;
                end if;
            when DISTANCE =>
                if rising_edge(btn_i) then
                    s_state <= VELOCITY;
                end if;
            when others =>
                if rising_edge(btn_i) then
                    s_state <= VELOCITY;
                end if;
         end case;
    end process p_choose_state;
    
    p_output : process (s_state)
    begin
        
        case s_state is
            when VELOCITY =>
                choose_o <= "00"; -- this vector determinates which option will be displayed
            when AVG_VELOCITY =>
                choose_o  <= "01";   
            when DISTANCE =>
                choose_o  <= "10";   
            when others =>
                choose_o <= "00";
        end case;
    end process p_output;
    
end Behavioral;