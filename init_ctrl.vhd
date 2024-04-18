library IEEE;
use IEEE.std_logic_1164.all;

entity init_ctrl is
	port (Clk_in, Start_in: in std_logic;
		Init_minute, Init_seconds_ten, Init_seconds_one, Init_out: out std_logic);
end entity;

architecture behaviour of init_ctrl is
begin
	process(Clk_in, Start_in)
		variable count: integer := 0;
	begin
		if (Start_in = '1') then
			count := 0;
			Init_minute <= '0', '1' after 1 ns, '0' after 2 ns;
			Init_seconds_ten <= '0', '1' after 1 ns, '0' after 2 ns;
			Init_seconds_one <= '0', '1' after 1 ns, '0' after 2 ns;
		elsif (rising_edge(Clk_in)) then
			if (count = 59) then
				Init_seconds_ten <= '0', '1' after 1 ns, '0' after 5 ns;
				Init_out <= '0', '1' after 1 ns, '0' after 2 ns;
				count := 0;
			else
				count := count + 1;
			end if;
		end if;
	end process;
end architecture behaviour;