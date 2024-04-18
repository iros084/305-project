library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity bcd_counter is
	port(Clk, Direction, Init, Enable: in std_logic;
			Q_Out: out std_logic_vector(3 downto 0));
end entity bcd_counter;

architecture behaviour of bcd_counter is
	signal s_Q: std_logic_vector(3 downto 0);
begin
	process(Clk)
	begin
		if (rising_edge(Clk)) then
			if (Enable = '1') then
				if (Init = '1') then
					if (Direction = '0') then
						s_Q <= "0000";
					else
						s_Q <= "1001";
					end if;
				else
					if (Direction = '0') then
						if (s_Q = "1001") then
							s_Q <= "0000";
						else
							s_Q <= s_Q + "0001";
						end if;
					else
						if (s_Q = "0000") then
							s_Q <= "1001";
						else
							s_Q <= s_Q - "0001";
						end if;
					end if;
				end if;
			end if;
		end if;
	end process;

	Q_Out <= s_Q;
end architecture behaviour;