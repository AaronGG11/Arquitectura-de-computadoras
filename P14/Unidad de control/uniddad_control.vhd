library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity uniddad_control is
    Port (
        funCode : in STD_LOGIC_VECTOR(3 downto 0);
        opCode : in STD_LOGIC_VECTOR(4 downto 0);
        clk, clr, lf : in STD_LOGIC;
        banderas : in STD_LOGIC_VECTOR(3 downto 0);
        microInstruccion : out STD_LOGIC_VECTOR(19 downto 0)
    );
end uniddad_control;

architecture Behavioral of uniddad_control is

    -- memoria de codigo de funcion 
    component MFunCode is
        Port (
            codigo_funcion : in STD_LOGIC_VECTOR(3 downto 0);
            microinstruccion_fcode : out STD_LOGIC_VECTOR (19 downto 0));
    end component;
    
    -- memoria de codigo de operacion
    component MOpCode is
        Port (
            codigo_operacion : in STD_LOGIC_VECTOR(4 downto 0);
            microinstruccion : out STD_LOGIC_VECTOR (19 downto 0));
    end component;
    
    -- condicion 
    component condicion is
        Port(
            banderas : in STD_LOGIC_VECTOR(3 downto 0);
            EQ, NE, LT, LE, GT, GE : out STD_LOGIC);
    end component;
    
    -- control (ASM)
    component control is
        Port (
            TIPOR, BEQI, BNEI, BLTI, BLETI, BGTI, BGETI : in STD_LOGIC;
            EQ, NE, LT, LE, GT, GE : in STD_LOGIC;
            clk, clr, NA: in STD_LOGIC;
            SDOPC, SM : out STD_LOGIC);
    end component;
    
    -- decodificador
    component decodificador is
        Port ( 
            codigo_operacion : in STD_LOGIC_VECTOR(4 downto 0);
            tipo_R : out STD_LOGIC;
            BEQI ,BNEI , BLTI, BLETI, BGTI, BGETI : out STD_LOGIC);
    end component;
    
    -- multiplexor de 5 bits
    component mux5bits is
        Port ( 
            codigo_op: in STD_LOGIC_VECTOR(4 downto 0);
            sdopc : in STD_LOGIC;
            salida : out STD_LOGIC_VECTOR(4 downto 0));
    end component;
    
    -- multiplexor de 20 bits
    component mux20bits is
        Port ( 
            codigo_fu: in STD_LOGIC_VECTOR(19 downto 0);
            codigo_op: in STD_LOGIC_VECTOR(19 downto 0);
            sm : in STD_LOGIC;
            salida : out STD_LOGIC_VECTOR(19 downto 0));
    end component;
    
    -- nivel
    component nivel is
        Port ( clk : in STD_LOGIC;
               clr : in STD_LOGIC;
                   na : out STD_LOGIC);
    end component;
    
    -- registro
    component registro is
        Port (
            banderas_entrada : in STD_LOGIC_VECTOR(3 downto 0);
            lf, clk, clr : in STD_LOGIC;
            banderas_salida : out STD_LOGIC_VECTOR(3 downto 0));
    end component;
    
    -- declaracion de señales de transporte (BUSES)
    signal EQ, NE, LT, LE, GT, GE : STD_LOGIC;
    signal NA, SDOPC, SM : STD_LOGIC;
    signal TIPOR, BEQI, BNEI, BLTI, BLETI, BGTI, BGETI: STD_LOGIC;
    signal auxUFCode, auxUOpCode, auxSalida : STD_LOGIC_VECTOR(19 downto 0);
    signal auxOpCode : STD_LOGIC_VECTOR(4 downto 0);
    signal auxBanderas : STD_LOGIC_VECTOR(3 downto 0);

    begin
    
    -- instanciar y mapear modulo de memoria de codigo de funcion 
    MFC : MFunCode 
        Port map (
            codigo_funcion => funCode,
            microinstruccion_fcode => auxUFCode
         ); 
         
    -- instanciar y mapear modulo de memoria de codigo de operacion
    MOC : MOpCode 
        Port map(
            codigo_operacion => auxOpCode,
            microinstruccion => auxUOpCode
        );
        
    -- instanciar y mapear modulo de condicion
    COND : condicion
        Port map(
            banderas => auxBanderas,
            EQ => EQ,
            NE => NE,
            LT => LT, 
            LE => LE, 
            GT => GT, 
            GE => GE
        );
        
    -- Instanciar y mapear modulo de control    
    CONTR : component control 
        Port map(
            TIPOR => TIPOR, 
            BEQI => BEQI, 
            BNEI => BNEI, 
            BLTI => BLTI, 
            BLETI => BLETI, 
            BGTI => BGTI, 
            BGETI => BGETI,
            EQ => EQ, 
            NE => NE, 
            LT => LT, 
            LE => LE, 
            GT => GT, 
            GE => GE,
            clk => clk, 
            clr => clr, 
            NA => NA,
            SDOPC => SDOPC,
            SM => SM
            );
            
    -- Instanciar y mapear modulo de decodificacion
    DECO : decodificador
        Port map( 
            codigo_operacion => opCode,
            tipo_R => TIPOR,
            BEQI => BEQI, 
            BNEI => BNEI, 
            BLTI => BLTI, 
            BLETI => BLETI, 
            BGTI => BGTI, 
            BGETI => BGETI
        );

    -- Instanciar y mapear mux de 5 bits
    MUX5 : Mux5bits 
        Port map( 
            codigo_op => opCode,
            sdopc => SDOPC,
            salida => auxOpCode
        );
        
    -- Instanciar y mapear mux de 20 bits
    MUX20 : mux20bits
        Port map( 
            codigo_fu => auxUFCode,
            codigo_op => auxUOpCode,
            salida => auxSalida,
            sm => SM
        );
        
    -- Instanciar y mapear el modulo nivel
    NIV : nivel
        Port map( 
            clk => clk,
            clr => clk,
            na => NA
        );
        
    -- Instanciar y mapear el modulo de registro
    REG : registro
        Port map(
            banderas_entrada => banderas,
            lf => lf,
            clk => clk,
            clr => clr,
            banderas_salida => auxBanderas
        );
     
    microInstruccion <= auxSalida;

end Behavioral;
