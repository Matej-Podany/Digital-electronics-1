# Task 1
## 1.1
| **Input P** | `0` | `0` | `1` | `1` | `0` | `1` | `0` | `1` | `1` | `1` | `1` | `0` | `0` | `1` | `1` | `1` |
| :-- | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| **Clock** | Rising | Rising | Rising | Rising | Rising | Rising | Rising | Rising | Rising | Rising | Rising | Rising | Rising | Rising | Rising | Rising |
| **State** | A | A | B | C | C | D | B | C | D | A | B | B | B | C | D | A |
| **Output R** | `0` | `0` | `0` | `0` | `0` | `1` | `0` | `0` | `1` | `0` | `0` | `0` | `0` | `0` | `1` | `0` |

## 1.2
![Figure1](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/08-traffic_lights/images/Figure1.jpg "Figure1")

| **RGB LED** | **Artix-7 pin names** | **Red** | **Yellow** | **Green** |
| :-: | :-: | :-: | :-: | :-: |
| LD16 | N15, M16, R12 | `1,0,0` | `1,1,0` | `0,1,0` |
| LD17 | N16, R11, G14 | `1,0,0` | `1,1,0` | `0,1,0` |

# Task 2
## 2.1
![Figure2](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/08-traffic_lights/images/Figure2.jpg "Figure2")

## 2.2
```vhdl
	--------------------------------------------------------------------
    -- p_traffic_fsm:
    -- The sequential process with synchronous reset and clock_enable 
    -- entirely controls the s_state signal by CASE statement.
    --------------------------------------------------------------------
    p_traffic_fsm : process(clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then       -- Synchronous reset
                s_state <= STOP1 ;      -- Set initial state
                s_cnt   <= c_ZERO;      -- Clear all bits

            elsif (s_en = '1') then
                -- Every 250 ms, CASE checks the value of the s_state 
                -- variable and changes to the next state according 
                -- to the delay value.
                case s_state is

                    -- If the current state is STOP1, then wait 1 sec
                    -- and move to the next GO_WAIT state.
                    when STOP1 =>
                        -- Count up to c_DELAY_1SEC
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= WEST_GO;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;

                    when WEST_GO =>
                        -- Count up to c_DELAY_4SEC
                        if (s_cnt < c_DELAY_4SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= WEST_WAIT;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;
                    when WEST_WAIT =>
                        -- Count up to c_DELAY_2SEC
                        if (s_cnt < c_DELAY_2SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= STOP2;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;
                    when STOP2 =>
                        -- Count up to c_DELAY_1SEC
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= SOUTH_GO;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;
                    when SOUTH_GO =>
                        -- Count up to c_DELAY_4SEC
                        if (s_cnt < c_DELAY_4SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= SOUTH_WAIT;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;
                    when SOUTH_WAIT =>
                        -- Count up to c_DELAY_2SEC
                        if (s_cnt < c_DELAY_2SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= STOP1;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;
                    -- It is a good programming practice to use the 
                    -- OTHERS clause, even if all CASE choices have 
                    -- been made. 
                    when others =>
                        s_state <= STOP1;

                end case;
            end if; -- Synchronous reset
        end if; -- Rising edge
    end process p_traffic_fsm;
```

## 2.3
```vhdl
	--------------------------------------------------------------------
    -- p_output_fsm:
    -- The combinatorial process is sensitive to state changes, and sets
    -- the output signals accordingly. This is an example of a Moore 
    -- state machine because the output is set based on the active state.
    --------------------------------------------------------------------
    p_output_fsm : process(s_state)
    begin
        case s_state is
            when STOP1 =>
                south_o <= c_RED;
                west_o  <= c_RED;
            when WEST_GO =>
                south_o <= c_RED;
                west_o  <= c_GREEN;
            when WEST_WAIT =>
                south_o <= c_RED;
                west_o  <= c_YELLOW;
            when STOP2 =>
                south_o <= c_RED;
                west_o  <= c_RED;
            when SOUTH_GO =>
                south_o <= c_GREEN;
                west_o  <= c_RED;
            when SOUTH_WAIT =>
                south_o <= c_YELLOW;
                west_o  <= c_RED;
            when others =>
                south_o <= c_RED;
                west_o  <= c_RED;
        end case;
    end process p_output_fsm;
```

