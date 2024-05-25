LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
USE IEEE.std_logic_signed.all;

entity endgame is
    port(pixel_row, pixel_col           : in std_logic_vector(9 downto 0);
        Clk, enable, mode               : in std_logic;
        tenth_digit, one_digit          : in std_logic_vector(3 downto 0);
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

    signal h_s : std_logic_vector(5 downto 0) := "001000";
    signal i_S : std_logic_vector(5 downto 0) := "001001";
    signal g_s: std_logic_vector(5 downto 0) := "000111";
    signal h1_s : std_logic_vector(5 downto 0) := "001000";
    signal s1_ad : std_logic_vector(5 downto 0) := "010011";
    signal c1_ad : std_logic_vector(5 downto 0) := "000011";
    signal o1_ad : std_logic_vector(5 downto 0) := "001111";
    signal r1_ad : std_logic_vector(5 downto 0) := "010010";
    signal e1_ad : std_logic_vector(5 downto 0) := "000101";

    signal h_s_R,h_s_G,h_s_B,i_s_R,i_s_G,i_s_B,g_s_R,g_s_G,g_s_B,h1_s_R,h1_s_G,h1_s_B,s1_s_R,s1_s_G,s1_s_B,c1_s_R,c1_s_G,c1_s_B,o1_s_R,o1_s_G,o1_s_B,r1_s_R,r1_s_G,r1_s_B,e1_s_R,e1_s_G,e1_s_B: std_logic;

    signal h_s_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(100, 10);
    signal h_s_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(8, 10);
    signal i_s_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(100, 10);
    signal i_s_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(40, 10);
    signal g_s_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(100, 10);
    signal g_s_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(72, 10);
    signal h1_s_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(100, 10);
    signal h1_s_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(104, 10);
    signal s11_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(100, 10);
    signal s11_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(136, 10);
    signal c11_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(100, 10);
    signal c11_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(168, 10);
    signal o11_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(100, 10);
    signal o11_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(200, 10);
    signal r11_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(100, 10);
    signal r11_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(232, 10);
    signal e21_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(100, 10);
    signal e21_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(264, 10);

    signal ht_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(100, 10);
    signal ht_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(296, 10);

    signal hf_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(100, 10);
    signal hf_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(328, 10);


    signal g_R, g_G, g_B, a_R, a_G, a_B, m_R, m_G, m_B, e_R, e_G, e_B,o_R, o_G, o_B,v_R, v_G, v_B,e1_R, e1_G, e1_B,r_R, r_G, r_B: std_logic;

    Signal Font_R : std_logic := '1';
    Signal Font_G : std_logic := '1';
    Signal Font_B : std_logic := '1';

    Signal Multiplier : integer := 4;


    signal s_tenth, s_first: std_logic_vector(5 downto 0);
    signal h_tenth, h_first:std_logic_vector(5 downto 0);


    signal s_ad : std_logic_vector(5 downto 0) := "010011";
    signal c_ad : std_logic_vector(5 downto 0) := "000011";
    signal o_ad : std_logic_vector(5 downto 0) := "001111";
    signal r_ad : std_logic_vector(5 downto 0) := "010010";
    signal e_ad : std_logic_vector(5 downto 0) := "000101";
    signal s1_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(68, 10);
    signal s1_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(8, 10);
    signal c1_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(68, 10);
    signal c1_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(40, 10);
    signal o1_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(68, 10);
    signal o1_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(72, 10);
    signal r1_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(68, 10);
    signal r1_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(104, 10);
    signal e2_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(68, 10);
    signal e2_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(136, 10);
    signal tenth_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(68, 10);
    signal tenth_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(168, 10);
    signal first_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(68, 10);
    signal first_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(200, 10);



    signal tenth_R, tenth_G, tenth_B, first_R, first_G, first_B, s_R1, s_G1, s_B1,c_R1, c_G1, c_B1, o_R1, o_G1, o_B1,r_R1, r_G1, r_B1,e_R1, e_G1, e_B1 : std_logic;

    signal ht_r,ht_g,ht_b,hf_r,hf_g,hf_b:std_logic;
    signal highscore : STD_LOGIC_VECTOR(7 downto 0);
    Signal Multiplier1 : integer := 3;
    Signal we1:std_logic;

    component Sprite_Printer is	
        port(pixel_row, pixel_col, a_row, a_col : in std_logic_vector(9 downto 0);
            s_red, s_green, s_blue              : in std_logic;
            multiplier                          : in integer range 1 to 4;
            address                             : in std_logic_vector (5 downto 0);
            enable, clk                         : in std_logic;
            red_out, green_out, blue_out        : out std_logic);
    end component Sprite_printer;

    component ram is
        port (clk, we : in STD_LOGIC;
            addr      : in STD_LOGIC_VECTOR(3 downto 0);
            din  : in STD_LOGIC_VECTOR(7 downto 0);
				dout : out STD_LOGIC_VECTOR(7 downto 0));
    end component ram;

    signal current_score : std_logic_vector(7 downto 0);

begin
	
	-- RAM instance for high score storage
    highscore_ram : ram port map (clk => Clk, we => we1,addr => "0000", din => current_score,dout => highscore);
	
	process(clk)
	begin
	    if (rising_edge(Clk)) then
		    current_score <= tenth_digit & one_digit;

            if (current_score > highscore and mode = '1') then
                h_tenth <= "11"&tenth_digit;
                h_first <= "11"&one_digit;
                we1 <= '1';
            else
                we1 <= '0';
                h_tenth <= "11"&highscore(7 downto 4);
                h_first <= "11"&highscore(3 downto 0);
            end if;
		 end if;
	end process;

    s_first <= "11"&one_digit;
    s_tenth <= "11" & tenth_digit;
    g: sprite_printer port map(pixel_row, pixel_col, g_row, g_col, Font_R, Font_G, Font_B, Multiplier, g_a, enable, CLK, g_R, g_G, g_B);
    a: sprite_printer port map(pixel_row, pixel_col, a_row, a_col, Font_R, Font_G, Font_B, Multiplier, a_a, enable, CLK, a_R, a_G, a_B);
    m: sprite_printer port map(pixel_row, pixel_col, m_row, m_col, Font_R, Font_G, Font_B, Multiplier, m_a, enable, CLK, m_R, m_G, m_B);
    e: sprite_printer port map(pixel_row, pixel_col, e_row, e_col, Font_R, Font_G, Font_B, Multiplier, e_a, enable, CLK, e_R, e_G, e_B);
    o: sprite_printer port map(pixel_row, pixel_col, o_row, o_col, Font_R, Font_G, Font_B, Multiplier, o_a, enable, CLK, o_R, o_G, o_B);
    v: sprite_printer port map(pixel_row, pixel_col, v_row, v_col, Font_R, Font_G, Font_B, Multiplier, v_a, enable, CLK, v_R, v_G, v_B);
    e1: sprite_printer port map(pixel_row, pixel_col, e1_row, e1_col, Font_R, Font_G, Font_B, Multiplier, e1_a, enable, CLK, e1_R, e1_G, e1_B);
    r: sprite_printer port map(pixel_row, pixel_col, r_row, r_col, Font_R, Font_G, Font_B, Multiplier, r_a, enable, CLK, r_R, r_G, r_B);
    S1: sprite_printer port map(pixel_row, pixel_col, s1_row, s1_col,Font_R, Font_G, Font_B,Multiplier1,s_ad,enable,CLK,s_R1, s_G1, s_B1);
    C1: sprite_printer port map(pixel_row, pixel_col, c1_row, c1_col,Font_R, Font_G, Font_B,Multiplier1,c_ad,enable,CLK,c_R1, c_G1, c_B1);
    O1: sprite_printer port map(pixel_row, pixel_col, o1_row, o1_col,Font_R, Font_G, Font_B,Multiplier1,o_ad,enable,CLK,o_R1, o_G1, o_B1);
    R1: sprite_printer port map(pixel_row, pixel_col, r1_row, r1_col,Font_R, Font_G, Font_B,Multiplier1,r_ad,enable,CLK,r_R1, r_G1, r_B1);
    E2: sprite_printer port map(pixel_row, pixel_col, e2_row, e2_col,Font_R, Font_G, Font_B,Multiplier1,e_ad,enable,CLK,e_R1, e_G1, e_B1);
    ten_text: sprite_printer port map(pixel_row, pixel_col,tenth_row,tenth_col,Font_R, Font_G, Font_B,Multiplier1,s_tenth,enable,CLK,tenth_R, tenth_G, tenth_B);
    one_text: sprite_printer port map(pixel_row, pixel_col,first_row,first_col,Font_R, Font_G, Font_B,Multiplier1,s_first,enable,CLK,first_R, first_G, first_B);

    hh: sprite_printer port map(pixel_row, pixel_col, h_s_row, h_s_col,Font_R, Font_G, Font_B,Multiplier1,h_s,enable,CLK,h_s_R,h_s_G,h_s_B);
			 
    ii: sprite_printer port map(pixel_row, pixel_col, i_s_row, i_s_col,Font_R, Font_G, Font_B,Multiplier1,i_s,enable,CLK,i_s_R,i_s_G,i_s_B);	 
			 
    gg: sprite_printer port map(pixel_row, pixel_col, g_s_row, g_s_col,Font_R, Font_G, Font_B,Multiplier1,g_s,enable,CLK,g_s_R,g_s_G,g_s_B);
			 
    hh1: sprite_printer port map(pixel_row, pixel_col, h1_s_row, h1_s_col,Font_R, Font_G, Font_B,Multiplier1,h1_s,enable,CLK,h1_s_R,h1_s_G,h1_s_B);
		
		
		
    S11: sprite_printer port map(pixel_row, pixel_col, s11_row, s11_col,Font_R, Font_G, Font_B,Multiplier1,s1_ad,enable,CLK,s1_s_R,s1_s_G,s1_s_B);
    C11: sprite_printer port map(pixel_row, pixel_col, c11_row, c11_col,Font_R, Font_G, Font_B,Multiplier1,c1_ad,enable,CLK,c1_s_R,c1_s_G,c1_s_B);
    O11: sprite_printer port map(pixel_row, pixel_col, o11_row, o11_col,Font_R, Font_G, Font_B,Multiplier1,o1_ad,enable,CLK,o1_s_R,o1_s_G,o1_s_B);
    R11: sprite_printer port map(pixel_row, pixel_col, r11_row, r11_col,Font_R, Font_G, Font_B,Multiplier1,r1_ad,enable,CLK,r1_s_R,r1_s_G,r1_s_B);
    E12: sprite_printer port map(pixel_row, pixel_col, e21_row, e21_col,Font_R, Font_G, Font_B,Multiplier1,e1_ad,enable,CLK,e1_s_R,e1_s_G,e1_s_B);
		

		
    ht_text :sprite_printer port map(pixel_row, pixel_col,ht_row,ht_col,Font_R, Font_G, Font_B,Multiplier1,h_tenth, enable,CLK,ht_r,ht_g,ht_b);
    hf_text :sprite_printer port map(pixel_row, pixel_col,hf_row,hf_col,Font_R, Font_G, Font_B,Multiplier1,h_first,enable,CLK,hf_r,hf_g,hf_b);
		
		
    Red_out2 <= g_R and a_R and m_R and e_R and o_R and v_R and e1_R and r_R and tenth_R and first_R and s_R1 and c_R1 and o_R1 and r_R1 and e_R1 and ht_r and hf_r and h_s_R and i_s_R and g_s_R and h1_s_R and s1_s_R and c1_s_R and o1_s_R and r1_s_R and e1_s_R; 
    Green_out2 <= g_G and a_G and m_G and e_G and o_G and v_G and e1_G and r_G and tenth_G and first_G and s_G1 and c_G1 and o_G1 and r_G1 and e_G1 and ht_g and hf_g and h_s_G and i_s_G and g_s_G and h1_s_G and s1_s_G and c1_s_G and o1_s_G and r1_s_G and e1_s_G;
    Blue_out2 <= g_B and a_B and m_B and e_B and o_B and v_B and e1_B and r_B and tenth_B and first_B and s_B1 and c_B1 and o_B1 and r_B1 and e_B1 and ht_b and hf_b and h_s_B and i_s_B and g_s_B and h1_s_B and s1_s_B and c1_s_B and o1_s_B and r1_s_B and e1_s_B;

end architecture;
