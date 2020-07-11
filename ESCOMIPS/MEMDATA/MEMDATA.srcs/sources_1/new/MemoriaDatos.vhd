-- Module Name:    MemoriaDatos - A_MemoriaDatos
library IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_arith.all;
USE IEEE.STD_LOGIC_unsigned.ALL;

entity MemoriaDatos is
    Port ( 
        dir : in  STD_LOGIC_VECTOR (9 downto 0);
        data_in : in  STD_LOGIC_VECTOR (15 downto 0);
        data_out : out  STD_LOGIC_VECTOR (15 downto 0);
        WD, CLK : in  STD_LOGIC
    );
end MemoriaDatos;

architecture A_MemoriaDatos of MemoriaDatos is
    type memorias is array ( 0 to (2**10) -1) of std_logic_vector(15 downto 0);
    signal aux: memorias;
begin
    process(CLK)
    begin
        if ( rising_edge(clk) ) then -- escritura sincrona
            if ( wd = '1' ) then 
                aux( conv_integer( dir ) ) <= data_in;
            end if;
        end if;
    end process;
    data_out <= aux( conv_integer( dir ) );--lectura asincrona
end A_MemoriaDatos;

