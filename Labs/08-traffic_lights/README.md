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


## 2.3


## 2.4
![Simulation1](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/08-traffic_lights/images/Simulation1.jpg "Simulation1")

# Task 3
## 3.1
Input: 00
 North_||_East

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
In states Stop1, Stop2, WestWait and SouthWait there is not input displayed, because this states does NOT depends on inputs (car sensors).
They have fixed time delay (Start => Stop1: 1 second red => WestGO: -conditions in table- => WestWait: 2 seconds yellow => Stop2) and it is same for both directions.
I just want to saz, that if there are cars from both directions, green will be in one direction 4 seconds. If there is green in one direction and in the same direction is car, at the moment, when car
will drive from another direction, will green last for 4 seconds before it changes to orange, then red and then green for another direction (to prevent instant changing of lights).
![Figure3](https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/08-traffic_lights/images/Figure3.jpg "Figure3")

## 3.3
