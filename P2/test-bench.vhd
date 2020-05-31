library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sumadortb is
--  Port ( );
end sumadortb;

architecture Behavioral of sumadortb is

component suman is

    Port ( a,b : in STD_LOGIC_VECTOR (7 downto 0);
           cin : in STD_LOGIC;
           s : out STD_LOGIC_VECTOR (7 downto 0);
           cout : out STD_LOGIC);
end component;

signal a,b : std_logic_vector(7 downto 0);
signal s: std_logic_vector(7 downto 0);
signal cin : std_logic;
signal cout : std_logic;

begin

sum_res: suman Port map ( 
    a => a,
    b => b,
    s => s,
    cin => cin,
    cout => cout
);

-- generar procesos, es decir para recibir los estimulos 
process 
    begin 
    -- 1 - 4
    a <= "00000001";
    b <= "00000100";
    cin <= '1';
    wait;
end process; 

end Behavioral;
