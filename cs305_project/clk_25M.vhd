library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity clk_25M is
	port (clk_in: in std_logic;
		clk_out: out std_logic);
end entity;

architecture behaviour of clk_25M is
begin
	process(clk_in)
		variable v_clk: std_logic;
		variable counter: integer;
	begin
		if (rising_edge(clk_in)) then
			if (counter = 1) then
				counter := 0;
				v_clk := not v_clk;
			else
				counter := counter + 1;
			end if;
		end if;
		
		clk_out <= v_clk;
	end process;
end architecture;