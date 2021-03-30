# Task 1
D: q(n+1) = d
| **clk** | **d** | **q(n)** | **q(n+1)** | **Comments** |
| :-: | :-: | :-: | :-: | :-- |
| up | 0 | 0 | 0 | Stored |
| up | 0 | 1 | 0 | No change |
| up | 1 | 0 | 1 | Stored |
| up | 1 | 1 | 1 | No change |
JK: q(n+1) = j/q(n)+/kq(n)
| **clk** | **j** | **k** | **q(n)** | **q(n+1)** | **Comments** |
| :-: | :-: | :-: | :-: | :-: | :-- |
| up | 0 | 0 | 0 | 0 | No change |
| up | 0 | 0 | 1 | 1 | No change |
| up | 0 | 1 | 0 | 0 | Reset |
| up | 0 | 1 | 1 | 0 | Reset |
| up | 1 | 0 | 0 | 1 | Set |
| up | 1 | 0 | 1 | 1 | Set |
| up | 1 | 1 | 0 | 1 | Toggle |
| up | 1 | 1 | 1 | 0 | Toggle |
T: q(n+1) = t/q(n)+/tq(n)
| **clk** | **t** | **q(n)** | **q(n+1)** | **Comments** |
| :-: | :-: | :-: | :-: | :-- |
| up | 0 | 0 | 0 | No change |
| up | 0 | 1 | 1 | No change |
| up | 1 | 0 | 1 | Invert |
| up | 1 | 1 | 0 | Invert |


# Task 2
## 2.1
```vhdl
p_d_latch : process (d, arst, en)
    begin
        if (arst = '1') then
            q <= '0';
            q_bar <= '1';
        elsif (en = '1') then
            q <= d;
            q_bar <= not d;
        end if;
    end process p_d_latch;
```

## 2.2
```vhdl
p_reset_gen : process
    begin
        s_arst <= '0';
        wait for 53 ns;
        
        -- Reset activated
        s_arst <= '1';
        wait for 5 ns;

        -- Reset deactivated
        s_arst <= '0';
        wait for 103ns;
        s_arst <= '1';

        wait;
    end process p_reset_gen;
    
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
            s_en <= '0';
            s_d  <= '0';
            
            --d sequence
            wait for 10 ns;
            s_d <= '1';
            wait for 10 ns;
            s_d  <= '0';
            wait for 10 ns;
            s_d <= '1';
            wait for 10 ns;
            s_d  <= '0';
            wait for 10 ns;
            s_d <= '1';
            wait for 10 ns;
            s_d  <= '0';
            wait for 10 ns;
            --/d sequence
            
            s_en <= '1';
            
            wait for 5ns;
            assert(s_q = '0' and s_q_bar = '1')
            report "s_q != 0 and s_q_bar != 1" severity error;
            
            --d sequence
            wait for 5 ns;
            s_d <= '1';
            wait for 10 ns;
            s_d  <= '0';
            wait for 10 ns;
            s_d <= '1';
            wait for 10 ns;
            s_d  <= '0';
            wait for 10 ns;
            s_d <= '1';
            wait for 10 ns;
            s_en <= '0';
            
            wait for 5ns;
            assert(s_q = '1' and s_q_bar = '0')
            report "s_q != 1 and s_q_bar != 0" severity error;
            
            wait for 5 ns;
            s_d  <= '0';
            wait for 10 ns;
            --/d sequence
            
            --d sequence
            wait for 10 ns;
            s_d <= '1';
            wait for 10 ns;
            s_d  <= '0';
            wait for 10 ns;
            s_d <= '1';
            wait for 10 ns;
            s_d  <= '0';
            wait for 10 ns;
            s_d <= '1';
            wait for 10 ns;
            s_d  <= '0';
            wait for 10 ns;
            --/d sequence
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
```

## 2.3
![simulation1](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/07-ffs/images/simulation1.jpg "simulation1")

# Task 3
## 3.1
d_ff_arst
```vhdl
p_d_ff_arst : process (clk, arst)
    begin
        if (arst = '1') then
            q <= '0';
            q_bar <= '1';
        elsif rising_edge(clk) then
            q <= d;
            q_bar <= not d;
        end if;
    end process p_d_ff_arst;
```
d_ff_arst
```vhdl
jk_ff_rst : process (clk)
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                s_q <= '0';
            else
                if (j = '0' and k = '0') then
                    s_q <= s_q;
                elsif (j = '0' and k = '1') then
                    s_q <= '0';
                elsif (j = '1' and k = '0') then
                    s_q <= '1';
                elsif (j = '1' and k = '1') then
                    s_q <= not s_q;
                end if;
            end if;
        end if;
    end process jk_ff_rst;
    
    q <= s_q;
    q <= not s_q;
```
## 3.2
d_ff_arst
```vhdl
--------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 750 ns loop         -- 75 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;

    --------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------
    p_reset_gen : process
    begin
        s_arst <= '0';
        wait for 58 ns;
        
        -- Reset activated
        s_arst <= '1';
        wait for 15 ns;

        -- Reset deactivated
        s_arst <= '0';

        wait;
    end process p_reset_gen;
    
    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        
            --d sequence
            wait for 13 ns;
            s_d <= '1';
            wait for 10 ns;
            s_d  <= '0';
            wait for 5ns;
            assert(s_q = '0' and s_q_bar = '1')
            report "s_q != 0 and s_q_bar != 1" severity error;
            wait for 5 ns;
            s_d <= '1';
            wait for 5ns;
            assert(s_q = '1' and s_q_bar = '0')
            report "s_q != 1 and s_q_bar != 0" severity error;
            wait for 5 ns;
            s_d  <= '0';
            wait for 10 ns;
            s_d <= '1';
            wait for 10 ns;
            s_d  <= '0';
            wait for 10 ns;
            --/d sequence
            
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
```
jk_ff_rst
```vhdl
--------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 750 ns loop         -- 75 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;

    --------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------
    p_reset_gen : process
    begin
        s_rst <= '0';
        wait for 58 ns;
        
        -- Reset activated
        s_rst <= '1';
        wait for 15 ns;

        -- Reset deactivated
        s_rst <= '0';

        wait;
    end process p_reset_gen;
    
    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        
            --d sequence
            wait for 13 ns;
            s_j <= '0';
            s_k <= '0';
            wait for 20 ns;
            s_j  <= '0';
            s_k  <= '1';
            wait for 10ns;
            assert(s_q = '0' and s_q_bar = '1')
            report "s_q != 0 and s_q_bar != 1" severity error;
            wait for 10 ns;
            s_j <= '1';
            s_k <= '0';
            wait for 10ns;
            assert(s_q = '0' and s_q_bar = '1')
            report "s_q != 0 and s_q_bar != 1" severity error;
            wait for 10 ns;
            s_j  <= '1';
            s_k  <= '1';
            wait for 20 ns;
            s_j <= '0';
            s_k <= '0';
            wait for 20 ns;
            s_j  <= '0';
            s_k  <= '1';
            wait for 20 ns;
            --/d sequence
            
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
```

## 3.3
d_ff_arst
![simulation2a](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/07-ffs/images/simulation2a.jpg "simulation2a")
