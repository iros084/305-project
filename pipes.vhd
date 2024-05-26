library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity pipes is
	port (clk, horiz_sync, vert_sync, enable, reset, pause, collision_in   : in std_logic;
		pixel_row, pixel_column, pipe_height                  : in std_logic_vector(9 downto 0);
		speed                                                 : in std_logic_vector(8 downto 0);
		init                                                  : in std_logic_vector(10 downto 0);
		col                                                   : in std_logic;
		Red, Green, Blue, pipe_s, coin_s, count, initial, rst : out std_logic;
		life_count: out std_logic_vector(3 downto 0);
		pipe_on_out                                           : out std_logic);
end entity;

architecture b1 of pipes is

	signal width1                                            : std_logic_vector(9 downto 0);
	signal pipeA_on, pipeB_on, power, pipe_on, c_R, c_G, c_B : std_logic;
	signal pipe_x                                            : std_logic_vector(10 downto 0);
	signal pipe_h, c_row, c_column                           : std_logic_vector(9 downto 0);
	signal timer1                                            : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(0,10); 
	signal t_power                                           : std_logic_vector(8 downto 0);  
	Signal Font_R                                            : std_logic := '0'; 
	Signal Font_G                                            : std_logic := '1';
	Signal Font_B                                            : std_logic := '0';
	Signal Multiplier                                        : integer := 3;
	signal c_address                                         : std_logic_vector(5 downto 0) := "100111";
	signal reset_pipe,collision_state                                       : std_logic := '0';
	signal life_count1 : std_logic_vector(3 downto 0):="0000"; 
	signal t_ball_reset :std_logic := '0';
    
	type position is record
		y_pos : std_logic_vector(9 downto 0);
	  x_pos : std_logic_vector (10 downto 0);
	end record;

component SPRITE_PRINTER is
    port(
        pixel_row, pixel_col, a_row, a_col : in std_logic_vector(9 downto 0);
        s_red, s_green, s_blue             : in std_logic;
        multiplier                         : in integer range 1 to 4;
        address                            : in std_logic_vector(5 downto 0);
        enable, clk                        : in std_logic;
        red_out, green_out, blue_out       : out std_logic
    );
end component;

component rand_gen is 
    port(
        clk, rand_st : in std_logic;
        psudo        : out std_logic_vector(8 downto 0)
    );
end component;

function update_position (y_pos       : std_logic_vector(9 downto 0);
                          x_pos       : std_logic_vector (10 downto 0);
                          pipe_height : std_logic_vector(9 DOWNTO 0)) return position is
    variable p1: position;
begin
    if x_pos = CONV_STD_LOGIC_VECTOR(0,11) then
        p1.x_pos := CONV_STD_LOGIC_VECTOR(760,11);
        if pipe_height > CONV_STD_LOGIC_VECTOR(336,10) then
            p1.y_pos := CONV_STD_LOGIC_VECTOR(336,10);
        else
            p1.y_pos := pipe_height;
        end if;
    else
        p1.x_pos := x_pos - 1;
        p1.y_pos := y_pos;
    end if;
    
    return p1;
end function;

begin

    pipe_on_out <= pipe_on;

    width1 <= CONV_STD_LOGIC_VECTOR(80,10);
    count <= '1' when (pipe_x = conv_std_logic_vector(311, 10) and pipe_h < conv_std_logic_vector(700,10)) else '0';

    pipeA_on <= '1' when ('0' & pixel_column <= '0' & pipe_x) and (('0' & pipe_x <= '0' & pixel_column + width1) and ('0' & pixel_row <= pipe_h) and (pipe_h < CONV_STD_LOGIC_VECTOR(700,10))) else '0';

    pipeB_on <= '1' when ('0' & pixel_column <= '0' & pipe_x) and (('0' & pipe_x <= '0' & pixel_column + width1) and ('0' & pixel_row >= pipe_h + conv_std_logic_vector(224,10)) and (pipe_h < CONV_STD_LOGIC_VECTOR(700,10))) else '0';

    pipe_on <= pipeB_on or pipeA_on;
    pipe_s <= pipe_on when (pixel_column < conv_std_logic_vector(329, 10) and pixel_column > conv_std_logic_vector(311, 10)) else '0';

    Red <= not pipe_on;-- and c_R;
    Green <= '1';-- and c_G;
    Blue <= not pipe_on;-- and c_B;
    c_row <= pipe_h + CONV_STD_LOGIC_VECTOR(80,9);
    c_column <= pipe_x(9 downto 0) - CONV_STD_LOGIC_VECTOR(52,9);
    coin_s <= c_R when (pixel_column < CONV_STD_LOGIC_VECTOR(329,10) and pixel_column > CONV_STD_LOGIC_VECTOR(311,10)) else '0';

    heightGen: rand_gen port map(clk, reset, t_power);
    --C_S: sprite_printer port map(pixel_row, pixel_column, c_row, c_column, Font_R, Font_G, Font_B, Multiplier, c_address, power, clk, c_R, c_G, c_B);

	 
pipe_M: process (horiz_sync, reset)
		variable pipe_position: position;
	begin
		if rising_edge(horiz_sync) then
		 if reset = '1'then
				power <= '0';
				pipe_x <= init;
				pipe_h <= CONV_STD_LOGIC_VECTOR(700,10);
				initial <= '1';
			
			elsif enable = '1' then
				initial <= '0';
				if pipe_x = CONV_STD_LOGIC_VECTOR(0,11) then
					power <= '1';
				end if;

				if timer1 = speed and pause = '0' then
				
				   if collision_in = '1' then
						collision_state <= '1';
					end if;

					if collision_state = '1' then
					   timer1 <= CONV_STD_LOGIC_VECTOR(0,10);
						pipe_x <= CONV_STD_LOGIC_VECTOR(760, 11);
						collision_state <= '0'; -- Reset the state after moving the pipe
					else
					pipe_position := update_position(pipe_h, pipe_x, pipe_height);
					pipe_x <= pipe_position.x_pos;
					pipe_h <= pipe_position.y_pos;
					timer1 <= CONV_STD_LOGIC_VECTOR(0,10);
					end if;
				else
					timer1 <= timer1 + 1;
				end if;
         end if;
		end if;
	end process;
	life_count <= life_count1;

end architecture;