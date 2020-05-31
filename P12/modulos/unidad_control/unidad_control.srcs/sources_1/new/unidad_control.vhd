library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity unidad_control is
    Port ( ini : in STD_LOGIC;
           clr : in STD_LOGIC;
           clk : in STD_LOGIC;
           a0 : in STD_LOGIC;
           z : in STD_LOGIC;
           la : out STD_LOGIC;
           ea : out STD_LOGIC;
           lb : out STD_LOGIC;
           ec : out STD_LOGIC;
           eb : out STD_LOGIC);
end unidad_control;

architecture Behavioral of unidad_control is

    type estados is (e0,e1,e2);
    signal actual,siguiente : estados;
    
    begin
    
    process(clk, clr)
        begin 
        if (clr = '1') then 
            actual <= e0;
        elsif (rising_edge(clk)) then
            actual <= siguiente;
        end if; 
        
    end process;
    
    process(actual,ini,z,a0)
        begin 
        la <= '0';
        lb <= '0';
        ea <= '0';
        eb <= '0';
        ec <= '0';
        
        case actual is
            when e0 => 
                lb <= '1';
                if (ini = '1') then 
                    siguiente <= e1;
                else 
                    la <= '1';
                    siguiente <= e0;
                end if;
            when e1 =>
                ea <= '1';
                if (z = '1') then -- arreglo igual a cero 
                    siguiente <= e2;
                else -- arreglo diferente de cero 
                    if (a0 = '1') then
                        eb <= '1';
                        siguiente <= e1;
                    else
                        siguiente <= e1;
                    end if;                
                end if;
            when e2 =>
                ec <= '1';
                if (ini = '1') then
                    siguiente <= e2;
                else
                    siguiente <= e0;
                end if;
        end case; 
        
    end process;
    
end Behavioral;