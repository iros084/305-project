LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;

entity endgame is
    port(pixel_row, pixel_col : in std_logic_vector(9 downto 0);
	       Clk, enable  : in std_logic;
         Red_out2, Green_out2, Blue_out2 : out std_logic);

end entity endgame;

architecture behaviour of endgame is

signal g_a : std_logic_vector(5 downto 0) := "000111";
signal a_a: std_logic_vector(5 downto 0) := "000001";
signal m_a: std_logic_vector(5 downto 0) := "001101";
signal e_a : std_logic_vector(5 downto 0) := "000101";
signal o_a : std_logic_vector(5 downto 0) := "001111";
signal v_a : std_logic_vector(5 downto 0) := "010110";
signal e1_a : std_logic_vector(5 downto 0) := "000101";
signal r_a : std_logic_vector(5 downto 0) := "010010";


signal g_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(200, 10);
signal g_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(144, 10);
signal a_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(200, 10);
signal a_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(240, 10);
signal m_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(200, 10);
signal m_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(335, 10);
signal e_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(200, 10);
signal e_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(432, 10);
signal o_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(264, 10);
signal o_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(144, 10);
signal v_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(264, 10);
signal v_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(240, 10);
signal e1_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(264, 10);
signal e1_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(335, 10);
signal r_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(264, 10);
signal r_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(432, 10);


signal g_R, g_G, g_B, a_R, a_G, a_B, m_R, m_G, m_B, e_R, e_G, e_B,o_R, o_G, o_B,v_R, v_G, v_B,e1_R, e1_G, e1_B,r_R, r_G, r_B: std_logic;

Signal Font_R : std_logic := '1';
Signal Font_G : std_logic := '1';
Signal Font_B : std_logic := '1';

Signal Multiplier : integer := 4;

component Sprite_Printer is	
  port(pixel_row, pixel_col, a_row, a_col : in std_logic_vector(9 downto 0);
       s_red, s_green, s_blue : in std_logic;
       multiplier : in integer range 1 to 4;
       address : in std_logic_vector (5 downto 0);
       enable, clk : in std_logic;
       red_out, green_out, blue_out : out std_logic);
end component Sprite_printer;

	begin
	  g: sprite_printer port map(pixel_row, pixel_col, g_row, g_col, Font_R, Font_G, Font_B, Multiplier, g_a, enable, CLK, g_R, g_G, g_B);
	  a: sprite_printer port map(pixel_row, pixel_col, a_row, a_col, Font_R, Font_G, Font_B, Multiplier, a_a, enable, CLK, a_R, a_G, a_B);
	  m: sprite_printer port map(pixel_row, pixel_col, m_row, m_col, Font_R, Font_G, Font_B, Multiplier, m_a, enable, CLK, m_R, m_G, m_B);
	  e: sprite_printer port map(pixel_row, pixel_col, e_row, e_col, Font_R, Font_G, Font_B, Multiplier, e_a, enable, CLK, e_R, e_G, e_B);
 	  o: sprite_printer port map(pixel_row, pixel_col, o_row, o_col, Font_R, Font_G, Font_B, Multiplier, o_a, enable, CLK, o_R, o_G, o_B);
	  v: sprite_printer port map(pixel_row, pixel_col, v_row, v_col, Font_R, Font_G, Font_B, Multiplier, v_a, enable, CLK, v_R, v_G, v_B);
	  e1: sprite_printer port map(pixel_row, pixel_col, e1_row, e1_col, Font_R, Font_G, Font_B, Multiplier, e1_a, enable, CLK, e1_R, e1_G, e1_B);
	  r: sprite_printer port map(pixel_row, pixel_col, r_row, r_col, Font_R, Font_G, Font_B, Multiplier, r_a, enable, CLK, r_R, r_G, r_B);
		
		Red_out2 <= g_R and a_R and m_R and e_R and o_R and v_R and e1_R and r_R; 
		Green_out2 <= g_G and a_G and m_G and e_G and o_G and v_G and e1_G and r_G;
		Blue_out2 <= g_B and a_B and m_B and e_B and o_B and v_B and e1_B and r_B;
end architecture;