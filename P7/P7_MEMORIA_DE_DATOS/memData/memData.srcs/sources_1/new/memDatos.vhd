library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity memDatos is
    generic (
        dir_long : integer := 11;
        m : integer := 2048; -- 2**11
        n : integer := 16 );
    Port (
        dir : in std_logic_vector(dir_long-1 downto 0);
        dataIn : in std_logic_vector(n-1 downto 0);
        dataOut : out std_logic_vector(n-1 downto 0);
        CLK, WD : in std_logic);
       
end memDatos;

architecture arq_memDatos of memDatos is
    type banco is array (0 to m-1) of std_logic_vector(n-1 downto 0);
    signal aux : banco;
    begin
        process(CLK)
            begin
                if (rising_edge(CLK)) then
                    if (WD = '1') then
                        aux(conv_integer(dir)) <= dataIn; -- escritura
                    end if;
                end if;
        end process;
    dataOut <= aux(conv_integer(dir)); -- no depende mas que de la direccion

end arq_memDatos;
