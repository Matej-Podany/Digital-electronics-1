# Cyklo tachometr (cyclo tachometer)

## Team members
Rajm Jan, 
Podaný Matěj, 
Rohal´ Pavol, 
Pelka Jan

[Project folder](https://github.com/Matej-Podany/Digital-electronics-1/tree/main/Labs/project)

## Project objectives
Naším cílem je vytvořit funkční cyklo tachometr. Na základě zadání jsme se rozhodli, že náš tachometr bude mít tři sedmi segmentové displeje, na kterých bude moci zobrazit aktuální rychlost, průměrnou rychlost a ujetou vzdálenost.
Důležitou informací pro uživatele je, že je tachometr určen pro kola s poloměrem 31,83 cm, což odpovídá obvodu kola 2 m. Také jsme si zvolili, že veškerá čísla zobrazená na displejích jsou v praktických jednotkách,
tj. aktuální rychlost v km/h, průměrná rychlost v km/h a ujetá vzdálenost v km. Limity funkčnosti tachometru jsou tedy nastaveny na jakékoli hodnoty, které jsou <= 999. Tachometr má dvě tlačítka, první přepíná mezi zobrazovanou informací,
přičemž první z nich je aktuální rychlost, pak průměrná rychlost a jako poslední je zde ujetá vzdálenost. Opětovným stisknutím dojde tedy k přepnutí zpět na aktuální rychlost. Druhé tlačítko funguje jako reset a při jeho stisku dojde
k vynulování uražené vzdálenosti a průměrné rychlosti.

## Hardware description
*Hodně si se zajímal o tuto část Pali, tak jestli chceš, můžeš to dokončit a PDF poslat zpět na Teams, já pak upravím to PDF na Githubu a budeme to moci odevzdat.
Může tu být co k tomu potřebujeme, A35 deska, navržená deska atd., ale ty víš lépe než já, co tu má být :D*

## VHDL modules description and simulations

### Schematic diagram
![OPTION schematic]( "OPTION schematic")

### OPTION
```vhdl
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
```

### tb_OPTION
```vhdl
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

library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------------------
entity tb_option is
    -- Entity of testbench is always empty
end entity tb_option;

------------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------
architecture testbench of tb_option is

    --Local signals
   
    signal s_btn_i        :  std_logic;
    signal s_choose_o     :  std_logic_vector(2-1 downto 0);
    --signal s_state        :  std_logic;
    signal s_state        :  std_logic; 

begin
    uut_option: entity work.option
        port map (
           
            btn_i     => s_btn_i,
            choose_o  => s_choose_o
            --state   => s_state
        );
   
    --------------------------------------------------------------------
    -- Data generation process - simulation button presses
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
            s_btn_i <= '0';
            wait for 200 ns;
            s_btn_i <= '1';
            wait for 20 ns;
            s_btn_i <= '0';
            wait for 50 ns;
            s_btn_i <= '1';
            wait for 10 ns;
            s_btn_i <= '0';
            wait for 350 ns;
            s_btn_i <= '1';
            wait for 10 ns;
            s_btn_i <= '0';
            wait for 150 ns;
            s_btn_i <= '1';
            wait for 10 ns;
            s_btn_i <= '0';
            wait for 20 ns;
            s_btn_i <= '1';
            wait for 20 ns;
            s_btn_i <= '0';
            wait;
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
end architecture testbench;
```

### simulation OPTION
![OPTION simulation]( "OPTION simulation")

### Schematic diagram
![CLOCK schematic]( "CLOCK schematic")

### CLOCK
```vhdl
----------------------------------------------------------------------------------
-- Company: VUT FEKT
-- Engineer: Matěj Podaný, Rajm Jan
-- 
-- Design Name: CLOCK
-- Module Name: CLOCK
-- Project Name: Cyclo tachometer
-- Target Devices: Nexys A7-35
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clock is
    generic(
            num_cycles : natural := 1 -- Number of generated cycles
    );
    Port ( clk1hz_o   : out STD_LOGIC; -- Output signal
           clk125hz_o : out STD_LOGIC -- Output signal
    );
    signal clk1hz   : std_logic; -- Output signal
    signal clk125hz : std_logic;-- Output signal
end clock;

architecture Behavioral of clock is

begin
    p_clk1hz : process
    begin
        for i in 1 to num_cycles loop -- Loop generating 1 hz pulse
            clk1hz_o <= '1';          
            wait for 500 ms;
            clk1hz_o <= '0';
            wait for 500 ms;          
        end loop;
    end process p_clk1hz;

    p_clk125hz : process
    begin
        for i in 1 to num_cycles loop -- Loop generating 125 hz pulse
            clk125hz_o <= '1';          
            wait for 4 ms;
            clk125hz_o <= '0';
            wait for 4 ms;          
        end loop;
    end process p_clk125hz;
end Behavioral;
```

### tb_CLOCK
```vhdl
----------------------------------------------------------------------------------
-- Company: VUT FEKT
-- Engineer: Matěj Podaný, Rajm Jan
-- 
-- Design Name: CLOCK
-- Module Name: CLOCK
-- Project Name: Cyclo tachometer
-- Target Devices: Nexys A7-35
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_clock is
--  Port ( );
end tb_clock;

architecture Behavioral of tb_clock is
    signal s_clk1hz : std_logic;
    signal s_clk125hz : std_logic;
begin
    uut_clock : entity work.clock
        port map(
            clk1hz_o   => s_clk1hz,
            clk125hz_o => s_clk125hz
                );
end Behavioral;
```

### simulation CLOCK
![CLOCK simulation 1]( "CLOCK simulation 1")
![CLOCK simulation 2]( "CLOCK simulation 2")

### Schematic diagram
![COMPUTATION schematic]( "COMPUTATION schematic")

### COMPUTATION
```vhdl
----------------------------------------------------------------------------------
-- Company: VUT FEKT
-- Engineer: Rajm Jan
-- 
-- Design Name: COMPUTATION
-- Module Name: COMPUTATION
-- Project Name: Cyclo tachometer
-- Target Devices: Nexys A7-35
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity computation is
  Port ( 
    status_i   : in std_logic_vector(2-1 downto 0);
    reset_i    : in std_logic;
    clk1hz_i   : in std_logic;
    sensor_i   : in std_logic;
    value_o    : out std_logic_vector(10-1 downto 0)
  );
end computation;

architecture Behavioral of computation is
    signal s_avg_velocity : std_logic_vector(10-1 downto 0);
    signal s_velocity     : std_logic_vector(10-1 downto 0);
    signal s_distance     : std_logic_vector(10-1 downto 0);
    signal s_value        : std_logic_vector(10-1 downto 0);
begin
p_velocity : entity work.velocity
        port map(
        -- submodule => top module
            clk1hz_i   => clk1hz_i,
            sensor_i   => sensor_i,
            velocity_o => s_velocity
        );

p_avg_velocity : entity work.e_avg_velocity 
        port map(
            clk1hz_i       => clk1hz_i,
            reset_i        => reset_i,
            vel2avg_i      => s_velocity,
            avg_velocity_o => s_avg_velocity
        );
        
p_distance : entity work.distance 
        port map(
            sensor_i   => sensor_i,
            reset_i    => reset_i,
            distance_o => s_distance
        );
        
p_output : entity work.output 
        port map(
            clk1hz_i       => clk1hz_i,
            status_i       => status_i,
            distance_i     => s_distance,
            avg_velocity_i => s_avg_velocity,
            velocity_i     => s_velocity,
            value_o        => s_value
        );
end Behavioral;
```

### tb_COMPUTATION
```vhdl
----------------------------------------------------------------------------------
-- Company: VUT FEKT
-- Engineer: Rajm Jan
-- 
-- Design Name: COMPUTATION
-- Module Name: COMPUTATION
-- Project Name: Cyclo tachometer
-- Target Devices: Nexys A7-35
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_computation is
--  Port ( );
end tb_computation;

architecture Behavioral of tb_computation is
    signal s_status : std_logic_vector(2-1 downto 0);
    signal s_reset  : std_logic;
    signal s_clk    : std_logic;
    signal s_sensor : std_logic;
    
begin
uut_computation: entity work.computation
        port map (
            status_i => s_status,
            reset_i  => s_reset,
            clk1hz_i => s_clk,
            sensor_i => s_sensor
            
        );

p_reset_gen : process
    begin
        s_reset <= '0';
        wait for 7128 ms; -- reset during avarage velocity
        s_reset <= '1';
        wait for 53 ms;
        s_reset <= '0';
        wait for 4128 ms; -- reset during distance
        s_reset <= '1';
        wait for 53 ms;
        s_reset <= '0';
        wait;
    end process p_reset_gen;
    
p_status : process
    begin
        s_status <= "00"; -- velocity
        wait for 4000 ms;
        s_status <= "01"; -- avg. velocity
        wait for 4000 ms;
        s_status <= "10";
        wait for 4000 ms; -- distance
        s_status <= "11"; -- intentionaly unexpected value, should display velocity
        wait for 4000 ms;
        wait;
    end process p_status;
    
p_clk1hz : process
    begin
        while now < 16000 ms loop         
            s_clk <= '1';
            wait for 500 ms;
            s_clk <= '0';
            wait for 500 ms;
        end loop;
        wait;
    end process p_clk1hz;
    
p_sensor : process
    begin
    -----------------------------
    -- many signal assignments --
    -----------------------------
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        
        -- slower 300 ms
        
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        
        --
        
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        
        -- 
        
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        
        --
        
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        s_sensor <= '0';
        wait for 10 ms;
        s_sensor <= '1';
        wait for 10 ms;
        
        -- slower 300 ms
        
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        
        --
        
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        s_sensor <= '0';
        wait for 150 ms;
        s_sensor <= '1';
        wait for 150 ms;
        
        -- 
        
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        s_sensor <= '0';
        wait for 50 ms;
        s_sensor <= '1';
        wait for 50 ms;
        
        wait;
end process p_sensor;

end Behavioral;
```

### simulation COMPUTATION
![COMPUTATION simulation 1]( "COMPUTATION simulation 1")
![COMPUTATION simulation 2]( "COMPUTATION simulation 2")

### Schematic diagram
![DISPLAYER schematic]( "DISPLAYER schematic")

### DISPLAYER
```vhdl
----------------------------------------------------------------------------------
-- Company: VUT FEKT
-- Engineer: Rohal´ Pavol
-- 
-- Design Name: DISPLAYER
-- Module Name: DISPLAYER
-- Project Name: Cyclo tachometer
-- Target Devices: Nexys A7-35
-- 
----------------------------------------------------------------------------------

library ieee;               
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------------------
-- Entity declaration 
------------------------------------------------------------------------

entity displayer is                                             --entity of displayer block (all requier inputs/outputs)
    port(
        clk125hz_i  : in std_logic;
        value_i     : in std_logic_vector(10 - 1 downto 0);       
        display_o   : out std_logic_vector(4 - 1 downto 0);        
        seg_o       : out std_logic_vector(3 - 1 downto 0);
        cnt         : out std_logic_vector(2 - 1 downto 0)      --outputing <cnt> only for visualizing in WF
    );
end entity displayer;

------------------------------------------------------------------------
-- Architecture 
------------------------------------------------------------------------

architecture dataflow of displayer is
    signal dec, s_d1, s_d2, s_d3 : integer;     --define signal for decimal conversion and for individual segments
    signal s_count : integer := 0;              --value of start point for counter  
    
    begin   
        p_stimulus: process(clk125hz_i, s_count)
        begin
        
        if rising_edge(clk125hz_i) then s_count <= s_count + 1;    --counter from 0 to 2 for selecting segments which depends on clock
        end if;
        if s_count = 3 then s_count <= 0;
        end if;
        
        cnt <= std_logic_vector(to_unsigned(s_count, 2));       --write counter value to <cnt> signal
        dec <= to_integer(unsigned(value_i));                   --conversion input value from binary array to integer
        s_d1 <= dec/100;                                        --separation of individual numbers from converted input value
        s_d2 <= (dec/10)-(s_d1*10);
        s_d3 <= dec-(s_d1*100)-(s_d2*10);

        case s_count is                                                                             --case statment for writing individual data to specific segment
            when 0 => display_o <= std_logic_vector(to_unsigned(s_d1, 4)); seg_o <= "001";
            when 1 => display_o <= std_logic_vector(to_unsigned(s_d2, 4)); seg_o <= "010";
            when others => display_o <= std_logic_vector(to_unsigned(s_d3, 4)); seg_o <= "100";
        end case;
    end process p_stimulus;
end architecture dataflow;
```

### tb_DISPLAYER
```vhdl
----------------------------------------------------------------------------------
-- Company: VUT FEKT
-- Engineer: Rohal´ Pavol
-- 
-- Design Name: DISPLAYER
-- Module Name: DISPLAYER
-- Project Name: Cyclo tachometer
-- Target Devices: Nexys A7-35
-- 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------------------

entity tb_displayer is
    -- Entity of testbench is always empty
end entity tb_displayer;

------------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------

architecture testbench of tb_displayer is       --define all require signals and constant for clocking

    constant c_CLK_125HZ_PERIOD : time    := 8 ms;
    
    signal s_clk_125Hz  : std_logic;
    signal s_value      : std_logic_vector(10 - 1 downto 0);
    signal s_display    : std_logic_vector(4 - 1 downto 0);
    signal s_cnt        : std_logic_vector(2 - 1 downto 0);
    signal s_seg        : std_logic_vector(3 - 1 downto 0);

begin
    uut_displayer : entity work.displayer       --porting all inputs/outputs
        port map(
            cnt         => s_cnt,
            clk125Hz_i  => s_clk_125Hz,
            value_i     => s_value,
            display_o   => s_display,
            seg_o       => s_seg
        );
        
    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    
    p_stimulus : process                     -- process for simulating data for all digit excep 0
    begin
        s_value <= "1000100011";             --in dec 547
        wait for 1 sec;
        s_value <= "0001001111";			 --in dec 79
        wait for 1 sec;
        s_value <= "0000001000";		   	 --in dec 8
        wait for 1 sec;
        s_value <= "1111000010";		   	 --in dec 962
        wait for 1 sec;
        s_value <= "0101011110";		   	 --in dec 350
        wait for 1 sec;
        wait;                   -- Process is suspended forever
    end process p_stimulus;
    
    --------------------------------------------------------------------
    -- Clock generator process for 125kHz for display
    --------------------------------------------------------------------

    clk_gen : process
        begin
            while now < 5 sec loop        
                s_clk_125Hz <= '0';
                wait for c_CLK_125HZ_PERIOD;
                s_clk_125Hz <= '1';
                 wait for c_CLK_125HZ_PERIOD;
            end loop;
            wait;           -- Process is suspended forever
       end process clk_gen;
end architecture testbench;
```

### simulation DISPLAYER
![DISPLAYER simulation 1]( "DISPLAYER simulation 1")
![DISPLAYER simulation 2]( "DISPLAYER simulation 2")
![DISPLAYER simulation 3]( "DISPLAYER simulation 3")

### External module
DISPLAYER dává přímo informaci display_o pro externí navrženou desku se třemi sedmi segmentovými displeji. Zde máme jeho navržené schéma:
![External module]( "External module")
Externí modul si sám převede číselnou informaci ve 4 bitové binární podobě na 7 bitovou infomaci pro sedmi segmentový displej, přičemž jeden bit je pro jeden segment displeje.
Jeho nákres na desce plošných spojů:
![Printed circuit board]( "Printed circuit board")

### p_VELOCITY
```vhdl
----------------------------------------------------------------------------------
-- Company: VUT FEKT
-- Engineer: Pelka Jan, Matěj Podaný
-- 
-- Design Name: p_VELOCITY
-- Module Name: COMPUTATION
-- Project Name: Cyclo tachometer
-- Target Devices: Nexys A7-35
-- 
----------------------------------------------------------------------------------

library ieee;
use IEEE.math_real.all;                 -- Needed for power
use ieee.std_logic_1164.all;            -- Basic library
use ieee.numeric_std.all;               -- Needed for shifts

entity velocity is
    Port (
        clk1hz_i           : in std_logic;
        velocity_o         : out STD_logic_vector(10-1 downto 0)  := "0000000000";
        sensor_i           : in std_logic
    );
end velocity;
 
architecture behave of velocity is

begin
 
p_velocity : process(clk1hz_i)

  variable counter          : integer    := 0; 
  variable var1             : integer    := 0; 
  variable var2             : STD_logic_vector(10-1 downto 0);
                                                
    begin
    
    if rising_edge(sensor_i) then
        counter := counter + 1; 					-- if sensor detect magnet couter count it


    end if;

    if rising_edge(clk1hz_i) then 
        var1 := (counter*36)/5; 					-- calculating speed
        var2 := std_logic_vector(to_unsigned(var1, var2'length)); 	-- geting right data type
        velocity_o <= var2; 						-- instert data to output variable
        counter := 0; 							-- reseting counter
    end if;
  end process p_velocity;
end architecture behave;
```

### tb_p_VELOCITY
```vhdl
----------------------------------------------------------------------------------
-- Company: VUT FEKT
-- Engineer: Pelka Jan, Matěj Podaný
-- 
-- Design Name: p_VELOCITY
-- Module Name: COMPUTATION
-- Project Name: Cyclo tachometer
-- Target Devices: Nexys A7-35
-- 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity tb_distance is
end entity tb_distance;

architecture testbench of tb_distance is

    signal s_sensor     :  std_logic;
    signal s_clk1hz     :  std_logic;
    signal s_velocity   :  std_logic_vector(10-1 downto 0);
    
    
begin
    uut_velocity: entity work.velocity
        port map (
            
        clk1hz_i => s_clk1hz,  
        velocity_o => s_velocity,
        sensor_i => s_sensor
        );
        
    gen_clock : process
    begin
        s_clk1hz <= '1';
        wait for 500ms;
        s_clk1hz <= '0';
        wait for 500ms;
        s_clk1hz <= '1';
        wait for 500ms;
        s_clk1hz <= '0';
        wait for 500ms;
        s_clk1hz <= '1';
        wait for 500ms;
        s_clk1hz <= '0';
        wait for 500ms;
        s_clk1hz <= '1';
        wait for 500ms;
        s_clk1hz <= '0';
        wait for 500ms;
        wait;
    end process gen_clock;

    p_stimulus : process
    begin
        s_sensor <= '1';
        wait for 500ms;
        s_sensor <= '0';
        wait for 500ms;
        
        s_sensor <= '1';
        wait for 250ms;
        s_sensor <= '0';
        wait for 250ms;
        s_sensor <= '1';
        wait for 250ms;
        s_sensor <= '0';
        wait for 250ms;
        s_sensor <= '1';
        wait for 250ms;
        s_sensor <= '0';
        wait for 250ms;
        s_sensor <= '1';
        wait for 250ms;
        s_sensor <= '0';
        wait for 250ms;

        s_sensor <= '1';
        wait for 100ms;
        s_sensor <= '0';
        wait for 100ms;
        s_sensor <= '1';
        wait for 100ms;
        s_sensor <= '0';
        wait for 100ms;
        s_sensor <= '1';
        wait for 100ms;
        s_sensor <= '0';
        wait for 100ms;
        s_sensor <= '1';
        wait for 100ms;
        s_sensor <= '0';
        wait for 100ms;
        s_sensor <= '1';
        wait for 100ms;
        s_sensor <= '0';
        wait for 100ms;
        
        wait;
    end process p_stimulus;
end architecture testbench;
```

### simulation p_VELOCITY
![p_VELOCITY simulation]( "p_VELOCITY simulation")

### p_AVG_VELOCITY
```vhdl
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
use IEEE.math_real.all;                 -- Needed for power
use ieee.std_logic_1164.all;            -- Basic library
use ieee.numeric_std.all;               -- Needed for shifts

entity e_avg_velocity is
    Port (
        clk1hz_i       : in std_logic;
        reset_i        : in std_logic;
        vel2avg_i      : in std_logic_vector(10-1 downto 0);
        avg_velocity_o : out std_logic_vector(10-1 downto 0)  := "0000000000"  
    );
end e_avg_velocity;
 
architecture behave of e_avg_velocity is

  signal sum_of_velocities     : unsigned(10-1 downto 0) := "0000000000";
  
begin
 
p_avg_velocity : process(clk1hz_i, reset_i)

  variable count_of_shifts     : integer    := 1;
  variable clk_cycles          : integer    := 2; -- states for how many clock cycles does signal sum_of_velocities adds samples of 
                                                  --   velocity and for how long does process wait for division
    begin
    
    if rising_edge(reset_i) then
        avg_velocity_o      <= "0000000000"; -- zeroing value of avarage velocity
        sum_of_velocities   <= "0000000000"; -- zeroing of sum of velocities
        count_of_shifts := 1;
        clk_cycles      := 2; -- shift of one bit correspondents with waiting for two samples os velocity to be summed
    else
        if rising_edge(clk1hz_i) then 
                    
            sum_of_velocities <= sum_of_velocities + unsigned(vel2avg_i);             
                
            if clk_cycles = 0 then
                avg_velocity_o <= std_logic_vector(shift_right(unsigned(sum_of_velocities), count_of_shifts)); -- division of summed velocities 
                count_of_shifts := count_of_shifts + 1;                                    --   in order to compute avarage velocity
                clk_cycles := 2**(count_of_shifts - 1); 
            end if;
        
            clk_cycles := clk_cycles - 1;        
          
        end if;
    end if;
  end process p_avg_velocity;
end architecture behave;
```

### tb_p_AVG_VELOCITY
```vhdl
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
```

### simulation p_AVG_VELOCITY
![p_AVG_VELOCITY simulation 1]( "p_AVG_VELOCITY simulation 1")
![p_AVG_VELOCITY simulation 2]( "p_AVG_VELOCITY simulation 2")
![p_AVG_VELOCITY simulation 3]( "p_AVG_VELOCITY simulation 3")
![p_AVG_VELOCITY simulation 4]( "p_AVG_VELOCITY simulation 4")

### p_DISTANCE
```vhdl
----------------------------------------------------------------------------------
-- Company: VUT FEKT
-- Engineer: Rajm Jan, Matěj Podaný
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
    reset_i    : in std_logic;
    distance_o : out std_logic_vector(10-1 downto 0) := "0000000000"
  );
end distance;

architecture Behavioral of distance is

    signal s_distance : unsigned(10-1 downto 0) := "0000000000"; -- necessary for summing

    begin
        p_distance : process(sensor_i, reset_i)
        
        variable sum : integer := 0; -- counts input signals 
        
        begin
            if rising_edge(reset_i) then
                sum := 0;
                s_distance <= "0000000000";
            else
                if rising_edge(sensor_i) then
                    sum := sum + 1;
                    if sum > 5 then --for simulation purpouse, in application: if sum > 500 then (...). We consider wheel with circuit of 2m thus 1km means 500 revolutions. 
                      sum := 0;
                      s_distance <= s_distance + "0000000001";    
                    end if;
                    --distance_o <= std_logic_vector(s_distance);
                 end if;
                 
                 distance_o <= std_logic_vector(s_distance);
                 
            end if;
        end process p_distance;
        
end Behavioral;
```

### tb_p_DISTANCE
```vhdl
----------------------------------------------------------------------------------
-- Company: VUT FEKT
-- Engineer: Rajm Jan, Matěj Podaný
-- 
-- Design Name: p_DISTANCE
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
entity tb_distance is
    -- Entity of testbench is always empty
end entity tb_distance;

------------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------
architecture testbench of tb_distance is

    signal s_signal     :  std_logic;
    signal reset        :  std_logic;
    signal s_distance   :  std_logic_vector(10-1 downto 0);
    
begin
    uut_driver_7_seg: entity work.distance
        port map (
            
            sensor_i     =>  s_signal,
            reset_i    =>  reset,
            distance_o => s_distance
        );
    p_reset_gen : process
    begin
        reset <= '0';
        wait for 500 ns;
        reset <= '1';
        wait for 53 ns;
        reset <= '0';
        wait;
    end process p_reset_gen;
    
    p_stimulus : process
    begin
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';     
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';     
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';     
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        s_signal <= '0';
        wait for 10 ns;
        s_signal <= '1';
        wait for 10 ns;
        
        wait;
    end process p_stimulus;
end architecture testbench;
```

### simulation p_DISTANCE
![p_DISTANCE simulation 1]( "p_DISTANCE simulation 1")
![p_DISTANCE simulation 2]( "p_DISTANCE simulation 2")

### p_OUTPUT
```vhdl
----------------------------------------------------------------------------------
-- Company: VUT FEKT
-- Engineer: Rajm Jan
-- 
-- Design Name: p_OUTPUT
-- Module Name: COMPUTATION
-- Project Name: Cyclo tachometer
-- Target Devices: Nexys A7-35
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity output is
  Port ( 
    clk_i          : in  std_logic;
    status_i       : in  std_logic_vector(2-1 downto 0);
    distance_i     : in  std_logic_vector(10-1 downto 0);
    avg_velocity_i : in  std_logic_vector(10-1 downto 0);
    velocity_i     : in  std_logic_vector(10-1 downto 0);
    value_o        : out std_logic_vector(10-1 downto 0)
  );
end output;

architecture Behavioral of output is

begin
p_output : process(status_i, clk_i)
    begin
        if rising_edge(clk_i) then
            case status_i is
                when "00" =>
                    value_o <= velocity_i;
                when "01" =>
                    value_o <= avg_velocity_i;
                when "10" =>
                    value_o <= distance_i;
                when others =>
                    value_o <= velocity_i;
            end case;
        end if;
    end process p_output;

end Behavioral;
```

### tb_p_OUTPUT
```vhdl
----------------------------------------------------------------------------------
-- Company: VUT FEKT
-- Engineer: Rajm Jan
-- 
-- Design Name: p_OUTPUT
-- Module Name: COMPUTATION
-- Project Name: Cyclo tachometer
-- Target Devices: Nexys A7-35
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_clock is
--  Port ( );
end tb_clock;

architecture Behavioral of tb_clock is
    signal s_clk          :  std_logic;
    signal s_status       :  std_logic_vector(2-1 downto 0);
    signal s_distance     :  std_logic_vector(10-1 downto 0);
    signal s_avg_velocity :  std_logic_vector(10-1 downto 0);
    signal s_velocity     :  std_logic_vector(10-1 downto 0);
    signal s_value        :  std_logic_vector(10-1 downto 0);
begin
    uut_clock : entity work.output
        port map(
            clk_i          => s_clk,
            status_i       => s_status,
            distance_i     => s_distance,
            avg_velocity_i => s_avg_velocity,
            velocity_i     => s_velocity,
            value_o        => s_value
                );
                
    p_clk_gen : process
    begin
        while now < 750 ns loop         -- 75 periods of 100MHz clock
            s_clk <= '0';
            wait for 2 ns;
            s_clk <= '1';
            wait for 2 ns;
        end loop;
        wait;
    end process p_clk_gen;
                
    p_status : process
    begin
        s_status <= "00";
        wait for 200 ns;
        s_status <= "01";
        wait for 200 ns;
        s_status <= "10";
        wait for 200 ns;
        s_status <= "11"; -- intentionaly unexpected value    
    end process p_status;
    
    p_distance : process
    begin
        s_distance <= "0000000000";
        wait for 45 ns;
        s_distance <= "0000000001";
        wait for 45 ns;
        s_distance <= "0000000010";
        wait for 45 ns;
        s_distance <= "0000000011";
        wait for 45 ns;
        s_distance <= "0000000100";
        wait for 45 ns;
        s_distance <= "0000000101";
        wait for 45 ns;
        s_distance <= "0000000110";
        wait for 45 ns;
        s_distance <= "0000000111";
        wait for 45 ns;
        s_distance <= "0000001000";
        wait for 45 ns;
        s_distance <= "0000001001";
        wait for 45 ns;
        s_distance <= "0000001010";
        wait for 45 ns;
        s_distance <= "0000001011";
        wait for 45 ns;
        s_distance <= "0000001100";
        wait;
    end process p_distance;
    
    p_avg_velocity : process
    begin
        s_avg_velocity <= "0000000000";
        wait for 60 ns;
        s_avg_velocity <= "0000000010";
        wait for 60 ns;
        s_avg_velocity <= "0000000011";
        wait for 60 ns;
        s_avg_velocity <= "0000000101";
        wait for 60 ns;
        s_avg_velocity <= "0000000110";
        wait for 60 ns;
        s_avg_velocity <= "0000000101";
        wait for 60 ns;
        s_avg_velocity <= "0000000100";
        wait for 60 ns;
        s_avg_velocity <= "0000000110";
        wait for 60 ns;
        s_avg_velocity <= "0000001000";
        wait for 60 ns;
        s_avg_velocity <= "0000000111";
        wait for 60 ns;
        s_avg_velocity <= "0000000100";
        wait for 60 ns;
        s_avg_velocity <= "0000000101";
        wait for 60 ns;
        wait;
    end process p_avg_velocity;
    
    p_velocity : process
    begin
        s_velocity <= "0000000010";
        wait for 60 ns;
        s_velocity <= "0000000100";
        wait for 60 ns;
        s_velocity <= "0000000010";
        wait for 60 ns;
        s_velocity <= "0000000110";
        wait for 60 ns;
        s_velocity <= "0000011000";
        wait for 60 ns;
        s_velocity <= "0000001010";
        wait for 60 ns;
        s_velocity <= "0000001100";
        wait for 60 ns;
        s_velocity <= "0000000011";
        wait for 60 ns;
        s_velocity <= "0000001010";
        wait for 60 ns;
        s_velocity <= "0000000111";
        wait for 60 ns;
        s_velocity <= "0000000100";
        wait for 60 ns;
        s_velocity <= "0000001001";
        wait for 60 ns;
        wait;
    end process p_velocity;
    
end Behavioral;
```

### simulation p_OUTPUT
![p_OUTPUT simulation 1]( "p_OUTPUT simulation 1")
![p_OUTPUT simulation 2]( "p_OUTPUT simulation 2")

## TOP module description and simulations (Arty A7-35)

### Schematic diagram
![TOP schematic]( "TOP schematic")

### TOP
```vhdl

```

### tb_TOP
```vhdl

```

### simulation TOP
![TOP simulation 1]( "TOP simulation 1")
![TOP simulation 2]( "TOP simulation 2")

## Video

*Write your text here*

## Project valorization
Stanovené cíle v sekci "project objectives" se nám podařilo z většiny splnit. Navržená deska se třemi sedmi segmentovými displeji funguje dobře počet displejů pro cyklo tachometr je dostačující.
Podařilo se nám naprogramovat bezchybně počítání uražené vzdálenosti za ideální situace. To znamená, že poloměr kola, a tedy i jeho obvod je konstantní a kolo je nepřetržitě v kontaktu s cestou, přičemž nikdy neprokluzuje.
Také jsme úspěšně vytvořili modul pro počítání průměrné rychlosti, který pomocí informace o aktuální rychlosti počítá váženým průměrem průměrnou rychlost. Jeho přesnost je vysoká, avšak dochází k zanedbatelnému zaokroluhlování
na celá čísla, což ale způsobí přesnost na +- 1 km/h. Modul aktuální rychlosti je bohužel v nedostatečné kvalitě a jeho jednoduchý princip umožňuje ukázat rychlost pouze s přesností +- 3,5 km/h. Hodnoty, které dokáže
zobrazit jsou 0 a násobky 7. Ostatní prvky jako tlačítka pro přepínání zobrazované informace a pro reset fungují bezchybně. Do budoucna by se tedy dalo rozhodně zlepšit modul aktuální rychlosti, který nevyhovuje
našim stanoveným parametrům. Dále by se dalo vytvořit nastavení obvodu kola, které by mnohonásobně rozšířilo použitelnost tohoto cyklo tachometru. Závěrem tedy bych považoval projekt za úspěšný, který nám dal hodně
zkušeností. Jsou tu nedostatky, avšak velmi dobře fungujících věcí je tu převaha.
 
## References

   1. Digilent - [**Arty A7-35 schematic**](https://reference.digilentinc.com/_media/reference/programmable-logic/arty-a7/arty_a7_sch.pdf)
   2. Digilent - [**Arty A7-35 reference manual**](https://reference.digilentinc.com/reference/programmable-logic/arty-a7/reference-manual)