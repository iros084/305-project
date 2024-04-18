library IEEE;
use IEEE.std_logic_1164.all;

entity timer_finish is
	port (minute_in, seconds_ten_in, seconds_one_in: in std_logic_vector(3 downto 0);
		date_in: in std_logic_vector(9 downto 0);
		finish_out: out std_logic);
end entity;

architecture behaviour of timer_finish is
begin
	finish_out <= '1' when (minute_in="00"&date_in(9 downto 8) and seconds_ten_in=date_in(7 downto 4) and seconds_one_in=date_in(3 downto 0)) else '0';
end architecture behaviour;