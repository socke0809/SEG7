----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:40:53 03/27/2014 
-- Design Name: 
-- Module Name:    A/B - Behavioral 
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

--A/B

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity divide_by is
    Port ( A : in  integer range 0 to 9999;
           RES : out  integer range 0 to 9999;
           B : in  integer range 0 to 1000;
			  RE: out integer range 0 to 9999;
			  CLK: in std_logic
			  );
end divide_by;

architecture Behavioral of divide_by is

	signal CNT: integer range 0 to 1000 := 0;
	signal tempD: integer range 0 to 9999 := 0;
	signal A_OLD: integer range 0 to 9999 := 0;
	signal B_OLD: integer range 0 to 1000 := 0;
	
begin 
	--tempD <= A;
	process (CLK)
	begin 
		if rising_edge(CLK) then
			if A_OLD /= A then
				tempD <= A;
				CNT <= 0;
			end if;
			
			 A_OLD <= A;
			
			if tempD >= B and B /= 0 then
				tempD <= tempD - B;
				CNT <= CNT +1;
			else 
				RES <= CNT;
				
				--CNT <= 0;
			end if;
			
			if B_OLD /= B then
				
				CNT <= 0;
				--RES <= 0;--
				tempD <= A;
			end if;
			B_OLD <= B;
			RE <= tempD;
		end if;
	end process;
end Behavioral;

