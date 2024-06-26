library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;

entity bouncy_ball is
	port (clk, vert_sync, mouse_click, enable_in, pause_in : in std_logic;
		left_button, right_button : in std_logic;
		pixel_row, pixel_column	  : in std_logic_vector(9 downto 0);
		pipe_on                   : in std_logic;
		red, green, blue, ball_state : out std_logic;
		collision, enable_out     : out std_logic);
end entity;

architecture behavior of bouncy_ball is

	signal ball_on, ground_on, background_on : std_logic;
	signal size_x                            : std_logic_vector(10 downto 0);
	signal size_y                            : std_logic_vector(9 downto 0);
	signal ground_x_size, ground_y_size      : std_logic_vector(9 downto 0);
	signal ball_y_pos		                    : std_logic_vector(9 downto 0);
	signal ball_x_pos		                    : std_logic_vector(10 downto 0);
	signal ground_x_pos                      : std_logic_vector(10 downto 0);
	signal ground_y_pos                      : std_logic_vector(9 downto 0);
	signal ball_y_motion	                    : std_logic_vector(9 downto 0);
	signal collision_count                   : integer := 0; -- collision counter
	signal enable, notEnable                 : std_logic;
	
	-- sprite signals
	signal p_a : std_logic_vector(5 downto 0) := "010000";
	
	signal p_row : std_logic_vector(9 downto 0);-- := conv_std_logic_vector(200, 10);
	signal p_col : std_logic_vector(9 downto 0);-- := conv_std_logic_vector(128, 10);
	
	signal p_R, p_G, p_B : std_logic;
	
	signal Font_R : std_logic := '1';
	signal Font_G : std_logic := '0';
	signal Font_B : std_logic := '0';
	
	signal Multiplier : integer := 4;
	
	component ball_sprite_printer is
		port(pixel_row, pixel_col, a_row, a_col : in std_logic_vector(9 downto 0);
			s_red, s_green, s_blue               : in std_logic;
			multiplier                           : in integer range 1 to 4;
			address                              : in std_logic_vector (5 downto 0);
			enable, clk                          : in std_logic;
			red_out, green_out, blue_out         : out std_logic);
	end component;

begin           
	-- ball_x_pos and ball_y_pos show the (x, y) for the centre of ball
	size_x <= CONV_STD_LOGIC_VECTOR(8, 11);
	size_y <= CONV_STD_LOGIC_VECTOR(8, 10);
	
	ball_x_pos <= CONV_STD_LOGIC_VECTOR(320, 11);
	
	-- likewise for the ground
	ground_x_size <= CONV_STD_LOGIC_VECTOR(320, 10);
	ground_y_size <= CONV_STD_LOGIC_VECTOR(30, 10);
	ground_x_pos <= CONV_STD_LOGIC_VECTOR(320, 11);
	ground_y_pos <= CONV_STD_LOGIC_VECTOR(449, 10);

	ball_on <= '1' when (('0' & ball_x_pos <= '0' & pixel_column + size_y) and ('0' & pixel_column <= '0' & ball_x_pos + size_y) -- x_pos - size <= pixel_column <= x_pos + size
					and ('0' & ball_y_pos <= pixel_row + size_y) and ('0' & pixel_row <= ball_y_pos + size_y))  else	              -- y_pos - size <= pixel_row <= y_pos + size
					'0';
	
	ground_on <= '1' when (('0' & ground_x_pos <= '0' & pixel_column + ground_x_size) and ('0' & pixel_column <= '0' & ground_x_pos + ground_x_size) -- x_pos - size <= pixel_column <= x_pos + size
					and ('0' & ground_y_pos <= pixel_row + ground_y_size) and ('0' & pixel_row <= ground_y_pos + ground_y_size)) else	                   -- y_pos - size <= pixel_row <= y_pos + size
					'0';

	background_on <= (not ball_on) and (not ground_on);

	
   -- Colours for pixel data on video signal
	-- Changing the background and ball colour by pushbuttons
	red <= ball_on; -- or p_R;
	green <= ground_on;-- or p_G;
	blue <= background_on;-- or p_B;
	
	p_row <= ball_y_pos - CONV_STD_LOGIC_VECTOR(50, 10);
	p_col <= CONV_STD_LOGIC_VECTOR(320 - 50, 10);
	
	bird: ball_sprite_printer port map(pixel_row, pixel_column, p_row, p_col, Font_R, Font_G, Font_B, Multiplier, p_a, enable_in, clk, p_R, p_G, p_B);
	
	
	
	-- SR latch
	--
	-- S = mouse_click
	-- R = not enable_in
	-- Q = enable
	-- notQ = not enable
	--
	-- S | R | Q | notQ
	-- 0 | 0 | L |  L
	-- 0 | 1 | 0 |  1
	-- 1 | 0 | 1 |  0
	-- 1 | 1 | 0 |  0
	--
	-- Q <= R nor notQ;
	-- notQ <= S nor Q;
	enable <= (not enable_in) nor notEnable;
	notEnable <= mouse_click nor enable;
	
	enable_out <= enable;
	collision <= enable and ball_on and (pipe_on or ground_on);
	
	
	ball_state <= ball_on when (pixel_column > conv_std_logic_vector(311, 10) and pixel_column < conv_std_logic_vector(329, 10)) else
              '0';
   
--	process(collision_in)
--	begin
--		if(rising_edge(collision_in)) then
--			
--		end if;
--	end process;
	
	Ball_Mot: process (vert_sync, left_button)
	begin
		if (pause_in = '1') then
			ball_y_motion <= CONV_STD_LOGIC_VECTOR(0, 10);
		elsif (left_button='1' and ('0' & ball_y_pos <= CONV_STD_LOGIC_VECTOR(0, 10) + size_y)) then
			ball_y_motion <= CONV_STD_LOGIC_VECTOR(0, 10);
		elsif (left_button='1') then
			ball_y_motion <= - CONV_STD_LOGIC_VECTOR(6, 10);
		elsif (rising_edge(vert_sync)) then
			if ( ('0' & ball_y_pos >= ground_y_pos - ground_y_size - size_y) ) then
				ball_y_motion <= CONV_STD_LOGIC_VECTOR(0, 10);
			else
				ball_y_motion <= ball_y_motion + CONV_STD_LOGIC_VECTOR(1, 10);
			end if;
		end if;
	end process;
	
	Ball_Pos: process (vert_sync)
	begin
		if (rising_edge(vert_sync)) then
			if (enable = '1') then
				if (('0' & (ball_y_pos + ball_y_motion) >= ground_y_pos - ground_y_size - size_y)) then
					ball_y_pos <= ground_y_pos - ground_y_size - size_y;
				elsif ('0' & (ball_y_pos + ball_y_motion) <= CONV_STD_LOGIC_VECTOR(0, 10) + size_y) then
					ball_y_pos <= CONV_STD_LOGIC_VECTOR(0, 10) + size_y;
				else
					ball_y_pos <= ball_y_pos + ball_y_motion;
				end if;
			else
				ball_y_pos <= CONV_STD_LOGIC_VECTOR(240, 10) - ground_y_size;
			end if;
		end if;
	end process;

end architecture;
