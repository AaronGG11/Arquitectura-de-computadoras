library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ESCOMIPS_TB is
end ESCOMIPS_TB;

architecture Behavioral of ESCOMIPS_TB is
    component ESCOMips is
        Port ( 
            CLK, RCLR : IN STD_LOGIC;
            LECTURA_PC : OUT STD_LOGIC_VECTOR(15 downto 0);
            LECTURA_INSTRUCCION : OUT STD_LOGIC_VECTOR(24 downto 0);
            LECTURA_READDATA1, LECTURA_READDATA2 : OUT STD_LOGIC_VECTOR(15 downto 0);
            LECTURA_RES_ALU : OUT STD_LOGIC_VECTOR(15 downto 0);
            LECTURA_BUS_SR : OUT STD_LOGIC_VECTOR(15 downto 0);
            LECTURA_MICROINSTRUCCION : OUT STD_LOGIC_VECTOR(19 downto 0);
            LECTURA_NA : OUT STD_LOGIC
        );
    end component;
    
    -- Se?ales de transporte
    signal CLK, RCLR : STD_LOGIC;
    signal LECTURA_PC : STD_LOGIC_VECTOR(15 downto 0);
    signal LECTURA_INSTRUCCION : STD_LOGIC_VECTOR(24 downto 0);
    signal LECTURA_READDATA1, LECTURA_READDATA2 : STD_LOGIC_VECTOR(15 downto 0);
    signal LECTURA_RES_ALU : STD_LOGIC_VECTOR(15 downto 0);
    signal LECTURA_BUS_SR : STD_LOGIC_VECTOR(15 downto 0);
    signal LECTURA_MICROINSTRUCCION : STD_LOGIC_VECTOR(19 downto 0);
    signal LECTURA_NA : STD_LOGIC;
    
    begin
    
    ESCOMipsMAP : ESCOMips  Port map( 
        CLK => CLK,
        RCLR => RCLR,
        LECTURA_PC => LECTURA_PC ,
        LECTURA_INSTRUCCION => LECTURA_INSTRUCCION,
        LECTURA_READDATA1 => LECTURA_READDATA1, 
        LECTURA_READDATA2 => LECTURA_READDATA2,
        LECTURA_RES_ALU => LECTURA_RES_ALU,
        LECTURA_BUS_SR => LECTURA_BUS_SR,
        LECTURA_MICROINSTRUCCION => LECTURA_MICROINSTRUCCION,
        LECTURA_NA => LECTURA_NA
    );
    
    CLOCK : process
        begin
        CLK <= '0';
        wait for 5 ns;
        CLK <= '1';
        wait for 5 ns;
    end process;
    
    RESET : process
        begin
        RCLR <= '1';
        wait for 20 ns;
        RCLR <= '0';
        wait;
    end process;

end Behavioral;