library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;

entity bouncy_ball is
	port (clk, vert_sync, mouse_click : in std_logic;
		left_button, right_button : in std_logic;
		pixel_row, pixel_column	  : in std_logic_vector(9 downto 0);
		pipe_on                   : in std_logic;
		red, green, blue          : out std_logic;
		collision               : out std_logic);
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
	signal enable : std_logic;

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
	red <= ball_on;
	green <= ground_on;
	blue <= background_on;

	process (mouse_click)
	begin
		if (rising_edge(mouse_click)) then
			enable <= '1';
		end if;
	end process;
	
	collision <= pipe_on and ball_on and enable;
	
	Ball_Mot: process (vert_sync, left_button)
	begin
		if (left_button='1' and ('0' & ball_y_pos <= CONV_STD_LOGIC_VECTOR(0, 10) + size_y)) then
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
