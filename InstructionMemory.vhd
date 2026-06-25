library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity InsMem is
    Port (
        add         : in  std_logic_vector(5 downto 0);  
        ins         : out std_logic_vector(31 downto 0)  
    );
end InsMem;

architecture Behavioral of InsMem is
    type mem_array is array (0 to 63) of std_logic_vector(7 downto 0);  
    signal mem_sig : mem_array := (
        0 => x"07", 1 => x"80", 2 => x"00", 3 => x"93",
        4 => x"0C", 5 => x"81", 6 => x"00", 7 => x"93",
        8 => x"02", 9 => x"11", 10 => x"61", 11 => x"33",
        12 => x"01", 13 => x"21", 14 => x"C1", 15 => x"33",
        16 => x"00", 17 => x"01", 18 => x"01", 19 => x"23",
        20 => x"00", 21 => x"02", 22 => x"80", 23 => x"03",
        24 => x"02", 25 => x"31", 26 => x"82", 27 => x"63",
        28 => x"04", 29 => x"30", 30 => x"03", 31 => x"6F", 
        others => (others => '0')
    );
begin
    ins         <= mem_sig(to_integer(unsigned(add)) + 3) &
                   mem_sig(to_integer(unsigned(add)) + 2) &
                   mem_sig(to_integer(unsigned(add)) + 1) &
                   mem_sig(to_integer(unsigned(add)));
end Behavioral;
