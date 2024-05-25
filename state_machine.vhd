library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;

entity state_machine is
	port (clk, reset           	                    : in std_logic;
		h_sync, v_sync          	                : in std_logic;
		pixel_row, pixel_column	                    : in std_logic_vector(9 downto 0);
		game, pause, lose                           : in std_logic; -- state inputs
		bouncy_ball_r, bouncy_ball_g, bouncy_ball_b : in std_logic; -- rgb inputs (bouncy_ball)
		pipes_r, pipes_g, pipes_b                   : in std_logic; -- rgb inputs (pipes)
		start_r, start_g, start_b                   : in std_logic; -- rgb inputs (start screen)
		l_r,l_g,l_b: in std_logic;
		endgame_r, endgame_g, endgame_b             : in std_logic; -- rgb inputs (game over screen)
		pause_r, pause_g, pause_b                   : in std_logic; -- rgb inputs (pause screen)
		select1                                      : in std_logic; -- mode select fron switch
		enable                                      : out std_logic; -- for bouncy_ball and pipes components
		red, green, blue 				            : out std_logic);
end entity;

architecture moore of state_machine is

	type state_type is (menu, game_1, game_2, game_3, training, pause_1, pause_2, pause_3, pause_t, game_over);
	signal state, next_state : state_type;

begin

	SYNC_PROC : process (clk)
	begin
		if (rising_edge(clk)) then
			if (reset = '0') then
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
				red   <= start_r;
				green <= start_g;
				blue  <= start_b;
				enable <= '0';
			when game_1 =>
				red   <= bouncy_ball_r and pipes_r and l_r;
				green <= bouncy_ball_g and pipes_g and l_g;
				blue  <= bouncy_ball_b and pipes_b and l_b;
				enable <= '1';
--			when game_2 =>
--				red   <= bouncy_ball_r and pipes_r and l_r ;
--				green <= bouncy_ball_g and pipes_g and l_g;
--				blue  <= bouncy_ball_b and pipes_b and l_b;
--				enable <= '1';
--			when game_3 =>
--				red   <= bouncy_ball_r and pipes_r and l_r;
--				green <= bouncy_ball_g and pipes_g and l_g;
--				blue  <= bouncy_ball_b and pipes_b and l_b;
--				enable <= '1';
			when training =>
				red   <= bouncy_ball_r and pipes_r and l_r;
				green <= bouncy_ball_g and pipes_g and l_g;
				blue  <= bouncy_ball_b and pipes_b and l_b;
				enable <= '1';
			when pause_1 =>
				red   <= pause_r;
				green <= pause_g;
				blue  <= pause_b;
				enable <= '0';
			when pause_2 =>
				red   <= pause_r;
				green <= pause_g;
				blue  <= pause_b;
				enable <= '0';
			when pause_3 =>
				red   <= pause_r;
				green <= pause_g;
				blue  <= pause_b;
				enable <= '0';
			when pause_t =>
				red   <= pause_r;
				green <= pause_g;
				blue  <= pause_b;
				enable <= '0';
			when game_over =>
				red   <= endgame_r;
				green <= endgame_g;
				blue  <= endgame_b;
				enable <= '0';
			when others =>
				red   <= start_r;
				green <= start_g;
				blue  <= start_b;
				enable <= '0';
		end case;
	end process;
	
	NEXT_STATE_DECODE : process (state, game, pause, select1)
	begin
		case (state) is
			when menu =>
				if (game = '0') then
					if (select1 = '1') then
						next_state <= game_1;
					else
						next_state <= training;
					end if;
				else
					next_state <= menu;
				end if;
			when game_1 =>
				if (lose = '1') then
					next_state <= game_over;
				elsif (pause = '0') then
					next_state <= pause_1;
				else
					next_state <= game_1;
				end if;
--			when game_2 =>
--				if (pause_button = '0') then
--					next_state <= game_3;
--				else
--					next_state <= pause_2;
--				end if;
--			when game_3 =>
--				if (pause_button = '0') then
--					next_state <= game_over;
--				else
--					next_state <= pause_3;
--				end if;
			when training =>
				if (lose = '1') then
					next_state <= game_over;
				elsif (pause = '0') then
					next_state <= pause_t;
				else
					next_state <= training;
				end if;
			when pause_1 =>
				if (pause = '1') then
					next_state <= game_1;
				else
					next_state <= pause_1;
				end if;
--			when pause_2 =>
--				if (pause_button = '1') then
--					next_state <= game_2;
--				else
--					next_state <= pause_2;
--				end if;
--			when pause_3 =>
--				if (pause_button = '1') then
--					next_state <= game_3;
--				else
--					next_state <= pause_3;
--				end if;
			when pause_t =>
				if (pause = '1') then
					next_state <= training;
				else
					next_state <= pause_t;
				end if;
			when game_over =>
				if (reset = '0') then
					next_state <= menu;
				else
					next_state <= game_over;
				end if;
			when others =>
				next_state <= menu;
--				if (x = '1') then
--					next_state <= menu;
--				end if;
		end case;
	end process;

end architecture;