library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cs305_project is
	port (pb1, pb2, Clk                                            : in std_logic;
		red_out, green_out, blue_out, horiz_sync_out, vert_sync_out : out std_logic;
		mouse_data, mouse_clk                                       : inout std_logic;
		led0, led1                                                  : out std_logic;
		mouse_row, mouse_column                                     : out std_logic_vector(6 downto 0));
end entity;

architecture structural of cs305_project is
	component vga_sync is
		port (clock_25Mhz, red, green, blue		                        : in std_logic;
			red_out, green_out, blue_out, horiz_sync_out, vert_sync_out	: out std_logic;
			pixel_row, pixel_column                                     : out std_logic_vector(9 downto 0));
	end component;
	
	component bouncy_ball is
		port (pb1, pb2, clk, vert_sync : in std_logic;
			pixel_row, pixel_column	    : in std_logic_vector(9 downto 0);
			red, green, blue 			    : out std_logic);		
	end component;
	
	component mouse is
		port (clock_25Mhz, reset 	  : in std_logic;
         mouse_data					  : inout std_logic;
         mouse_clk 					  : inout std_logic;
         left_button, right_button : out std_logic;
		   mouse_cursor_row 			  : out std_logic_vector(9 downto 0); 
		   mouse_cursor_column 		  : out std_logic_vector(9 downto 0));       	
	end component;
	
	component multi_signal is
		port (s_in          : in std_logic;
			s_out_1, s_out_2 : out std_logic);
	end component;
	
	component seven_seg is
		port (digit     : in std_logic_vector(9 downto 0);
			SevenSeg_out : out std_logic_vector(6 downto 0));
	end component;

	component cs305_pll is
		port (refclk : in  std_logic := '0'; -- refclk.clk
			rst       : in  std_logic := '0'; -- reset.reset
			outclk_0  : out std_logic);       -- outclk0.clk
	end component;
	
	component inverter is
		port (Q_in: in std_logic;
			Q_out: out std_logic);
	end component;

	component start is
         port(pixel_row, pixel_col : in std_logic_vector(9 downto 0);
	       Clk, enable, mode_sel  : in std_logic;  -- if mode sel is '1', its game mode/ '0' is tutorial mode
         Red_out, Green_out, Blue_out : out std_logic);

        end component;  
 
	signal s1, s2, s3, s4, s5, s8, a1, a2,a3,a4,a5: std_logic;
	signal s6, s7, s9, s10: std_logic_vector(9 downto 0);
begin
        Starting: start 
                  port map (pixel_row => s6, pixel_col => s7, clk => s1, enable => a4, mode_sel => a5, red_out => red_out, green_out => green_out, blue_out => blue_out);

	V1: vga_sync
		port map(clock_25Mhz => s1, red => s2, green => s3, blue => s4, red_out => red_out, green_out => green_out, blue_out => blue_out, horiz_sync_out => horiz_sync_out, vert_sync_out => s5, pixel_row => s6, pixel_column => s7);
	
	B1: bouncy_ball
		port map(pb1 => pb1, pb2 => pb2, clk => s1, vert_sync => s8, pixel_row => s6, pixel_column => s7, red => s2, green => s3, blue => s4);
	
	C1: cs305_pll
		port map(refclk => Clk, rst => '0', outclk_0 => s1);
	
	M1: mouse
		port map(clock_25Mhz => s1, reset => '0', mouse_data => mouse_data, mouse_clk => mouse_clk, left_button => a1, right_button => a2, mouse_cursor_row => s9, mouse_cursor_column => s10);
		
	MS1: multi_signal
		port map(s_in => s5, s_out_1 => vert_sync_out, s_out_2 => s8);
	
	SD1: seven_seg
		port map(digit => s9, SevenSeg_out => mouse_row);
	
	SD2: seven_seg
		port map(digit => s10, SevenSeg_out => mouse_column);
	
	I1: inverter
		port map(Q_in => a1, Q_out => led0);
	
	I2: inverter
		port map(Q_in => a2, Q_out => led1);
end architecture;
