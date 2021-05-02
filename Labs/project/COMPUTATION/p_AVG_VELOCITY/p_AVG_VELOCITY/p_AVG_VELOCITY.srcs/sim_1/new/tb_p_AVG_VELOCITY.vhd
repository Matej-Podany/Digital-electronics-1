----------------------------------------------------------------------------------
-- Company: VUT FEKT
-- Engineer: Rajm Jan
-- 
-- Design Name: p_AVG_VELOCITY
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
entity tb_cnt_up_down is
    -- Entity of testbench is always empty
end entity tb_cnt_up_down; 

------------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------
architecture testbench of tb_cnt_up_down is

    -- Number of bits for testbench counter

    --Local signals
    signal s_clk          : std_logic;
    signal reset          : std_logic;
    signal s_velocity     : std_logic_vector(10-1 downto 0);
    signal s_avg_velocity : std_logic_vector(10-1 downto 0);

begin
    -- Connecting testbench signals with cnt_up_down entity
    -- (Unit Under Test)
    uut_avg_vel : entity work.e_avg_velocity
        
        port map(
            clk1hz_i                         => s_clk,
            vel2avg_i                        => s_velocity,
            reset_i                          => reset,
            std_logic_vector(avg_velocity_o) => s_avg_velocity
        );

    --------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 750 ns loop         -- 75 periods of 100MHz clock
            s_clk <= '0';
            wait for 5 ns;
            s_clk <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process p_clk_gen;
    
    --------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------
    p_reset : process
    begin
        reset <= '0';
        wait for 125 ns;
        reset <= '1';
        wait for 25 ns;
        reset <= '0';
        wait for 220 ns;
        reset <= '0';
        wait for 17ns;
        reset <= '0';
        wait;
    end process p_reset;

    --------------------------------------------------------------------
    -- Velocity generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        s_velocity <= "0000000000";
        wait for 10 ns;
        s_velocity <= "0000001010";
        wait for 10 ns;
        s_velocity <= "0000001100";
        wait for 10 ns;
        s_velocity <= "0000001110";
        wait for 10 ns;
        s_velocity <= "0000011001";
        wait for 10 ns;
        s_velocity <= "0000001000";
        wait for 10 ns;
        s_velocity <= "0000001010";
        wait for 10 ns;
        s_velocity <= "0000001010";
        wait for 10 ns;
        s_velocity <= "0000001100";
        wait for 10 ns;
        s_velocity <= "0000001110";
        wait for 10 ns;
        s_velocity <= "0000000000";
        wait for 10 ns;
        s_velocity <= "0000001000";
        wait for 10 ns;
        s_velocity <= "0000001010";
        wait for 10 ns;
        s_velocity <= "0000001100";
        wait for 10 ns;
        s_velocity <= "0000001010";
        wait for 10 ns;
        s_velocity <= "0000001001";
        wait for 10 ns;
        s_velocity <= "0000001000";
        wait for 10 ns;
        s_velocity <= "0000001010";
        wait for 10 ns;
        s_velocity <= "0000001010";
        wait for 10 ns;
        s_velocity <= "0000001100";
        wait for 10 ns;
        s_velocity <= "0000001110";
        wait for 10 ns;
        s_velocity <= "0000000000";
    end process p_stimulus;

end architecture testbench;