library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_SIGNED.all;

entity state_machine is
	port (clk, reset           : in std_logic;
		x                       : in std_logic;
		h_sync, v_sync          : in std_logic;
		pixel_row, pixel_column	: in std_logic_vector(9 downto 0);
		red, green, blue 			: out std_logic);
end entity;

architecture moore of state_machine is

	type state_type is (menu, game_1, game_2, game_3, training, pause_g, pause_t, game_over);
	signal state, next_state : state_type;

begin           

	SYNC_PROC : process (clk)
	begin
		if (rising_edge(clk)) then
			if (reset = '1') then
				state <= menu;
			else
				state <= next_state;
			end if;
		end if;
	end process;
	
	OUTPUT_DECODE : process (state)
	begin
		case (state) is
			when menu =>
				red   <= ;
				green <= ;
				blue  <= ;
			when game_1 =>
				red   <= ;
				green <= ;
				blue  <= ;
			when game_2 =>
				red   <= ;
				green <= ;
				blue  <= ;
			when game_3 =>
				red   <= ;
				green <= ;
				blue  <= ;
			when training =>
				red   <= ;
				green <= ;
				blue  <= ;
			when pause_g =>
				red   <= ;
				green <= ;
				blue  <= ;
			when pause_t =>
				red   <= ;
				green <= ;
				blue  <= ;
			when game_over =>
				red   <= ;
				green <= ;
				blue  <= ;
			when others =>
				red   <= ;
				green <= ;
				blue  <= ;
		end case;
	end process;
	
	NEXT_STATE_DECODE : process (state, x)
	begin
		next_state <= menu;
		case (state) is
			when menu =>
				if (x = '1') then
					next_state <= game_1;
				else
					next_state <= training;
				end if;
			when game_1 =>
				if (x = '1') then
					next_state <= game_2;
				else
					next_state <= pause_g;
				end if;
			when game_2 =>
				if (x = '1') then
					next_state <= game_3;
				else
					next_state <= pause_g;
				end if;
			when game_3 =>
				if (x = '1') then
					next_state <= game_over;
				else
					next_state <= pause_g;
				end if;
			when training =>
				if (x = '1') then
					next_state <= game_over;
				else
					next_state <= pause_t;
				end if;
			when pause_g =>
				if (x = '1') then
					next_state <= ;
				else
					next_state <= pause_g;
				end if;
			when pause_t =>
				if (x = '1') then
					next_state <= training;
				else
					next_state <= pause_t;
				end if;
			when game_over =>
				if (x = '1') then
					next_state <= menu;
				else
					next_state <= game_over;
				end if;
			when others =>
				if (x = '1') then
					next_state <= menu;
				end if;
		end case;
	end process;

end architecture;
