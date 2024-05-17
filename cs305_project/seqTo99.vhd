library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity seqTo99 is
   
 port(
        clk, reset, enable : in std_logic;
        counter_digit1: out std_logic_vector (7 downto 0)
    );
end seqTo99;

architecture behavior of seqTo99 is
    signal t_clk, t_direction, tens_enable: std_logic;
    signal ones_counter: std_logic_vector (3 downto 0);
    signal tens_counter: std_logic_vector (3 downto 0);

   component Binary_UpDownCounter is
     port(
        clk, direction, enable, init: in std_logic;
        counter: out std_logic_vector (3 downto 0)
     );
    end component;

begin
    Ones: Binary_UpDownCounter port map (clk, t_direction, enable, reset, ones_counter);
    tens: Binary_UpDownCounter port map (clk, t_direction, tens_enable, reset, tens_counter); 
    t_direction <= '1';
    counter_digit1 <= tens_counter & ones_counter;
    tens_enable <= '1' when (ones_counter = "0000" and enable = '1')  else '0';
    
end behavior;

          
