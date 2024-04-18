library IEEE;
use IEEE.std_logic_1164.all;

entity multi_signal_vector is
	port(s_in: in std_logic_vector(3 downto 0);
		s_out_1, s_out_2: out std_logic_vector(3 downto 0));
end entity;

architecture behaviour of multi_signal_vector is
begin
	s_out_1 <= s_in;
	s_out_2 <= s_in;
end architecture behaviour;