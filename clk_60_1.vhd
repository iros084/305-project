library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity clk_60_1 is
	port(Clk_in, Start_in: in std_logic;
		Clk_out: out std_logic);
end entity clk_60_1;

architecture behaviour of clk_60_1 is
begin
	process(Clk_in, Start_in)
		variable count: integer := 1;
		variable initial: integer := 0;
		variable v_clk: std_logic := '0';
	begin
		if (Start_in = '1') then
			initial := 0;
			count := 1;
			v_clk := '0';
			Clk_out <= '0', '1' after 1 ns, '0' after 2 ns;
		elsif (rising_edge(Clk_in)) then
			if (initial < 30) then
				initial := initial + 1;
			elsif (count = 30) then
				v_clk := not v_clk;
				count := 1;
			else
				count := count + 1;
			end if;

			Clk_out <= v_clk;
		end if;
	end process;
end architecture behaviour;