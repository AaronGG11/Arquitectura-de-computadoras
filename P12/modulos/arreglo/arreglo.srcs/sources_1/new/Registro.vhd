library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Registro is
    Port ( la : in STD_LOGIC;
           ea : in STD_LOGIC;
           clk : in STD_LOGIC;
           clr : in STD_LOGIC;
           da : in STD_LOGIC_VECTOR (8 downto 0);
           qa : out STD_LOGIC_VECTOR (8 downto 0));
end Registro;

architecture Behavioral of Registro is
    signal aux_a : STD_LOGIC_VECTOR(8 downto 0); -- bus 
    begin
    
    process(clk,clr,la,ea)
        begin
        if (clr = '1') then
            aux_a <= "000000000";
        elsif(rising_edge(clk)) then 
            if (la = '0' and ea = '0') then
                aux_a <= aux_a;
            elsif (la = '1' and ea = '0') then
                aux_a <= da;
            elsif (la = '0' and ea = '1') then 
                aux_a <= to_stdlogicvector(to_bitvector(aux_a) SRL 1);
            end  if;
        end if;    
    end process;
    qa <= aux_a;
end Behavioral;
