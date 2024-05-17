library IEEE;
use IEEE.std_logic_1164.all;

entity rgb_mux is
	port(in1, in2, in3, in4, in5, in6, in7, in8, in9, mux: in std_logic;
		r_out, g_out, b_out: out std_logic);
end entity;

architecture behaviour of rgb_mux is
begin
	r_out <= in1 and in7 when mux='1' else in4;
	g_out <= in2 and in8 when mux='1' else in5;
	b_out <= in3 and in9 when mux='1' else in6;
end architecture behaviour;