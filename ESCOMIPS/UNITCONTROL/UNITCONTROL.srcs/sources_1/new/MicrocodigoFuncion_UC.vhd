-- Module Name:    MicrocodigoFuncion - Behavioral 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity MicrocodigoFuncion_UC is
    Port ( 
        dir : in  STD_LOGIC_VECTOR (3 downto 0);
        microFuncion : out  STD_LOGIC_VECTOR (19 downto 0));
end MicrocodigoFuncion_UC;

architecture Behavioral of MicrocodigoFuncion_UC is
type arreglo is array ( 0 to (2**4)-1 ) of std_logic_vector(19 downto 0);
constant aux : arreglo := (
    "00000100010000110011", --ADD 0
    "00000100010001110011",	--SUB 1
    "00000100010000000011",	--AND 2
    "00000100010000010011",	--OR 3
    "00000100010000100011",	--XOR 4
    "00000100010011010011",	--NAND 5
    "00000100010011000011",	--NOR 6
    "00000100010010100011",	--XNOR 7
    "00000100010011010011",	--NOT 8
    "00000001110000000000",	--SLL 9
    "00000001010000000000",	--SRL 10
    others => (others => '0')
);
begin
    microFuncion <= aux(conv_integer(dir));	
end Behavioral;

