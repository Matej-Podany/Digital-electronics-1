# Cyklo tachometr (cyclo tachometer)

## Team members
Rajm Jan
Podaný Matěj
Rohal´ Pavol
Pelka Jan

[Project folder](https://github.com/Matej-Podany/Digital-electronics-1/tree/main/Labs/project)

## Project objectives
Naším cílem je vytvořit funkční cyklo tachometr. Na základě zadání jsme se rozhodli, že náš tachometr bude mít tři sedmisegmentové displeje, na kterých bude moci zobrazit aktuální rychlost, průměrnou rychlost a ujetou vzdálenost.
Důležitou informací pro uživatele je, že je tachometr určen pro kola s poloměřem 31,83 cm, což odpovídá obvodu kola 2 m. Také jsme si zvolili, že veškerá čísla zobrazená na displejích jsou v praktických jednotkách,
tj. aktuální rychlost v km/h, průměrná rychlost v km/h a ujetá vzdálenost v km. Limity funkčnosti tachometru jsou tedy nastaveny na jakékoli hodnoty, které jsou <= 999. Tachometr má dvě tlačítka, první přepíná mezi zobrazovanou informací,
přičemž první z nich je aktuální rychlost, pak průměrná rychlost a jako poslední je zde ujetá vzdálenost. Opětovným stisknutím dojde tedy k přepnutí zpět na aktuální rychlost. Druhé tlačítko funkuje jako reset a při jeho stisku dojde
k vynulování uražené vzdálenosti a průměrné rychlosti.

## Hardware description
*Hodně si se zajímal o tuto číst Pali, tak jestli chceš, můžeš to dokončit a PDF poslat zpět na Teams, já pak upravím to PDF na Githubu a budeme to moci odevzdat.
Může tu být co k tomu potřebujeme, A35 deska, navržená deska atd., ale ty víš lépe nežjá, co tu má být :D*

## VHDL modules description and simulations

### Schematic diagram
![OPTION schematic]( "OPTION schematic")

### OPTION
```vhdl

```

### tb_OPTION
```vhdl

```
### simulation
![OPTION simulation]( "OPTION simulation")

### Schematic diagram
![CLOCK schematic]( "CLOCK schematic")

### CLOCK
```vhdl

```

### tb_CLOCK
```vhdl

```
### simulation
![CLOCK simulation]( "CLOCK simulation")

### Schematic diagram
![COMPUTATION schematic]( "COMPUTATION schematic")

### COMPUTATION
```vhdl

```

### tb_COMPUTATION
```vhdl

```
### simulation
![COMPUTATION simulation]( "COMPUTATION simulation")

### Schematic diagram
![DISPLAYER schematic]( "DISPLAYER schematic")

### DISPLAYER
```vhdl

```

### tb_DISPLAYER
```vhdl

```
### simulation
![DISPLAYER simulation]( "DISPLAYER simulation")

### p_VELOCITY
```vhdl

```

### tb_p_VELOCITY
```vhdl

```

### simulation
![p_VELOCITY simulation]( "p_VELOCITY simulation")

### p_AVG_VELOCITY
```vhdl

```

### tb_p_AVG_VELOCITY
```vhdl

```
### simulation
![p_AVG_VELOCITY simulation]( "p_AVG_VELOCITY simulation")

### p_DISTANCE
```vhdl

```

### tb_p_DISTANCE
```vhdl

```
### simulation
![p_DISTANCE simulation]( "p_DISTANCE simulation")

### p_OUTPUT
```vhdl

```

### tb_p_OUTPUT
```vhdl

```
### simulation
![p_OUTPUT simulation]( "p_OUTPUT simulation")

## TOP module description and simulations (Arty A7-35)

### Schematic diagram
![TOP schematic]( "TOP schematic")

### TOP
```vhdl

```

### tb_TOP
```vhdl

```
### simulation
![TOP simulation]( "TOP simulation")

## Video

*Write your text here*

## Project valorization
Stanovené cíle v sekci "project objectives" se ná podařilo z většiny splnit. Navržená deska se třemi sedmisegmentovými displeji funguje dobře počet displejů pro cyklo tachometr je dostačující.
Podařilo se nám naprogramovat bezchybně počítání uražené vzdálenosti za ideální situace. To znamená, že poloměr kola a tedy i jeho obvod je konstantní a kolo je nepřetržitě v kontaktu s cestou, přičemž nikdy neprokluzuje.
Také jsme uspěšně vytvořili modul pro počítání průměrné rychlosti, který pomocí informace o aktuální rychlosti počítá váženým průměrem průměrnou rychlost. Jeho přesnost je vysoká, avšak dochází k zanedbatelnému zaorkoluhlování
na celá čisla, což ale způsobí přesnost na +- 1 km/h. Modul aktuální rychlosti je bohužel v nedostatečné kvalitě a jeho jednoduchý princip umožňuje ukázat rychlost pouze s přesností +- 3,5 km/h. Hodnoty, které dokáže
zobrazit jsou 0 a násobky 7. Ostatní prvky jako tlačítka pro přepínání zobrazované informace a pro reset fungují bezchybně. Do budoucna by se tedy dalo rozhodně zlepšit modul aktuální rychlosti, který nebyhovuje
našim stanoveným parametrům. Dále by se dalo vytvořit nastavení obvodu kola, které by mnohonásobně rozšířilo použitelnost tohoto cyklo tachometru. Závěrem tedy bych považoval projekt za úspěšný, který nám dal hodně
zkušeností. Jsou tu nedostatky, avšak velmi dobře fungujících věcí je tu převaha.
 
## References

   1. Write your text here.