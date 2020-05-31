library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Multiplexor is
    Port ( digito_in : in STD_LOGIC_VECTOR (6 downto 0);
           ec : in STD_LOGIC;
           digito_final : out STD_LOGIC_VECTOR (6 downto 0));
end Multiplexor;

architecture Behavioral of Multiplexor is
    constant guion : STD_LOGIC_VECTOR(6 downto 0) := "1000000"; -- gfedcba
    begin
        with ec select 
            digito_final <= digito_in when '1',
            guion when others;  
end Behavioral;