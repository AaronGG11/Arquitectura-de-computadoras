library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;


entity memPrograma is
    generic (
        m : integer := 10; --tamaño del bus de direcciones
        n : integer := 25 --tamaño de palabra
    );
    Port (
        dir : in STD_LOGIC_VECTOR (m-1 downto 0);
        inst : out STD_LOGIC_VECTOR (n-1 downto 0)
    );
end memPrograma;

architecture arq_memPrograma of memPrograma is
    -- REGISTROS
    constant R0  : std_logic_vector(3 downto 0) := "0000";
    constant R1  : std_logic_vector(3 downto 0) := "0001";
    constant R2  : std_logic_vector(3 downto 0) := "0010";
    constant R3  : std_logic_vector(3 downto 0) := "0011";
    constant R4  : std_logic_vector(3 downto 0) := "0100";
    constant R5  : std_logic_vector(3 downto 0) := "0101";
    constant R6  : std_logic_vector(3 downto 0) := "0110";
    constant R7  : std_logic_vector(3 downto 0) := "0111";
    constant R8  : std_logic_vector(3 downto 0) := "1000";
    constant R9  : std_logic_vector(3 downto 0) := "1001";
    constant R10 : std_logic_vector(3 downto 0) := "1010";
    constant R11 : std_logic_vector(3 downto 0) := "1011";
    constant R12 : std_logic_vector(3 downto 0) := "1100";
    constant R13 : std_logic_vector(3 downto 0) := "1101";
    constant R14 : std_logic_vector(3 downto 0) := "1110";
    constant R15 : std_logic_vector(3 downto 0) := "1111";
   
    constant TIPO_R : std_logic_vector(4 downto 0) := "00000";
    -- ENGLOBA A ADD, SUB, AND, OR, XOR, NAND, NOR, XNOR, NOT, SLL, SRL
    
    -- INSTRUCCIONES DE CARGA Y ALMACENAMIENTO
    constant LI   : std_logic_vector(4 downto 0) := "00001"; -- 1
    constant LWI  : std_logic_vector(4 downto 0) := "00010"; -- 2
    constant LW   : std_logic_vector(4 downto 0) := "10111"; -- 23
    constant SWI  : std_logic_vector(4 downto 0) := "00011"; -- 3
    constant SW   : std_logic_vector(4 downto 0) := "00100"; -- 4
    
    -- INSTRUCCIONES ARITMETICAS
    constant ADDI  : std_logic_vector(4 downto 0) := "00101"; -- 5
    constant SUBI  : std_logic_vector(4 downto 0) := "00110"; -- 6
    
    -- INSTRUCCIONES LOGICAS
    constant ANDI  : std_logic_vector(4 downto 0) := "00111"; -- 7
    constant ORI   : std_logic_vector(4 downto 0) := "01000"; -- 8
    constant XORI  : std_logic_vector(4 downto 0) := "01001"; -- 9
    constant NANDI : std_logic_vector(4 downto 0) := "01010"; -- 10
    constant NORI  : std_logic_vector(4 downto 0) := "01011"; -- 11
    constant XNORI : std_logic_vector(4 downto 0) := "01100"; -- 12    
    
    -- INSTRUCCIONES DE SALTOS CONDICIONALES E INCONDICIONALES
    constant BEQI  : std_logic_vector(4 downto 0) := "01101"; -- 13
    constant BNEI  : std_logic_vector(4 downto 0) := "01110"; -- 14
    constant BLTI  : std_logic_vector(4 downto 0) := "01111"; -- 15
    constant BLETI : std_logic_vector(4 downto 0) := "10000"; -- 16
    constant BGTI  : std_logic_vector(4 downto 0) := "10001"; -- 17
    constant BGETI : std_logic_vector(4 downto 0) := "10010"; -- 18
    constant B     : std_logic_vector(4 downto 0) := "10011"; -- 19
    
    -- INSTRUCCIONES DE MANEJO DE SUBRUTINAS
    constant CALL  : std_logic_vector(4 downto 0) := "10100"; -- 20
    constant RE    : std_logic_vector(4 downto 0) := "10101"; -- 21
    
    -- OTRAS INSTRUCCIONES
    constant NOP   : std_logic_vector(4 downto 0) := "10110"; -- 22
    
    -- OTRAS 
    constant S_U   : std_logic_vector(3 downto 0) := "0000"; -- 0
    
    -- CODIGO DE FUNCION [3..0]
    constant ADD_F  : std_logic_vector(3 downto 0) := "0000"; -- 0
    constant SUB_F  : std_logic_vector(3 downto 0) := "0001"; -- 1
    constant AND_F  : std_logic_vector(3 downto 0) := "0010"; -- 2
    constant OR_F   : std_logic_vector(3 downto 0) := "0011"; -- 3
    constant XOR_F  : std_logic_vector(3 downto 0) := "0100"; -- 4
    constant NAND_F : std_logic_vector(3 downto 0) := "0101"; -- 5
    constant NOR_F  : std_logic_vector(3 downto 0) := "0110"; -- 6
    constant XNOR_F : std_logic_vector(3 downto 0) := "0111"; -- 7
    constant NOT_F  : std_logic_vector(3 downto 0) := "1000"; -- 8
    constant SLL_F  : std_logic_vector(3 downto 0) := "1001"; -- 9
    constant SRL_F  : std_logic_vector(3 downto 0) := "1010"; -- 10
    
    
    type banco is array (0 to (2**m)-1) of std_logic_vector(n-1 downto 0);
    constant aux : banco := (
        -- PROGRAMA DE FIBONACCI
        LI & R0 & x"0000",                   -- 0
        LI & R1 & x"0001",                   -- 1
        LI & R2 & x"0000",                   -- 2
        LI & R3 & x"000C",                   -- 3
        TIPO_R & R4 & R0 & R1 & S_U & S_U,   -- 4
        SWI & R4 & x"0048",                  -- 5 
        ADDI & R0 & R1 & x"000",             -- 6
        ADDI & R1 & R4 & x"000",             -- 7 
        ADDI & R2 & R2 & x"001",             -- 8
        BNEI & R3 & R2 & x"004",             -- 9 
        NOP & S_U & S_U & S_U & S_U & S_U,   -- 10
        B & S_U & x"000A",                   -- 11
        others => (others => '0') 
    );

    begin   
        inst <= aux(conv_integer(dir));
end arq_memPrograma;