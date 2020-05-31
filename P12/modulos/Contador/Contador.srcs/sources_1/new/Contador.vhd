library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Contador is
    Port ( lb : in STD_LOGIC;
           eb : in STD_LOGIC;
           clr : in STD_LOGIC;
           clk : in STD_LOGIC;
           qb : out STD_LOGIC_VECTOR (3 downto 0));
end Contador;

architecture Behavioral of Contador is
    constant zero: std_logic_vector(3 downto 0) := "0000";
    begin
        process(clk, clr, eb, lb)
            variable aux_qb : STD_LOGIC_VECTOR(3 downto 0);
            begin 
            if (clr = '1') then 
                aux_qb := zero;
            elsif (rising_edge(clk)) then
                if (lb='1' and eb='1') then
                    aux_qb := aux_qb;
                elsif (lb='1' and eb='0') then
                    aux_qb := zero;
                elsif (lb='0' and eb='1') then
                    aux_qb := aux_qb + 1;
                end if;
            end if; 
            
            qb <= aux_qb;
        end process;
   
end Behavioral;
