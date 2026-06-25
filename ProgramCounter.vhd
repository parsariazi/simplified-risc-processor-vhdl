library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PC is
    Port (
        clk     : in  std_logic;
        res   : in  std_logic;
        pcoutput  : out std_logic_vector(5 downto 0)
    );
end PC;

architecture Behavioral of PC is
    signal pc_sig : unsigned(5 downto 0) := (others => '0');
begin
    process(clk, res)
    begin
        if res = '1' then
            pc_sig <= (others => '0');
        elsif rising_edge(clk) then
            pc_sig <= pc_sig + 4;  
        end if;
    end process;

    pcoutput <= std_logic_vector(pc_sig);
end Behavioral;
