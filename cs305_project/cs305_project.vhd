library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cs305_project is
	port (Clk, pb1, pb2, sw1, sw2, sw3                             : in std_logic;
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
		port (clk, vert_sync                   : IN std_logic;
			pb1, pb2, left_button, right_button : IN std_logic;
			sw1, sw2, sw3                       : IN std_logic;
			pixel_row, pixel_column	            : IN std_logic_vector(9 downto 0);
			red, green, blue 			            : OUT std_logic);
	end component;
	
	component multi_signal is
		port (s_in          : in std_logic;
			s_out_1, s_out_2 : out std_logic);
	end component;
	
	component MOUSE is
		port (clock_25Mhz, reset 	  : IN std_logic;
         mouse_data					  : INOUT std_logic;
         mouse_clk 					  : INOUT std_logic;
         left_button, right_button : OUT std_logic;
			mouse_cursor_row 			  : OUT std_logic_vector(9 DOWNTO 0); 
			mouse_cursor_column 		  : OUT std_logic_vector(9 DOWNTO 0));       	
	end component;
	
	component seven_seg is
		port (digit: in std_logic_vector(3 downto 0);
			SevenSeg_out: out std_logic_vector(6 downto 0));
	end component;

	signal s1, s2, s3, s4, s5, s8, s11, s12: std_logic;
	signal s6, s7, s9, s10: std_logic_vector(9 downto 0);
	
begin
	V1: vga_sync
		port map(clock_25Mhz => s1, red => s2, green => s3, blue => s4, red_out => red_out, green_out => green_out, blue_out => blue_out, horiz_sync_out => horiz_sync_out, vert_sync_out => s5, pixel_row => s6, pixel_column => s7);
	
	B1: bouncy_ball
		port map(clk => s1, vert_sync => s8, pb1 => pb1, pb2 => pb2, left_button => s11, right_button => s12, sw1 => sw1, sw2 => sw2, sw3 => sw3, pixel_row => s6, pixel_column => s7, red => s2, green => s3, blue => s4);
	
	C1: cs305_pll
		port map(refclk => Clk, rst => '0', outclk_0 => s1);
	
	MS1: multi_signal
		port map(s_in => s5, s_out_1 => vert_sync_out, s_out_2 => s8);
	
	M1: MOUSE
		port map(clock_25Mhz => s1, reset => '0', mouse_data => mouse_data, mouse_clk => mouse_clk, left_button => s11, right_button => s12, mouse_cursor_row => s9, mouse_cursor_column => s10);
	
	A1: seven_seg
		port map(digit => s9(9 downto 6), SevenSeg_out => mouse_row);
		
	A2: seven_seg
		port map(digit => s10(9 downto 6), SevenSeg_out => mouse_column);
		
end architecture;
