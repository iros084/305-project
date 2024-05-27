library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;

entity pausegame is
	port(pixel_row, pixel_col          : in std_logic_vector(9 downto 0);
		Clk, enable, mode               : in std_logic;
		Red_out2, Green_out2, Blue_out2 : out std_logic);
end entity;

architecture behaviour of pausegame is

	signal p_a : std_logic_vector(5 downto 0) := "010000";
	signal a_a : std_logic_vector(5 downto 0) := "000001";
	signal u_a : std_logic_vector(5 downto 0) := "010101";
	signal s_a : std_logic_vector(5 downto 0) := "010011";
	signal e_a : std_logic_vector(5 downto 0) := "000101";
	
	signal p_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(200, 10);
	signal p_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(128, 10);
	signal a_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(200, 10);
	signal a_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(224, 10);
	signal u_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(200, 10);
	signal u_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(319, 10);
	signal s_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(200, 10);
	signal s_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(416, 10);
	signal e_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(200, 10);
	signal e_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(511, 10);


	signal p_R, p_G, p_B : std_logic;
	signal a_R, a_G, a_B : std_logic;
	signal u_R, u_G, u_B : std_logic;
	signal s_R, s_G, s_B : std_logic;
	signal e_R, e_G, e_B : std_logic;

	Signal Font_R : std_logic := '1';
	Signal Font_G : std_logic := '1';
	Signal Font_B : std_logic := '1';

	Signal Multiplier : integer := 4;

	component Sprite_Printer is	
		port(pixel_row, pixel_col, a_row, a_col : in std_logic_vector(9 downto 0);
			s_red, s_green, s_blue               : in std_logic;
			multiplier                           : in integer range 1 to 4;
			address                              : in std_logic_vector (5 downto 0);
			enable, clk                          : in std_logic;
			red_out, green_out, blue_out         : out std_logic);
	end component Sprite_printer;

begin

	p: sprite_printer port map(pixel_row, pixel_col, p_row, p_col, Font_R, Font_G, Font_B, Multiplier, p_a, enable, CLK, p_R, p_G, p_B);
	a: sprite_printer port map(pixel_row, pixel_col, a_row, a_col, Font_R, Font_G, Font_B, Multiplier, a_a, enable, CLK, a_R, a_G, a_B);
	u: sprite_printer port map(pixel_row, pixel_col, u_row, u_col, Font_R, Font_G, Font_B, Multiplier, u_a, enable, CLK, u_R, u_G, u_B);
	s: sprite_printer port map(pixel_row, pixel_col, s_row, s_col, Font_R, Font_G, Font_B, Multiplier, s_a, enable, CLK, s_R, s_G, s_B);
	e: sprite_printer port map(pixel_row, pixel_col, e_row, e_col, Font_R, Font_G, Font_B, Multiplier, e_a, enable, CLK, e_R, e_G, e_B);

	Red_out2 <= p_R and a_R and u_R and s_R and e_R; 
	Green_out2 <= p_G and a_G and u_G and s_G and e_G;
	Blue_out2 <= p_B and a_B and u_B and s_B and e_B;

end architecture;
