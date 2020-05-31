library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity suman is
    generic ( n: integer := 8
        
    );
    Port ( a,b : in STD_LOGIC_VECTOR (n-1 downto 0);
           cin : in STD_LOGIC;
           s : out STD_LOGIC_VECTOR (n-1 downto 0);
           cout : out STD_LOGIC);
end suman;

architecture Behavioral of suman is

component suma_1 is
    Port ( a,b,cin : in STD_LOGIC;
           s : out STD_LOGIC;
           cout : out STD_LOGIC);
end component;

signal c : std_logic_vector(n downto 0);
signal eb : std_logic_vector(n-1 downto 0);

begin
    
    c(0) <= cin;

    ciclo: for i in 0 to n-1 generate
        eb(i)<= b(i) xor cin;
        bit0 :  suma_1 port map (
        a => a(i),
        b => eb(i),
        cin => c(i),
        s => s(i),
        cout => c(i+1)
        );
    end generate;
    
--    bit1 :  suma_1 port map (
--    a => a(1), 
--    b => b(1) xor cin,
--    cin => c(1),
--    s => s(1),
--    cout => c(2)
--    );
    
--    bit2 :  suma_1 port map (
--    a => a(2), 
--    b => b(2) xor cin,
--    cin => c(2),
--    s => s(2),
--    cout => c(3)
--    );
    
--    bit3 :  suma_1 port map (
--    a => a(3), 
--    b => b(3) xor cin,
--    cin => c(3),
--    s => s(3),
--    cout => c(4)
--    );
    
--    bit4 :  suma_1 port map (
--    a => a(4), 
--    b => b(4) xor cin,
--    cin => c(4),
--    s => s(4),
--    cout => c(5)
--    );
    
--    bit5 :  suma_1 port map (
--    a => a(5), 
--    b => b(5) xor cin,
--    cin => c(5),
--    s => s(5),
--    cout => c(6)
--    );
    
--    bit6 :  suma_1 port map (
--    a => a(6), 
--    b => b(6) xor cin,
--    cin => c(6),
--    s => s(6),
--    cout => c(7)
--    );
    
--    bit7 :  suma_1 port map (
--    a => a(7), 
--    b => b(7) xor cin,
--    cin => c(7),
--    s => s(7),
--    cout => c(8)
--    );

    cout <= c(n);




end Behavioral;
