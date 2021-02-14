# Task 1
https://github.com/Matej-Podany/Digital-electronics-1

# Task 2
## 2.1
```vhdl
library ieee;               -- Standard library
use ieee.std_logic_1164.all;-- Package for data types and logic operations

------------------------------------------------------------------------
-- Entity declaration for basic gates
------------------------------------------------------------------------
entity gates is
    port(
        a_i        : in  std_logic;         -- Data input
        b_i        : in  std_logic;         -- Data input
        c_i        : in  std_logic;         -- Data input
        f_o        : out std_logic;         -- Output function
        fnand_o    : out std_logic;         -- Output function
        fnor_o     : out std_logic          -- Output function
    );
end entity gates;

------------------------------------------------------------------------
-- Architecture body for basic gates
------------------------------------------------------------------------
architecture dataflow of gates is
begin
	--Task 2
    f_o      <= ((not b_i) and a_i) or ((not c_i) and (not b_i));
    fnand_o  <= not ((not ((not b_i) and a_i)) and (not ((not c_i) and (not b_i))));
    fnor_o   <= (not (b_i or (not a_i))) or (not (c_i or b_i));

end architecture dataflow;
```

## 2.2
![De Morgan's law] (https://github.com/Matej-Podany/Digital-electronics-1/blob/main/Labs/01-gates/images/SimulationTask2.png?raw=true)

## 2.3
https://www.edaplayground.com/x/TE7b

# Task 3
