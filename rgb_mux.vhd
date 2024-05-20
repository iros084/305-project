library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_arith.all;

entity rgb_mux is
	port(in1, in2, in3, in4, in5, in6, in7, in8, in9, mux, e1, e2, e3: in std_logic;
		r_out, g_out, b_out                 : out std_logic);
end entity;

architecture behaviour of rgb_mux is
begin

	r_out <= e1 when mux='1' else in1 and in7;
	g_out <= e2 when mux='1' else in2 and in8;
	b_out <= e3 when mux='1' else in3 and in9;
end architecture behaviour;