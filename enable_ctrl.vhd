library IEEE;
use IEEE.std_logic_1164.all;

entity enable_ctrl is
	port (Start_in, Finish_in: in std_logic;
		Enable_out: out std_logic);
end entity;

architecture behaviour of enable_ctrl is
begin
	process(Start_in, Finish_in)
		variable v_E: std_logic := '0';
	begin
		if (Start_in = '1') then
			v_E := '1';
		elsif (Finish_in = '1') then
			v_E := '0';
		end if;

		Enable_out <= v_E;
	end process;
end architecture behaviour;