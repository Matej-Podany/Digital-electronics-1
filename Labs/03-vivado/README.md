# Task 1
| **SWITCH** | **R - 10K** | **LED** | **R - 330R** | **SW - PIN** | **LED - PIN** |
| :-: | :-: | :-: | :-: | :-: | :-: |
| SW0 | R35 | LD0 | R33 | J15 | H17 |
| SW1 | R37 | LD1 | R34 | L16 | K15 |
| SW2 | R38 | LD2 | R36 | M13 | J13 |
| SW3 | R40 | LD3 | R39 | R15 | N14 |
| SW4 | R42 | LD4 | R41 | R17 | R18 |
| SW5 | R43 | LD5 | R44 | T18 | V17 |
| SW6 | R46 | LD6 | R47 | U18 | U17 |
| SW7 | R48 | LD7 | R50 | R13 | U16 |
| SW8 | R56 | LD8 | R52 | T8 | V16 |
| SW9 | R58 | LD9 | R54 | U8 | T15 |
| SW10 | R64 | LD10 | R57 | R16 | U14 |
| SW11 | R66 | LD11 | R65 | T13 | T16 |
| SW12 | R68 | LD12 | R67 | H6 | V15 |
| SW13 | R69 | LD13 | R70 | U12 | V14 |
| SW14 | R71 | LD14 | R72 | U11 | V12 |
| SW15 | R73 | LD15 | R74 | V10 | V11 |

# Task 2

## 2.1
```vhdl
------------------------------------------------------------------------
-- Architecture body for mux_2bit_4to1 multiplexer
------------------------------------------------------------------------
architecture Behavioral of mux_2bit_4to1 is
begin
    f_o <=  a_i when (sel_i = "00") else
            b_i when (sel_i = "01") else
            c_i when (sel_i = "10") else
            d_i;

end architecture Behavioral;
```

## 2.2
```vhdl
--------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        -- Report a note at the beginning of stimulus process
        report "Stimulus process started" severity note;

        s_a <= "00"; s_b <= "00"; s_c <= "00"; s_d <= "00";
        s_sel <= "00"; wait for 100 ns;
        
        s_a <= "00"; s_b <= "01"; s_c <= "01"; s_d <= "10";
        s_sel <= "00"; wait for 100 ns;
        
        s_a <= "11"; s_b <= "01"; s_c <= "01"; s_d <= "10";
        s_sel <= "00"; wait for 100 ns;
        
        s_a <= "00"; s_b <= "01"; s_c <= "01"; s_d <= "10";
        s_sel <= "01"; wait for 100 ns;
        
        s_a <= "00"; s_b <= "11"; s_c <= "01"; s_d <= "10";
        s_sel <= "01"; wait for 100 ns;
        
        s_sel <= "10"; wait for 100 ns;
        
        s_sel <= "11"; wait for 100 ns;
        
        -- Report a note at the end of stimulus process
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
```

## 2.3
![Simulation](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/03-vivado/images/simulation.jpg "Simulation")

# Task 3

## Step 1

![Step 1](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/03-vivado/images/1.png "Step 1")

## Step 2

![Step 2](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/03-vivado/images/2.png "Step 2")

## Step 3

![Step 3](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/03-vivado/images/3.png "Step 3")

## Step 4

![Step 4](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/03-vivado/images/4.png "Step 4")

## Step 5

![Step 5](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/03-vivado/images/5.png "Step 5")

## Step 6

![Step 1](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/03-vivado/images/6.png "Step 6")

## Step 7

![Step 7](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/03-vivado/images/7.png "Step 7")

## Step 8

![Step 8](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/03-vivado/images/8.png "Step 8")

## Step 9

![Step 9](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/03-vivado/images/9.png "Step 9")

## Step 10

![Step 10](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/03-vivado/images/10.png "Step 10")

## Step 11

![Step 11](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/03-vivado/images/11.png "Step 11")

## Step 12

![Step 12](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/03-vivado/images/12.png "Step 12")

## Step 13

![Step 13](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/03-vivado/images/13.png "Step 13")

## Step 14

![Step 14](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/03-vivado/images/14.png "Step 14")

## Step 15

![Step 15](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/03-vivado/images/15.png "Step 15")

## Step 16

![Step 16](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/03-vivado/images/16.png "Step 16")

## Step 17

![Step 17](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/03-vivado/images/17.png "Step 17")

## Step 18

![Step 18](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/03-vivado/images/18.png "Step 18")

## Step 19

![Step 19](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/03-vivado/images/19.png "Step 19")

## Step 20

![Step 20](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/03-vivado/images/20.png "Step 20")

## Step 21

![Step 21](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/03-vivado/images/21.png "Step 21")

## Step 22

![Step 22](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/03-vivado/images/22.png "Step 22")

## Step 23

![Step 23](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/03-vivado/images/23.png "Step 23")

## Step 24

![Step 24](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/03-vivado/images/24.png "Step 24")

## Step 25

![Step 25](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/03-vivado/images/25.png "Step 25")

## Step 26

![Step 26](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/03-vivado/images/26.png "Step 26")

## Step 27

![Step 27](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/03-vivado/images/27.png "Step 27")

## Step 28

![Step 28](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/03-vivado/images/28.png "Step 28")
