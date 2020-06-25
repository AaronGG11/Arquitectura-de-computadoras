library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control is -- ASM
    Port (
        TIPOR, BEQI, BNEI, BLTI, BLETI, BGTI, BGETI : in STD_LOGIC;
        EQ, NE, LT, LE, GT, GE : in STD_LOGIC;
        clk, clr, NA: in STD_LOGIC;
        SDOPC, SM : out STD_LOGIC
    );
end control;

architecture Behavioral of control is
    type estados is (A);
    signal estado_actual, estado_siguiente : estados;
    
    begin
    
    trnasicion : process(clr, clk)-- establece el cambio de estado actual a estado siguinete
        begin
        if(clr = '1') then
            estado_actual <= A;
        elsif(rising_edge(clk)) then
            estado_actual <= estado_siguiente;
        end if;
    end process;
    
    asm : process(TIPOR, BEQI, BNEI, BLTI, BLETI, BGTI, BGETI, NA, EQ, NE, LT, LE, GT, GE, NA, estado_actual)
        begin
        SM <= '0';
        SDOPC <= '0';
        
        case estado_actual is
            when A => estado_siguiente <= A;
            if(TIPOR = '1') then
                 SM <= '0'; -- No es necesaria por la inicializacion en 0's
            else
                if (BEQI = '1') then
                    if (NA = '1') then
                        SM <= '1';
                    else
                        if (EQ = '1') then
                            SM <= '1';
                            SDOPC <= '1';
                        else
                            SM <= '1';
                        end if;
                    end if; 
                elsif (BNEI = '1') then
                    if (NA = '1') then
                        sm <= '1';
                    else
                        if (NE = '1') then
                            SDOPC <= '1';
                            SM <= '1';
                        else
                            SM <= '1';
                        end if;
                    end if;
                elsif (BLTI = '1') then
                    if (NA = '1') then
                        SM <= '1';
                    else
                        if (LT = '1') then
                            SDOPC <= '1';
                            SM <= '1';
                        else
                            SM <= '1';
                        end if;
                    end if; 
                elsif (BLETI = '1') then
                    if (NA = '1') then 
                        SM <= '1';
                    else 
                        if (LE = '1') then
                            SDOPC <= '1';
                            sm <= '1';
                        else
                            SM <= '1';
                        end if;
                    end if;
                elsif (BGTI = '1') then
                    if (NA = '1') then
                        SM <= '1';
                    else
                        if (GT = '1') then
                            SDOPC <= '1';
                            SM <= '1';
                        else
                            SM <= '1';
                        end if;
                    end if;
                elsif (BGETI = '1') then
                    if (NA = '1') then
                        SM <= '1';
                    else
                        if (GE = '1') then
                            SDOPC <= '1';
                            SM <= '1';
                        else
                            SM <= '1';
                        end if;
                    end if;
                else
                    SDOPC <= '1';
                    SM <= '1';
                end if;
            end if;
        end case;
    end process;

end Behavioral;
