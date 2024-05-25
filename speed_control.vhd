library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity speed_control is
    Port (
        clk : in std_logic;
        rst : in std_logic;
        ones_digit1 : in std_logic_vector(3 downto 0);
        tens_digit1 : in std_logic_vector(3 downto 0);
        speed1 : out std_logic_vector(8 downto 0)
    );
end speed_control;

architecture Behavioral of speed_control is
begin
    process(clk, rst)
    begin
        if rst = '1' then
            speed1 <= CONV_STD_LOGIC_VECTOR(100, 9); -- Default speed
        elsif rising_edge(clk) then
            if tens_digit1 >= "0001" then
                speed1 <= CONV_STD_LOGIC_VECTOR(75, 9); 
			   elsif(tens_digit1 >= "0010") then
				    speed1 <= CONV_STD_LOGIC_VECTOR(50, 9); 
            else
                speed1 <= CONV_STD_LOGIC_VECTOR(100, 9); -- Default speed
            end if;
        end if;
    end process;
end Behavioral;
