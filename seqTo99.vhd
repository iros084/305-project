library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity seqTo99 is
   
 port(
        clk, Init, enable : in std_logic;
        out_tens, out_ones: out std_logic_vector(3 downto 0);
        counter_digit1,counter_digit2: out std_logic_vector (6 downto 0)
    );
end seqTo99;

architecture behavior of seqTo99 is
    signal t_direction : std_logic := '1';
    signal tens_e,ones_e: std_logic := '0';
    signal t_tens,t_ones,t_start,t_latch: std_logic := '0';
    signal ones_counter: std_logic_vector (3 downto 0) := "0000";
    signal tens_counter: std_logic_vector (3 downto 0) := "0000";

   component Binary_UpDownCounter is
     port(
        clk, direction, enable, init: in std_logic;
        counter: out std_logic_vector (3 downto 0)
     );
    end component;

begin
Ones: Binary_UpDownCounter port map (
    clk => clk,
    direction => '0',
    enable => enable,
    init => Init,
    counter => ones_counter
);

tens: Binary_UpDownCounter port map (
    clk => clk,
    direction => '0',
    enable => enable,
    init => Init,
    counter => tens_counter
);

process (clk)
begin
    if (rising_edge(clk)) then
        if (enable = '1') then
            t_ones <= '1';
            if (ones_counter = "1001") then
                t_start <= '1';
            end if;
            if (t_start = '1' and t_latch = '0') then
                if (ones_counter = "1001") then
                    t_tens <= '1';
                    t_latch <= '1';
                end if;
                if (ones_counter = "0001") then
                    t_latch <= '1';
                    t_start <= '0';
                end if;
            end if;
        else
            t_tens <= '0';
            t_ones <= '0';
        end if;
    end if;
end process;
         tens_e<= t_tens;
         ones_e<=t_ones;
         out_tens<=tens_counter;
         out_ones<=ones_counter;
    
end behavior;

          
