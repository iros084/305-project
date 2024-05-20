library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use IEEE.std_logic_arith.all;

entity cs305_project is
	port (Clk, pb3, sw4                                            : in std_logic;
		red_out, green_out, blue_out, horiz_sync_out, vert_sync_out : out std_logic;
		mouse_data, mouse_clk                                       : inout std_logic;
		mouse_row, mouse_column                                     : out std_logic_vector(6 downto 0));
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
		port (clk, vert_sync         : IN std_logic;
			left_button, right_button : IN std_logic;
			pixel_row, pixel_column	  : IN std_logic_vector(9 downto 0);
			red, green, blue 			  : out std_logic);
	end component;
	
	component MOUSE is
		port (clock_25Mhz, reset 	  : IN std_logic;
         mouse_data					  : INOUT std_logic;
         mouse_clk 					  : INOUT std_logic;
         left_button, right_button : OUT std_logic;
			mouse_cursor_row 			  : OUT std_logic_vector(9 DOWNTO 0); 
			mouse_cursor_column 		  : OUT std_logic_vector(9 DOWNTO 0));       	
	end component;
	
	component start is
		port (pixel_row, pixel_col         : in std_logic_vector(9 downto 0);
			Clk, enable, mode_sel           : in std_logic;  -- if mode sel is '1', its game mode/ '0' is tutorial mode
         Red_out1, Green_out1, Blue_out1 : out std_logic);
   end component;
	
	component rgb_mux is
		port (in1, in2, in3, in4, in5, in6, in7, in8, in9, mux : in std_logic;
			r_out, g_out, b_out                                 : out std_logic);
	end component;
	
	component rand_gen is 
      port (clk, rand_st : in std_logic;
			psudo           : out std_logic_vector(8 downto 0));
   end component;
	
	component pipes is
		port (clk, horiz_sync, vert_sync, enable, reset          : in std_logic;
			pixel_row, pixel_column, pipe_height                  : in std_logic_vector(9 downto 0);
         speed                                                 : in std_logic_vector(8 downto 0);
         init                                                  : in std_logic_vector(10 downto 0);
         Red, Green, Blue, pipe_s, coin_s, count, initial, rst : out std_logic);
	end component;
	
	
	signal s1, s2, s3, s4, s5, s6, s7, s8, s11, s14, s15, s16, s17, s18, s19, s20, s25, s26, s27, s28, s29, s30, s31, s32: std_logic;
	signal s9, s10, s12, s13 : std_logic_vector(9 downto 0);
	signal s22               : std_logic_vector(8 downto 0);
	signal s24               : std_logic_vector(10 downto 0);
	signal t_h               : std_logic_vector(9 DOWNTO 0);
	signal t_p               : std_logic_vector(8 downto 0);
	signal t_horz, t_vert    : std_logic;
	--s20 <= '1';
	
begin

   horiz_sync_out <= t_horz;
	vert_sync_out <= s8;
   t_h <= '0' & t_p;
	
	C1: cs305_pll
		port map(
			refclk   => Clk,
			rst      => '0',
			outclk_0 => s1
	);
		
	V1: vga_sync
		port map(
			clock_25Mhz    => s1,
			red            => s5,
			green          => s6,
			blue           => s7,
			red_out        => red_out,
			green_out      => green_out,
			blue_out       => blue_out,
			horiz_sync_out => t_horz, -- Added association label for t_horz
			vert_sync_out  => s8,
			pixel_row      => s9,
			pixel_column   => s10
    );
	
	B1: bouncy_ball
		port map(
			clk          => s1,
			vert_sync    => s8,--s11,
			left_button  => s14,
			right_button => s15,
			pixel_row    => s9,
			pixel_column => s10,
			red          => s2,
			green        => s3,
			blue         => s4
	);
	
	M1: MOUSE
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
			clk => s1,
			rand_st => pb3,
			psudo => t_p
	);
	
	d1: pipes
		port map(
			clk          => s1,
			horiz_sync   => t_horz,
			vert_sync    => s8,
			enable       => '1',
			reset        => '0',
			pixel_row    => s9,
			pixel_column => s10,
			pipe_height  => t_h,
			speed        => CONV_STD_LOGIC_VECTOR(100, 9),
			init         => s24,
			Red          => s25,
			Green        => s26,
			Blue         => s27,
			pipe_s       => s28,
			coin_s       => s29,
			count        => s30,
			initial      => s31,
			rst          => s32
	);
	
	R1: rgb_mux
		port map(
			in1   => s2,
			in2   => s3,
			in3   => s4,
			in4   => s16,
			in5   => s17,
			in6   => s18,
			in7   => s25,
			in8   => s26,
			in9   => s27,
			mux   => sw4,
			r_out => s5,
			g_out => s6,
			b_out => s7
	);
		
end architecture;
