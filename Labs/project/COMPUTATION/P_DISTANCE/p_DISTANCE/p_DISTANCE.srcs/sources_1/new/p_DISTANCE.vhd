----------------------------------------------------------------------------------
-- Company: VUT FEKT
-- Engineer: Rajm Jan, Mat?j Podaný
-- 
-- Design Name: p_DISTANCE
-- Module Name: COMPUTATION
-- Project Name: Cyclo tachometer
-- Target Devices: Nexys A7-35
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity distance is
  Port ( 
    sensor_i     : in std_logic;
    areset_i     : in std_logic;
    distance_o   : out std_logic_vector(10-1 downto 0) := "0000000000"
  );
end distance;

architecture Behavioral of distance is

    signal s_distance : unsigned(10-1 downto 0) := "0000000000"; -- necessary for summing

    begin
        p_distance : process(sensor_i, areset_i)
        
        variable sum : integer := 0; -- counts input signals 
        
        begin
            if areset_i = '1' then
                sum := 0;
                s_distance <= "0000000000";
            else
                if rising_edge(sensor_i) then
                    sum := sum + 1;
                    if sum > 500 then --for simulation purpouse, in application: if sum > 500 then (...). We consider wheel with circuit of 2m thus 1km means 500 revolutions. 
                      sum := 0;
                      s_distance <= s_distance + "0000000001";    
                    end if;
                    --distance_o <= std_logic_vector(s_distance);
                 end if;
                 
                 distance_o <= std_logic_vector(s_distance);
                 
            end if;
        end process p_distance;
        
end Behavioral;