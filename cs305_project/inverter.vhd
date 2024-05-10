library IEEE;
use IEEE.std_logic_1164.all;

entity inverter is
	port (Q_in: in std_logic;
		Q_out: out std_logic);
end entity;

architecture behaviour of inverter is
begin
	Q_out <= not Q_in;
end architecture behaviour;