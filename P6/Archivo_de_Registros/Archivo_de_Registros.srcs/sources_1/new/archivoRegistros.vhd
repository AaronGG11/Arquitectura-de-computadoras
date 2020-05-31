
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity archivoRegistros is
    Port ( registro1,registro2,write_registro,shamt: in  STD_LOGIC_VECTOR (3 downto 0);
            wdata: in  STD_LOGIC_VECTOR (15 downto 0);
            read_data1, read_data2 : out  STD_LOGIC_VECTOR (15 downto 0);
            wd,she, clk ,dir, clr : in  STD_LOGIC);
end archivoRegistros;

architecture Behavioral of archivoRegistros is
type registros is array (0 to 15) of std_logic_vector(15 downto 0);


signal banco : registros; 
signal data_in : std_logic_vector (15 downto 0);
signal l : std_logic_vector (15 downto 0);
signal data_out_bus,read_data_1, read_data_2 : std_logic_vector (15 downto 0);

component Registro is
    Port ( d : in STD_LOGIC_VECTOR (15 downto 0);
           q : out STD_LOGIC_VECTOR (15 downto 0);
           clr, clk, l : in STD_LOGIC);
end component;

component Multiplexor is
    Port ( read_data : out  STD_LOGIC_VECTOR (15 downto 0);
			  mux_op : in registros;
           read_reg : in  STD_LOGIC_VECTOR (3 downto 0));
end component;

component Demux is
    Port ( wr : in  STD_LOGIC;
           write_reg : in  STD_LOGIC_VECTOR (3 downto 0);
           load_enable : out  STD_LOGIC_VECTOR (15 downto 0));
end component;


component muxde2canales is
  Port ( int1,int2: in std_logic_vector(15 downto 0);
        sel: in std_logic;
        sal: out std_logic_vector(15 downto 0));
end component;

component BarrelShifter is

    Port ( 	
				DATA_IN : in std_logic_vector (15 downto 0);
				DATA_OUT : out  std_logic_vector (15 downto 0);
				SHAMT: in  std_logic_vector (3 downto 0);
				DIR: in std_logic
	 );

end component;


begin

process (she,wdata,data_out_bus,data_in)
	 begin
	 case she is
		when '0' => data_in <=wdata;
		when others => data_in <= data_out_bus;
	 end case;
end process;

ciclo1: for i in 0 to 15 generate 
	registros :  Registro
    Port map ( 
	   clk => clk, 
	   clr => clr, 
	   l => l(i),
	   d => data_in,
	   q => banco(i)
	);
			
end generate;


    demux1 : Demux
       Port map ( 
	    wr => wd, 
	    load_enable => l,
		write_reg => write_registro
	    );
	    
	Barrelshift : BarrelShifter
	 Port map (
		dir => dir,
		shamt => shamt,
		data_in =>  read_data_1,
		data_out => data_out_bus
	 );
	 
    mux1 : Multiplexor
	 Port map (
		read_data => read_data_1,
		mux_op => banco,
		read_reg => registro1	
		);
	mux2 : Multiplexor
	 Port map (
		read_data => read_data_2,
		mux_op => banco,
		read_reg => registro2
		);

		
		read_data1 <= read_data_1;
		read_data2 <= read_data_2;
		
end Behavioral;
