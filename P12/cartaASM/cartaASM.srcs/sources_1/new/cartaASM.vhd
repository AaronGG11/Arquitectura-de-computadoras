library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cartaASM is
    Port ( clr : in STD_LOGIC;
           clk : in STD_LOGIC;
           ini : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (8 downto 0);
           data_out : out STD_LOGIC_VECTOR (8 downto 0);
           digit_out : out STD_LOGIC_VECTOR (6 downto 0));
end cartaASM;

architecture Behavioral of cartaASM is
    -- unidad de control
    component unidad_control is
    Port ( ini, clr, clk, a0, z : in STD_LOGIC;
           la, ea, lb, ec, eb : out STD_LOGIC);
    end component;
    
    -- registros 
    component Registro is
    Port ( la, ea, clk, clr : in STD_LOGIC;
           da : in STD_LOGIC_VECTOR (8 downto 0);
           qa : out STD_LOGIC_VECTOR (8 downto 0));
    end component;
    
    -- contador
    component Contador is
    Port ( lb, eb, clr, clk : in STD_LOGIC;
           qb : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    -- decodificador
    component Decodificador is
    Port ( qb : in STD_LOGIC_VECTOR (3 downto 0);
           digito_out : out STD_LOGIC_VECTOR (6 downto 0));
    end component;
    
    -- multiplexor
    component Multiplexor is
    Port ( digito_in : in STD_LOGIC_VECTOR (6 downto 0);
           ec : in STD_LOGIC;
           digito_final : out STD_LOGIC_VECTOR (6 downto 0));
    end component;

    -- se�ales o buses de alambrado
    signal sgnLA, sgnLB, sgnEA, sgnEB, sgnEC, sgnZ : STD_LOGIC;
    signal sgnOutCounter : STD_LOGIC_VECTOR(3 downto 0);
    signal sgnOutDeco : STD_LOGIC_VECTOR(6 downto 0);
    signal sgnData : STD_LOGIC_VECTOR(8 downto 0);
    
    begin
    
    sgnZ <= '1' when sgnData = "000000000" else '0';
    -- Instaciar modulo de unidad de control 
    UC : unidad_control 
        Port map( 
           ini => ini,
           clr => clr,
           clk => clk,
           a0 => sgnData(0),
           z => sgnZ,
           la => sgnLA,
           ea => sgnEA,
           lb => sgnLB,
           ec => sgnEC,
           eb => sgnEB
           );
           
    -- Instanciar modulo de registro
    REG : Registro
        Port map(
           la => sgnLA,
           ea => sgnEA,
           clk => clk,
           clr => clr,
           da => data_in,
           qa => sgnData 
           );
           
    -- Instanciar modulo de contador
    CONT : Contador
        Port map(
           lb => sgnLB,
           eb => sgnEB,
           clr => clr,
           clk => clk,
           qb => sgnOutCounter
           );
           
    -- Instanciar modulo de decodificacion
    DECO : Decodificador 
        Port map(
           qb => sgnOutCounter,
           digito_out => sgnOutDeco
           );
           
    -- Instanciar modulo de multiplexor
    MUX : Multiplexor
        Port map( 
           digito_in => sgnOutDeco,
           ec => sgnEC,
           digito_final => digit_out
           );
           
    data_out <= sgnData;

end Behavioral;
