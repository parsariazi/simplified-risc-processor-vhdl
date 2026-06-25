library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Regfile is
    Port (
        clk      : in  std_logic;
        RegWEn   : in  std_logic;
        AddresA  : in  std_logic_vector(4 downto 0);
        AddresB   : in  std_logic_vector(4 downto 0);
        AddresD  : in  std_logic_vector(4 downto 0);
        DataD   : in  std_logic_vector(31 downto 0);
        DataA   : out std_logic_vector(31 downto 0);
        DataB   : out std_logic_vector(31 downto 0)
    );
end Regfile;

architecture Behavioral of Regfile is
    type reg_array is array (0 to 31) of std_logic_vector(31 downto 0);
    signal registers : reg_array := (others => (others => '0'));
begin
    DataA <= registers(to_integer(unsigned(AddresA)));
    DataB <= registers(to_integer(unsigned(AddresB)));

    process(clk)
    begin
        if rising_edge(clk) then
            if RegWEn = '1' then
                registers(to_integer(unsigned(AddresD))) <= DataD;
            end if;
        end if;
    end process;
end Behavioral;
