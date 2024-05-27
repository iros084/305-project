library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_arith.all;

entity cs305_project is
	port (Clk, pb0, pb1, pb2, pb3, sw0                              : in std_logic;
		red_out, green_out, blue_out, horiz_sync_out, vert_sync_out : out std_logic;
		mouse_data, mouse_clk                                       : inout std_logic);
end entity;

architecture structural of cs305_project is

	component cs305_pll is
		port (refclk : in  std_logic := '0'; -- refclk.clk
			rst       : in  std_logic := '0'; -- reset.reset
			outclk_0  : out std_logic);       -- outclk0.clk
	end component;
	
	component vga_sync is
		port (clock_25Mhz, red, green, blue		                        : in std_logic;
			red_out, green_out, blue_out, horiz_sync_out, vert_sync_out	: out std_logic;
			pixel_row, pixel_column                                     : out std_logic_vector(9 downto 0));
	end component;
	
	component bouncy_ball is
		port (clk, vert_sync, mouse_click, enable_in, pause_in : in std_logic;
			left_button, right_button : in std_logic;
			pixel_row, pixel_column	  : in std_logic_vector(9 downto 0);
			pipe_on                   : in std_logic;
			red, green, blue,ball_state          : out std_logic;
			collision, enable_out     : out std_logic);
	end component;
	
	component mouse is
		port (clock_25Mhz, reset 	  : in std_logic;
			mouse_data				  : inout std_logic;
			mouse_clk 				  : inout std_logic;
			left_button, right_button : out std_logic;
			mouse_cursor_row 		  : out std_logic_vector(9 DOWNTO 0); 
			mouse_cursor_column 	  : out std_logic_vector(9 DOWNTO 0));       	
	end component;
	
	component life is
  		port (clk, rst, dir, col_detect : in std_logic;
			pixel_row, pixel_col        : in std_logic_vector(9 downto 0);
			red, green, blue, ending    : out std_logic);	
	end component;
	
	component start is
		port (pixel_row, pixel_col          : in std_logic_vector(9 downto 0);
			Clk, enable, mode_sel           : in std_logic;  -- if mode sel is '1', its game mode/ '0' is tutorial mode
			Red_out1, Green_out1, Blue_out1 : out std_logic);
	end component;
	
	component state_machine is
		port (clk, reset           	                    : in std_logic;
			h_sync, v_sync          	                : in std_logic;
			pixel_row, pixel_column	                    : in std_logic_vector(9 downto 0);
			game, pause, lose,ending1                           : in std_logic; -- state inputs
			bouncy_ball_r, bouncy_ball_g, bouncy_ball_b : in std_logic; -- rgb inputs (bouncy_ball)
			pipes_r, pipes_g, pipes_b                   : in std_logic; -- rgb inputs (pipes)
			start_r, start_g, start_b                   : in std_logic; -- rgb inputs (start screen)
			l_r, l_g, l_b                               : in std_logic;
			live_count : in std_logic_vector(3 downto 0);
			endgame_r, endgame_g, endgame_b             : in std_logic; -- rgb inputs (game over screen)
			pause_r, pause_g, pause_b                   : in std_logic; -- rgb inputs (pause screen)
			select1                                     : in std_logic;
			enable, pause_out                                      : out std_logic;
			red, green, blue 				            : out std_logic);
	end component;
	
	component rand_gen is 
      	port (clk, rand_st : in std_logic;
			psudo          : out std_logic_vector(8 downto 0));
   	end component;
	
	component pipes is
		port(clk, horiz_sync, vert_sync, enable, reset, pause, collision_in            : in std_logic;
			pixel_row, pixel_column, pipe_height                  : in std_logic_vector(9 downto 0);
			speed                                                 : in std_logic_vector(8 downto 0);
			init                                                  : in std_logic_vector(10 downto 0);
			col                                                   : in std_logic;
			Red, Green, Blue, pipe_s, coin_s, count, initial, rst : out std_logic;
			life_count: out std_logic_vector(3 downto 0);
			pipe_on_out                                           : out std_logic);
	end component;
	
	component endgame is
		port (pixel_row, pixel_col          : in std_logic_vector(9 downto 0);
			Clk, enable, mode               : in std_logic;
			tenth_digit, one_digit          : in std_logic_vector(3 downto 0);				
			Red_out2, Green_out2, Blue_out2 : out std_logic);
	end component;

	component Two_Digit_Counter is
      	port (clk, Init, Enable : in std_logic;
			t_out, f_out        : out std_logic_vector(3 downto 0);
			display1, display2  : out std_logic_vector(6 downto 0));
    end component;
	 
	 component speed_control is
        port (clk       : in std_logic;
            rst         : in std_logic;
			mode        : in std_logic;
            ones_digit1 : in std_logic_vector(3 downto 0);
            tens_digit1 : in std_logic_vector(3 downto 0);
            speed1      : out std_logic_vector(8 downto 0));
    end component;
	 
	component coll_detect is
  	PORT (
		clk, bouncy_ball_on, pipe_on : IN std_logic;
		input: OUT std_logic
	);	
  end component;

	
	signal s1, s2, s3, s4, s5, s6, s7, s8, s11, s14, s15, s16, s17, s18, s19, s20, s25, s26, s27, s28, s29, s30, s31, s32: std_logic;
	signal s9, s10, s12, s13    : std_logic_vector(9 downto 0);
	signal s22                  : std_logic_vector(8 downto 0);
	signal s24                  : std_logic_vector(10 downto 0) :=  conv_std_logic_vector(678, 11);
	signal t_h                  : std_logic_vector(9 downto 0);
	signal t_p                  : std_logic_vector(8 downto 0);
	signal t_horz, t_vert       : std_logic;
	signal t_tens, t_ones, t_t,t_l  : std_logic_vector(3 downto 0);
	signal e1, e2, e3           : std_logic;
	signal s33, s35             : std_logic_vector(10 downto 0);
	signal s34, s36             : std_logic_vector(9 downto 0);
	signal display11, display22 : std_logic_vector(6 downto 0);
	signal t_reset              : std_logic;
	signal speed11              : std_logic_vector(8 downto 0); -- Speed signal
	signal t_ending             : std_logic;
	signal sn1, sn2, sn3,t_out,t_pipe_ball_reset,t_ball        : std_logic;
	--s20 <= '1';
	
	signal s_l, s_out, s_enable, s_e, s_pause : std_logic;
	signal button_pause: std_logic := '0';
	
