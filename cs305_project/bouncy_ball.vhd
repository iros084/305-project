library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_SIGNED.all;

entity bouncy_ball is
	port (pb1, pb2, clk, vert_sync : IN std_logic;
		pixel_row, pixel_column	    : IN std_logic_vector(9 downto 0);
		red, green, blue 			    : OUT std_logic);
end entity;

architecture behavior of bouncy_ball is

	signal ball_on, ground_on           : std_logic;
	signal size                         : std_logic_vector(9 downto 0);
	signal ground_x_size, ground_y_size : std_logic_vector(9 downto 0);
	signal ball_y_pos		               : std_logic_vector(9 downto 0);
	signal ball_x_pos		               : std_logic_vector(10 downto 0);
	signal ground_x_pos                 : std_logic_vector(10 downto 0);
	signal ground_y_pos                 : std_logic_vector(9 downto 0);
	signal ball_y_motion	               : std_logic_vector(9 downto 0);

begin           
	-- ball_x_pos and ball_y_pos show the (x, y) for the centre of ball
	size <= CONV_STD_LOGIC_VECTOR(8, 10);
	ball_x_pos <= CONV_STD_LOGIC_VECTOR(320, 11);
	
	
	-- likewise for the ground
	ground_x_size <= CONV_STD_LOGIC_VECTOR(320, 10);
	ground_y_size <= CONV_STD_LOGIC_VECTOR(30, 10);
	ground_x_pos <= CONV_STD_LOGIC_VECTOR(320, 11);
	ground_y_pos <= CONV_STD_LOGIC_VECTOR(450, 10);

	ball_on <= '1' when (('0' & ball_x_pos <= '0' & pixel_column + size) and ('0' & pixel_column <= '0' & ball_x_pos + size) -- x_pos - size <= pixel_column <= x_pos + size
					and ('0' & ball_y_pos <= pixel_row + size) and ('0' & pixel_row <= ball_y_pos + size))  else	                -- y_pos - size <= pixel_row <= y_pos + size
					'0';
	
	ground_on <= '1' when (('0' & ground_x_pos <= '0' & pixel_column + ground_x_size) and ('0' & pixel_column <= '0' & ground_x_pos + ground_x_size) -- x_pos - size <= pixel_column <= x_pos + size
					and ('0' & ground_y_pos <= pixel_row + ground_y_size) and ('0' & pixel_row <= ground_y_pos + ground_y_size)) else	       -- y_pos - size <= pixel_row <= y_pos + size
					'0';


	-- Colours for pixel data on video signal
	-- Changing the background and ball colour by pushbuttons
	red <= ball_on;
	green <= ground_on;
	blue <= (not ball_on) and (not ground_on);
	

	Move_Ball: process (vert_sync)
	begin
		-- Move ball once every vertical sync
		if (rising_edge(vert_sync)) then
			if (pb1='0' and ('0' & ball_y_pos <= CONV_STD_LOGIC_VECTOR(0, 10) + size)) then
				ball_y_motion <= CONV_STD_LOGIC_VECTOR(0, 10);
			elsif (pb1='0') then
				ball_y_motion <= - CONV_STD_LOGIC_VECTOR(6, 10);
			elsif (('0' & ball_y_pos >= ground_y_pos - ground_y_size - size)) then
				ball_y_motion <= CONV_STD_LOGIC_VECTOR(0, 10);
			else
				ball_y_motion <= CONV_STD_LOGIC_VECTOR(2, 10);
			end if;
			
			-- Compute next ball Y position
			ball_y_pos <= ball_y_pos + ball_y_motion;
		end if;
	end process;

end architecture;
