library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decodificador is
    Port ( qb : in STD_LOGIC_VECTOR (3 downto 0);
           digito_out : out STD_LOGIC_VECTOR (6 downto 0));
end Decodificador;

architecture Behavioral of Decodificador is -- "gfedcba"
    constant digito_0 : STD_LOGIC_VECTOR(6 downto 0) := "0111111";
    constant digito_1 : STD_LOGIC_VECTOR(6 downto 0) := "0000110";
    constant digito_2 : STD_LOGIC_VECTOR(6 downto 0) := "1011011";
    constant digito_3 : STD_LOGIC_VECTOR(6 downto 0) := "1001111";
    constant digito_4 : STD_LOGIC_VECTOR(6 downto 0) := "1100110";
    constant digito_5 : STD_LOGIC_VECTOR(6 downto 0) := "1101101";
    constant digito_6 : STD_LOGIC_VECTOR(6 downto 0) := "1111101";
    constant digito_7 : STD_LOGIC_VECTOR(6 downto 0) := "0000111";
    constant digito_8 : STD_LOGIC_VECTOR(6 downto 0) := "1111111";
    constant digito_9 : STD_LOGIC_VECTOR(6 downto 0) := "1101111";
    
    begin
    process(qb)
        begin
        case qb is
            when "0000" => digito_out <= digito_0;
            when "0001" => digito_out <= digito_1;
            when "0010" => digito_out <= digito_2;
            when "0011" => digito_out <= digito_3;
            when "0100" => digito_out <= digito_4;
            when "0101" => digito_out <= digito_5;
            when "0110" => digito_out <= digito_6;
            when "0111" => digito_out <= digito_7;
            when "1000" => digito_out <= digito_8;
            when OTHERS => digito_out <= digito_9;
        end case;
    end process;
end Behavioral;
