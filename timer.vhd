library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity timer is
	port(Clk, Start: in std_logic;
		Date_in: in std_logic_vector(9 downto 0);
		Time_out: out std_logic;
		minutes, seconds_ten, seconds_one: out std_logic_vector(6 downto 0));
end entity;

architecture structural of timer is
	component bcd_counter is
		port(Clk, Direction, Init, Enable: in std_logic;
			Q_Out: out std_logic_vector(3 downto 0));
	end component;

	component BCD_to_SevenSeg is
		port(BCD_digit: in std_logic_vector(3 downto 0);
			SevenSeg_out: out std_logic_vector(6 downto 0));
	end component;

	component clk_60_1 is
		port(Clk_in, Start_in: in std_logic;
			Clk_out: out std_logic);
	end component;

	component clk_10_1 is
		port(Clk_in, Start_in, Init_in: in std_logic;
			Clk_out: out std_logic);
	end component;

	component clk_1_1 is
		port(Clk_in, Start_in: in std_logic;
			Clk_out: out std_logic);
	end component;

	component init_ctrl is
		port (Clk_in, Start_in: in std_logic;
			Init_minute, Init_seconds_ten, Init_seconds_one, Init_out: out std_logic);
	end component;

	component enable_ctrl is
		port (Start_in, Finish_in: in std_logic;
			Enable_out: out std_logic);
	end component;

	component timer_finish is
		port (minute_in, seconds_ten_in, seconds_one_in: in std_logic_vector(3 downto 0);
			date_in: in std_logic_vector(9 downto 0);
			finish_out: out std_logic);
	end component;

	component multi_signal is
		port(s_in: in std_logic;
			s_out_1, s_out_2: out std_logic);
	end component;

	component multi_signal_vector is
		port(s_in: in std_logic_vector(3 downto 0);
			s_out_1, s_out_2: out std_logic_vector(3 downto 0));
	end component;
	
	component clk_50M_1 is
		port(Clk_in: in std_logic;
			Clk_out: out std_logic);
	end component;

	signal s1, s2, s3, s4, s5, s6, s16, s17, s18, s19, s50M: std_logic;
	signal s7, s8, s9, s10, s11, s12, s13, s14, s15: std_logic_vector(3 downto 0);
	signal s_Direction: std_logic := '0';
begin
	BCD1: bcd_counter
		port map(Clk => s1, Direction => s_Direction, Init => s4, Enable => s17, Q_Out => s7);

	BCD2: bcd_counter
		port map(Clk => s2, Direction => s_Direction, Init => s5, Enable => s17, Q_Out => s8);
	
	BCD3: bcd_counter
		port map(Clk => s3, Direction => s_Direction, Init => s6, Enable => s17, Q_Out => s9);

	C1: clk_60_1
		port map(Clk_in => s50M, Start_in => Start, Clk_out => s1);

	C2: clk_10_1
		port map(Clk_in => s50M, Start_in => Start, Init_in => s19, Clk_out => s2);

	C3: clk_1_1
		port map(Clk_in => s50M, Start_in => Start, Clk_out => s3);
	
	C4: clk_50M_1
		port map(Clk_in => Clk, Clk_out => s50M);

	S7_1: BCD_to_SevenSeg
		port map(BCD_digit => s10, SevenSeg_out => minutes);

	S7_2: BCD_to_SevenSeg
		port map(BCD_digit => s12, SevenSeg_out => seconds_ten);

	S7_3: BCD_to_SevenSeg
		port map(BCD_digit => s14, SevenSeg_out => seconds_one);

	T1: timer_finish
		port map(minute_in => s11, seconds_ten_in => s13, seconds_one_in => s15, date_in => Date_in, finish_out => s16);

	E1: init_ctrl
		port map(Clk_in => s50M, Start_in => Start, Init_minute => s4, Init_seconds_ten => s5, Init_seconds_one => s6, Init_out => s19);

	E2: enable_ctrl
		port map(start_in => Start, finish_in => s18, enable_out => s17);

	M1: multi_signal_vector
		port map(s_in => s7, s_out_1 => s10, s_out_2 => s11);

	M2: multi_signal_vector
		port map(s_in => s8, s_out_1 => s12, s_out_2 => s13);

	M3: multi_signal_vector
		port map(s_in => s9, s_out_1 => s14, s_out_2 => s15);

	M4: multi_signal
		port map(s_in => s16, s_out_1 => s18, s_out_2 => Time_out);
end architecture structural;