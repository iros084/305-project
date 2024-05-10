library IEEE;
use IEEE.std_logic_1164.all;

entity seven_seg is
	port (digit: in std_logic_vector(9 downto 0);
		SevenSeg_out: out std_logic_vector(6 downto 0));
end entity;

architecture behaviour of seven_seg is
begin
	SevenSeg_out <= "1111001" when digit = "0001000000" else
		"0100100" when digit = "0010000000" else
		"0110000" when digit = "0011000000" else
		"0011001" when digit = "0100000000" else
		"0010010" when digit = "0101000000" else
		"0000010" when digit = "0110000000" else
		"1111000" when digit = "0111000000" else
		"0000000" when digit = "1000000000" else
		"0010000" when digit = "1001000000" else
		"1000000" when digit = "0000000000" else
		"1111111";
end architecture behaviour;