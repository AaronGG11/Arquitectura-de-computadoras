library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity MOpCode is
    generic ( n : integer := 5 );
    Port (
        codigo_operacion : in STD_LOGIC_VECTOR(n-1 downto 0);
        microinstruccion : out STD_LOGIC_VECTOR (19 downto 0)
    );
end MOpCode;

architecture Behavioral of MOpCode is
    -- Declaracion de microinstrucciones (Todas menos tipo R)
    -- SDMP UP DW WPC SR2 SWD SEXT SHE DIR WR SOP1 SOP2 ALUOP3 ALUOP2 ALUOP1 ALUOP0 SDMD WD SR LF
    
    constant VERIFICACION : STD_LOGIC_VECTOR(19 downto 0) := "00001000000001110001"; -- VERIFICACION 0 
    constant LI : STD_LOGIC_VECTOR(19 downto 0) := "00000000010000000000"; -- LI 1
    constant LWI : STD_LOGIC_VECTOR(19 downto 0) := "00001100010000001000"; -- LWI 2
    constant SWI : STD_LOGIC_VECTOR(19 downto 0) := "00001000000000001100"; -- SWI 3
    constant SW : STD_LOGIC_VECTOR(19 downto 0) := "00001010000100110101"; -- SW 4
    
    constant ADDI : STD_LOGIC_VECTOR(19 downto 0) := "00000100010100110011"; -- ADDI 5
    constant SUBI : STD_LOGIC_VECTOR(19 downto 0) := "00000100010101110011"; -- SUBI 6
    
    constant ANDI : STD_LOGIC_VECTOR(19 downto 0) := "00000100010100000011"; -- ANDI 7
    constant ORI : STD_LOGIC_VECTOR(19 downto 0) := "00000100010100010011"; -- ORI 8
    constant XORI : STD_LOGIC_VECTOR(19 downto 0) := "00000100010100100011"; -- XORI 9
    constant NANDI : STD_LOGIC_VECTOR(19 downto 0) := "00000100010111010011"; -- NANDI 10
    constant NORI : STD_LOGIC_VECTOR(19 downto 0) :=  "00000100010111000011"; -- NORI 11
    constant XNORI : STD_LOGIC_VECTOR(19 downto 0) := "00000100010101100011"; -- XNORI 12
    
    constant SALTO : STD_LOGIC_VECTOR(19 downto 0) := "10010000001100110011"; -- SALTO 13-18
    constant B : STD_LOGIC_VECTOR(19 downto 0) := "00010000000000000000"; -- B 19
    
    constant CALL : STD_LOGIC_VECTOR(19 downto 0) := "01010000000000000000"; -- CALL 20
    constant RET : STD_LOGIC_VECTOR(19 downto 0) := "00100000000000000000"; -- RET 21
    constant NOP : STD_LOGIC_VECTOR(19 downto 0) := "00000000000000000000"; -- NOP 22
    
    constant LW : STD_LOGIC_VECTOR(19 downto 0) := "00000110010100110001"; -- LW 23
    
    type memoria is array (0 to (2**n)-1) of std_logic_vector(19 downto 0);
    constant opCode : memoria := (
        VERIFICACION,
        LI,
        LWI,
        SWI,
        SW,
        ADDI,
        SUBI,
        ANDI,
        ORI,
        XORI,
        NANDI,
        NORI,
        XNORI,
        SALTO, -- BEQI
        SALTO, -- BNEI
        SALTO, -- BLTI
        SALTO, -- BLETI
        SALTO, -- BGTI
        SALTO, -- BGETI
        B,
        CALL,
        RET,
        NOP,
        LW,
        others => (others => '0')
    );
    
    begin
    microinstruccion <= opCode(conv_integer(codigo_operacion));


end Behavioral;