begin

	t_reset <= '1' when (pb3 = '0') else '0';
	 
	--s_l <= '0' when t_reset <= '1';

	horiz_sync_out <= t_horz;
	vert_sync_out <= s8;
	t_h <= '0' & t_p;
	t_pipe_ball_reset <= '1' when (t_reset = '1' or t_out = '1') else '0' when s31 = '1';
	
	process(pb2)
	begin
		if (rising_edge(pb2)) then
			button_pause <= not button_pause;
		end if;
	end process;
	
	
	C1: cs305_pll
		port map(
			refclk   => Clk,
			rst      => '0',
			outclk_0 => s1
	);
	cc2:  coll_detect port map(s1,t_ball,s28,t_out);

	V1: vga_sync
		port map(
			clock_25Mhz    => s1,
			red            => s5,
			green          => s6,
			blue           => s7,
			red_out        => red_out,
			green_out      => green_out,
			blue_out       => blue_out,
			horiz_sync_out => t_horz,
			vert_sync_out  => s8,
			pixel_row      => s9,
			pixel_column   => s10
	);

	B1: bouncy_ball
		port map(
			clk          => s1,
			vert_sync    => s8,
			enable_in    => s_enable,
			pause_in     => s_pause,
			mouse_click  => s14,
			left_button  => s14,
			right_button => s15,
			pixel_row    => s9,
			pixel_column => s10,
			pipe_on      => s_out,
			red          => s2,
			green        => s3,
			blue         => s4,
			ball_state => t_ball,
			collision    => s_l,
			enable_out   => s_e
	);

	M1: mouse
		port map(
			clock_25Mhz         => s1,
			reset               => '0', 
			mouse_data          => mouse_data,
			mouse_clk           => mouse_clk,
			left_button         => s14,
			right_button        => s15,
			mouse_cursor_row    => s12,
			mouse_cursor_column => s13
	);

	P1: start
		port map(
			pixel_row  => s9,
			pixel_col  => s10,
			Clk        => s1,
			enable     => '1',
			mode_sel   => s19,
			Red_out1   => s16,
			Green_out1 => s17,
			Blue_out1  => s18
	);

	Rn1: rand_gen
		port map(
			clk     => s1,
			rand_st => pb3,
			psudo   => t_p
	);

	d1: pipes
		port map(
			clk          => s1,
			horiz_sync   => t_horz,
			vert_sync    => s8,
			enable       => s_e,
			reset        => t_pipe_ball_reset,
			pause        => s_pause,
			collision_in => t_out,
			pixel_row    => s9,
			pixel_column => s10,
			pipe_height  => t_h,
			speed        => speed11,
			init         => s24,
			Red          => s25,
			Green        => s26,
			Blue         => s27,
			pipe_s       => s28,
			coin_s       => s29,
			count        => s30,
			initial      => s31,
			col          => s_l,
			rst          => s32,
			life_count   => t_l,
			pipe_on_out  => s_out
	);

	R1: state_machine
		port map(
			clk           => s1,
			reset         => pb0,
			h_sync        => t_horz,
			v_sync        => s8,
			pixel_row     => s9,
			pixel_column  => s10,
			game          => pb1,
			pause         => button_pause,
			lose          => s_l,
			ending1       => t_ending,
			bouncy_ball_r => s2,
			bouncy_ball_g => s3,
			bouncy_ball_b => s4,
			pipes_r       => s25,
			pipes_g       => s26,
			pipes_b       => s27,
			start_r       => s16,
			start_g       => s17,
			start_b       => s18,
			l_r           => sn1,
			l_g           => sn2,
			l_b           => sn3,
			live_count    => t_l,
			endgame_r     => e1,
			endgame_g     => e2,
			endgame_b     => e3,
			pause_r       => '1', -- temp
			pause_g       => '1',
			pause_b       => '1',
			select1       => sw0,
			enable        => s_enable,
			pause_out     => s_pause,
			red           => s5,
			green         => s6,
			blue          => s7
	);

	o1: endgame
		port map(
			pixel_row   => s9,
			pixel_col   => s10,
			Clk         => s1,
			enable      => '1',
			mode        => sw0,
			tenth_digit => t_tens,
			one_digit   => t_ones,
			Red_out2    => e1,
			Green_out2  => e2,
			Blue_out2   => e3
	);

	seg: Two_Digit_Counter 
		port map(
			clk      => s1, 
			Init     => t_reset, 
			Enable   => s30, 
			t_out    => t_tens, 
			f_out    => t_ones, 
			display1 => display11, 
			display2 => display22
	);

	sc: speed_control
		port map(
			clk         => s1,
			rst         => t_reset,
			mode        => sw0,
			ones_digit1 => t_ones,
			tens_digit1 => t_tens,
			speed1      => speed11
	);

	lc: life 
		port map(
			clk        => s1, 
			rst        => t_reset,
			dir        => '0',
			col_detect => t_out,
			pixel_row  => s9,
			pixel_col  => s10,
			red        => sn1,
			green      => sn2,
			blue       => sn3,
			ending => t_ending
	);
		
end architecture;
