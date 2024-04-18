library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity clk_50M_1 is
	port(Clk_in: in std_logic;
		Clk_out: out std_logic);
end entity clk_50M_1;

architecture behaviour of clk_50M_1 is
begin
	process(Clk_in)
		variable count: integer := 1;
		variable v_clk: std_logic := '0';
	begin
		if (rising_edge(Clk_in)) then
			if (count = 25000000) then
				v_clk := not v_clk;
				count := 1;
			else
				count := count + 1;
			end if;

			Clk_out <= v_clk;
		end if;
	end process;
end architecture behaviour;