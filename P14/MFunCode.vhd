library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity MFunCode is
    generic ( n : integer := 4 );
    Port (
        codigo_funcion : in STD_LOGIC_VECTOR(n-1 downto 0);
        microinstruccion_fcode : out STD_LOGIC_VECTOR (19 downto 0)
    );
end MFunCode;

architecture Behavioral of MFunCode is
    -- Declaracion de microinstrucciones (Solo tipo R)
    -- SDMP UP DW WPC SR2 SWD SEXT SHE DIR WR SOP1 SOP2 ALUOP3 ALUOP2 ALUOP1 ALUOP0 SDMD WD SR LF
    
    constant R_ADD : STD_LOGIC_VECTOR (19 downto 0) := "00000100010000110011"; -- ADD 0 
    constant R_SUB : STD_LOGIC_VECTOR (19 downto 0) := "00000100010001110011"; -- SUB 1 
    
    constant R_AND : STD_LOGIC_VECTOR (19 downto 0) := "00000100010000000011"; -- AND 2 
    constant R_OR : STD_LOGIC_VECTOR (19 downto 0) :=  "00000100010000010011"; -- OR 3 
    constant R_XOR : STD_LOGIC_VECTOR (19 downto 0) := "00000100010000100011"; -- XOR 4 
    constant R_NAND : STD_LOGIC_VECTOR (19 downto 0) :="00000100010011010011"; -- NAND 5 
    constant R_NOR : STD_LOGIC_VECTOR (19 downto 0) := "00000100010011000011"; -- NOR 6 
    constant R_XNOR : STD_LOGIC_VECTOR (19 downto 0) :="00000100010001100011"; -- XNOR 7 
    constant R_NOT : STD_LOGIC_VECTOR (19 downto 0) := "00000100010011010011"; -- NOT 8 
    
    constant R_SLL : STD_LOGIC_VECTOR (19 downto 0) := "00000001110000000000"; -- SLL 9
    constant R_SRL : STD_LOGIC_VECTOR (19 downto 0) := "00000001010000000000"; -- SRL 10  
    
    type memoria is array (0 to (2**n)-1) of std_logic_vector(19 downto 0);
    
    constant funCode : memoria := (
        R_ADD,
        R_SUB,
        R_AND,
        R_OR,
        R_XOR,
        R_NAND,
        R_NOR,
        R_XNOR,
        R_NOT,
        R_SLL,
        R_SRL,
        others => (others => '0')
    );
    
    begin
        microinstruccion_fcode <= funCode(conv_integer(codigo_funcion));

end Behavioral;
