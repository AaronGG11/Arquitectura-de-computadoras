library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity condicion is
    Port(
        banderas : in STD_LOGIC_VECTOR(3 downto 0);
        EQ : out STD_LOGIC;
        NE : out STD_LOGIC;
        LT : out STD_LOGIC;
        LE : out STD_LOGIC;
        GT : out STD_LOGIC;
        GE : out STD_LOGIC
    );
end condicion;

architecture Behavioral of condicion is
    -- BANDERAS 0 - C, 1 - Z, 2- N, 3 - OV
    signal C, Z, N, OV : STD_LOGIC;
    
    begin
    
    -- fetch de banderas
    C <= banderas(0);
    Z <= banderas(1);
    N <= banderas(2);
    OV <= banderas(3);
    
    EQ <= Z;
    NE <= not Z;
    LT <= not C;
    LE <= Z or (not C);
    GT <= (not Z) and C;
    GE <= C;

end Behavioral;
