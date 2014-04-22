----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:26:47 03/23/2014 
-- Design Name: 
-- Module Name:    Int_to_7SEG - Behavioral 
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
--use UNISIM.VComponents.all;

entity Int_to_7SEG is
	port( E: in integer range 0 to 9;
			SEG: out std_logic_vector (6 downto 0);
			CLK : in  std_logic
			);
end Int_to_7SEG;

architecture Behavioral of Int_to_7SEG is

begin
 process(CLK)
	begin
	if rising_edge(CLK) then
		case E is			    --ABCDEFG
				when 0 => SEG <= "1000000";
				when 1 => SEG <= "1111001";
				when 2 => SEG <= "0100100";
				when 3 => SEG <= "0110000";
				when 4 => SEG <= "0011001";
				when 5 => SEG <= "0010010";
				when 6 => SEG <= "0000010";
				when 7 => SEG <= "1111000";
				when 8 => SEG <= "0000000";
				when 9 => SEG <= "0010000";
				--when 10 => SEG <= not "1110111";
				--when 11 => SEG <= not "1111100";
				--when 12 => SEG <= not "0111001";
				--when 13 => SEG <= not "1011110";
				--when 14 => SEG <= not "1111001";
				--when 15 => SEG <= not "1110001";
		end case;
	end if;
end process;

end Behavioral;

