library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity pila is
    Port(
    CLK, CLR, UP, DOWN, WPC : in std_logic;
    PCin : in std_logic_vector(15 downto 0);
    SP_OUT : out std_logic_vector(2 downto 0); 
    PCout : out std_logic_vector(15 downto 0)
    );
end pila;

architecture a_pila of pila is
    type array_pc is array (0 to 7) of std_logic_vector(15 downto 0);
    signal SP_aux : integer range 0 to 7;
    signal stack : array_pc;
    begin
        process(clk,clr,stack)
        variable SP : integer range 0 to 7;
        begin 
            if (CLR = '1') then
                SP := 0;
                stack <= (others => (others => '0'));
            elsif (CLK'event and CLK = '1') then 
                if (WPC = '1' and UP = '0' and DOWN = '0') then
                    stack(SP) <= PCin;
                elsif (WPC = '1' and UP = '1' and DOWN = '0') then   
                    SP := SP + 1;
                    stack(SP) <= PCin;  
                elsif (WPC = '0' and UP = '0' and DOWN = '0') then
                    stack(SP) <= stack(SP) + 1;
                elsif (WPC = '0' and UP = '0' and DOWN = '1') then 
                    SP := SP - 1;
                    stack(SP) <= stack(SP) + 1;
                end if;
            end if; 
            SP_aux <= SP;
        end process;
        
        SP_OUT <= conv_std_logic_vector(SP_aux, 3);
        PCout <= stack(SP_aux);
end a_pila;
