library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

-- Counter Entity Declaration
entity counter is
    port(
        clk      : in std_logic;
        reset    : in std_logic;
        count_en : in std_logic;
        count_ones : out std_logic_vector(3 downto 0);
        count_tens : out std_logic_vector(3 downto 0)
    );
end entity;

architecture Behavioral of counter is
    signal ones : std_logic_vector(3 downto 0) := (others => '0');
    signal tens : std_logic_vector(3 downto 0) := (others => '0');
begin
    process(clk, reset)
    begin
        if reset = '1' then
            ones <= (others => '0');
            tens <= (others => '0');
        elsif rising_edge(clk) then
            if count_en = '1' then
                if ones = "1001" then
                    ones <= "0000";
                    if tens = "1001" then
                        tens <= "0000";
                    else
                        tens <= tens + 1;
                    end if;
                else
                    ones <= ones + 1;
                end if;
            end if;
        end if;
    end process;

    count_ones <= ones;
    count_tens <= tens;
end architecture;

-- Pipes Entity Declaration
entity pipes is
    port(
        clk, horiz_sync, vert_sync, enable, reset           : in std_logic;
        pixel_row, pixel_column, pipe_height                : in std_logic_vector(9 downto 0);
        speed                                               : in std_logic_vector(8 downto 0);
        init                                                : in std_logic_vector(10 downto 0);
        Red, Green, Blue, pipe_s, coin_s, count, initial, rst : out std_logic;
        pipe_on_out                                         : out std_logic;
        counter_ones, counter_tens                          : out std_logic_vector(3 downto 0)
    );
end entity;

architecture b1 of pipes is

    signal width1                                            : std_logic_vector(9 downto 0);
    signal pipeA_on, pipeB_on, power, pipe_on, c_R, c_G, c_B : std_logic;
    signal pipe_x                                            : std_logic_vector(10 downto 0);
    signal pipe_h, c_row, c_column                           : std_logic_vector(9 downto 0);
    signal timer1                                            : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(0,10); 
    signal t_power                                           : std_logic_vector(8 downto 0);  
    signal Font_R                                            : std_logic := '1'; 
    signal Font_G                                            : std_logic := '1';
    signal Font_B                                            : std_logic := '1';
    signal Multiplier                                        : integer := 3;
    signal c_address                                         : std_logic_vector(5 downto 0) := "001111";
    signal count_en                                          : std_logic;  -- Enable signal for the counter

    type position is record
        y_pos

