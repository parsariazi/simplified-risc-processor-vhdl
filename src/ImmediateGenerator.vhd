library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ImmediateGenerator is
    Port (
        immediate_in    : in  std_logic_vector(11 downto 0); 
        immediate_out    : out std_logic_vector(31 downto 0)   
    );
end ImmediateGenerator;

architecture Behavioral of ImmediateGenerator is
begin
    process(immediate_in)
    begin
        if immediate_in(11) = '1' then
            immediate_out <= (19 downto 0 => '1') & immediate_in;
        else
            immediate_out <= (19 downto 0 => '0') & immediate_in;
        end if;
    end process;
end Behavioral;