## 2.4
![Simulation1](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/08-traffic_lights/images/Simulation1.jpg "Simulation1")

# Task 3
## 3.1
Input: 00 (NorthEast)

0 = There is not car in this direction
1 = There is car in this direction

| **Current state** | **Direction South** | **Direction West** | **Inputs for stay in this state or fixed delay** | **Inputs for  move to the next state or fixed delay** |
| :-- | :-: | :-: | :-: | :-: |
| `STOP1`      | red    | red | 1 sec | 1 sec |
| `WEST_GO`    | red    | green | `00,01` | `10`; `11` => 4 sec |
| `WEST_WAIT`  | red    | yellow | 2 sec | 2 sec |
| `STOP2`      | red    | red | 1 sec | 1 sec |
| `SOUTH_GO`   | green  | red | `00,10` | `01`; `11` => 4 sec |
| `SOUTH_WAIT` | yellow | red | 2 sec | 2 sec |

## 3.2
In states Stop1, Stop2, WestWait and SouthWait there is not input displayed, because this states does NOT depend on inputs (car sensors).
They have fixed time delay (Start => Stop1: 1 second red => WestGo: -conditions in table- => WestWait: 2 seconds yellow => Stop2) and it is same for both directions.
I just want to say, that if there are cars from both directions, green will be in one direction 4 seconds. If there is green in one direction and in the same direction is car, at the moment, when car
will drive from another direction, will green last for 4 seconds before it changes to yellow, then red and then green for another direction (to prevent instant changing of lights).
![Figure3](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/08-traffic_lights/images/Figure3.jpg "Figure3")

## 3.3
```vhdl
	p_smart_traffic_fsm : process(clk,input)
    begin
        if rising_edge(clk) then -- There is no problem, if code will react with delay <250 ms, so no need for change
            if (reset = '1') then       -- Synchronous reset
                s_state <= STOP1 ;      -- Set initial state
                s_cnt   <= c_ZERO;      -- Clear all bits

            elsif (s_en = '1') then
                -- Every 250 ms, CASE checks the value of the s_state 
                -- variable and changes to the next state according 
                -- to the delay value.
                case s_state is

                    -- If the current state is STOP1, then wait 1 sec
                    -- and move to the next GO_WAIT state.
                    when STOP1 =>
                        -- Count up to c_DELAY_1SEC
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= WEST_GO;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;

                    when WEST_GO =>
                        -- Condition for staying in this state !!! Higher bit is North (South) and the lower is East (West)
                        if (input = "00" or input = "01") then
                            null;
                        elsif (input = "10") then
                            -- Move to the next state immedialently, because in West (East) direction is not car
                            s_state <= WEST_WAIT;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        elsif (input = "11") then
                            -- Move to the next state after 4 seconds, this prevents immedialent color switching.
                            if (s_cnt < c_DELAY_4SEC) then
                                s_cnt <= s_cnt + 1;
                            else
                                s_state <= WEST_WAIT;
                            end if;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;
                    when WEST_WAIT =>
                        -- Count up to c_DELAY_2SEC
                        if (s_cnt < c_DELAY_2SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= STOP2;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;
                    when STOP2 =>
                        -- Count up to c_DELAY_1SEC
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= SOUTH_GO;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;
                    when SOUTH_GO =>
                        -- Condition for staying in this state !!! Higher bit is North (South) and the lower is East (West)
                        if (input = "00" or input = "10") then
                            null;
                        elsif (input = "01") then
                            -- Move to the next state immedialently, because in South (North) direction is not car
                            s_state <= SOUTH_WAIT;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        elsif (input = "11") then
                            -- Move to the next state after 4 seconds, this prevents immedialent color switching.
                            if (s_cnt < c_DELAY_4SEC) then
                                s_cnt <= s_cnt + 1;
                            else
                                s_state <= SOUTH_WAIT;
                            end if;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;
                    when SOUTH_WAIT =>
                        -- Count up to c_DELAY_2SEC
                        if (s_cnt < c_DELAY_2SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= STOP1;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;
                    -- It is a good programming practice to use the 
                    -- OTHERS clause, even if all CASE choices have 
                    -- been made. 
                    when others =>
                        s_state <= STOP1;

                end case;
            end if; -- Synchronous reset
        end if; -- Rising edge
    end process p_smart_traffic_fsm;
```