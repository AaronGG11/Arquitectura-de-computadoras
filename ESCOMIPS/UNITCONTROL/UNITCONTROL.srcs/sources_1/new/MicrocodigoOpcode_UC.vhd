-- Module Name:    MicrocodigoOpcode - Behavioral 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity MicrocodigoOpcode_UC is
    Port ( dir : in  STD_LOGIC_VECTOR (4 downto 0);
           microOpcode : out  STD_LOGIC_VECTOR (19 downto 0));
end MicrocodigoOpcode_UC;

architecture Behavioral of MicrocodigoOpcode_UC is
type arreglo is array ( 0 to (2**5)-1 ) of std_logic_vector(19 downto 0);
constant aux : arreglo := (
    "00001000000001110001", -- VERIF 0
    "00000000010000000000", -- LI 1
    "00000100010000001000", -- LWI 2
    "00001000000000001100", -- SWI 3 
    "00001010000100110101", -- SW 4
    "00000100010100110011", -- ADDI 5
    "00000100010101110011", -- SUBI 6
    "00000100010100000011", -- ANDI 7
    "00000100010100010011", -- ORI 8
    "00000100010100100011", -- XORI 9
    "00000100010111010011", -- NANDI 10
    "00000100010111000011", -- NORI 11
    "00000100010110100011", -- XNORI 12
    "10010000001100110011", -- BEQI 13 
    "10010000001100110011", -- BNEI 14
    "10010000001100110011", -- BLTI 15
    "10010000001100110011", -- BLETI 16
    "10010000001100110011", -- BGTI 17
    "10010000001100110011", -- BGETI 18
    "00010000000000000000", -- B 19
    "01010000000000000000", -- CALL 20
    "00100000000000000000", -- RET 21
    "00000000000000000000", -- NOP 22
    "00000110010100110001", -- LW 23
others => (others => '0'));
begin

    microOpcode <= aux(conv_integer(dir));

end Behavioral;
