library IEEE;
use IEEE.std_logic_1164.all;

entity seven_seg is
	port (digit: in std_logic_vector(3 downto 0);
		SevenSeg_out: out std_logic_vector(6 downto 0));
end entity;

architecture behaviour of seven_seg is
begin
	SevenSeg_out <= "1111001" when digit = "0001" else
		"0100100" when digit = "0010" else
		"0110000" when digit = "0011" else
		"0011001" when digit = "0100" else
		"0010010" when digit = "0101" else
		"0000010" when digit = "0110" else
		"1111000" when digit = "0111" else
		"0000000" when digit = "1000" else
		"0010000" when digit = "1001" else
		"1000000" when digit = "0000" else
		"1111111";
end architecture behaviour;
