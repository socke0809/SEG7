----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:15:46 04/02/2014 
-- Design Name: 
-- Module Name:    StoppUhr - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VCompone



entity StoppUhr is

    Port (  SEG: out std_logic_vector(6 downto 0);
				AN: out std_logic_vector(3 downto 0);
				BTN_RST: in std_logic;
				BTN_STP: in std_logic;
				BTN_START: in std_logic;
				DP : out std_logic;
				CLK : in  std_logic);
end StoppUhr;


architecture Behavioral of StoppUhr is

	signal SEK: integer range 0 to 60 := 0;
	signal MIN: integer range 0 to 99 := 0;
	signal SE: integer range 0 to 50000000 := 0;
	
	signal A_BUF: integer range 0 to 9999 := 0;
	signal E_BUF: integer range 0 to 9 := 0;
	signal B: integer range 0 to 10;
	
	signal RES: integer range 0 to 1000; --RESULT
	signal RE: integer range 0 to 9999; --REST
	
	
	signal PRE: integer range 0 to 12500000:= 0;
	signal COUNT: integer range 0 to 3;
	
	signal BTN_RST_OLD: std_logic;
	signal BTN_STP_OLD: std_logic;
	signal BTN_START_OLD: std_logic;
	
	signal temp: std_logic := '0';
	
	signal CE: std_logic := '0';
	


	
	
	
	component Int_to_7SEG
		port( E: in integer range 0 to 15;
				SEG: out std_logic_vector (6 downto 0);
				CLK : in  std_logic);
	end component;
	
	component divide_by
		port( A : in  integer range 0 to 9999;
				RES : out  integer range 0 to 9999;
				B : in  integer range 0 to 1000;
				RE: out integer range 0 to 9999;
				CLK: in std_logic);
	end component;
	
	


begin

	Inst_Int_to_7SEG: Int_to_7SEG PORT MAP(
		E => E_BUF,
		SEG => SEG,
		CLK => CLK
	);
	
	Inst_divide_by: divide_by port map(
		A => A_BUF,
		CLK => CLK,
		B => B,
		RES => RES,
		RE => RE
	);

	P1: process(CLK)
	begin 
		if rising_edge(CLK) then
			if PRE < 12500 then  
				PRE <= PRE +1;
				CE <= '0';
			else
				PRE <= 0;
				CE <= '1';
				if COUNT = 3 then
					COUNT <= 0;
				else
					COUNT <= COUNT + 1;
				end if;

			end if;
		
		end if;
	end process P1; 
	
process(CLK)
	begin 
		if rising_edge(CLK) then
			if BTN_START = '1' and BTN_START_OLD = '0' then
				temp <= '1';
			end if;
			
			if BTN_RST = '1' and BTN_RST_OLD = '0' then
					temp <= '0';
					SEK <= 0;
					MIN <= 0;
					SE <= 0;
			end if;
			
			if  temp = '1' then
				if BTN_STP = '1' and BTN_STP_OLD = '0' then
					temp <= '0';
				else
					if SEK >= 59 then 
							SEK <= 0;
							MIN <= MIN +1;
						else
							if SE < 50000000   then  
								SE <= SE +1;
							else
								SEK <= SEK +1;
								SE <= 0;
							end if;
					end if;
					
				end if;
			end if;
			
		BTN_RST_OLD <= BTN_RST;
		BTN_STP_OLD <= BTN_STP;
		BTN_START_OLD <= BTN_START;
		
		end if;

end process; 
				
--		
--			if BTN_RST = '1'  then --and BTN_RST_OLD = '0'
--					SEK <= 0;
--					MIN <= 0;
--			
			--
--			else 
--				if (BTN_STOP = '0' ) or (BTN_STR = '1' and BTN_STR_OLD = '0') then
--					if SE < 50000000   then  
--						SE <= SE +1;
--			
--					else
--						if SEK >= 59 then 
--							SEK <= 0;
--							MIN <= MIN +1;
--						else
--							SEK <= SEK +1;
--						end if;
--						SE <= 0;
--					end if;
--				end if;
--		end if;
--			




process (CLK)
begin
	if rising_edge(CLK) AND CE='1' then
		
		case COUNT is
			when 0 => 
				AN <= NOT "0001";

				E_BUF <= RES;
				B <= 10; 
				A_BUF <= MIN;
				
				
	
			when 1 =>
				AN <= NOT "1000";
				E_BUF <= RES;
				B <= 1;
				A_BUF <= RE;
				
			when 2 =>
				AN <= NOT "0100";
				E_BUF <= RES;
				DP <= '0';
				B <= 10;
				A_BUF <=SEK;

	
			when 3 =>
				AN <= NOT "0010";
				E_BUF <= RES;
				B <= 1; --1000
				DP <= '1';
				A_BUF <=RE;
	
			when others =>
	
		end case;
	end if;
end process;

end Behavioral;
