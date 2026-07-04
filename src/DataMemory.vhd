library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DataMem is
    Port (
        clk        : in  std_logic;
        addr       : in  std_logic_vector(5 downto 0);  
        write_data : in  std_logic_vector(31 downto 0);
        MemRW      : in  std_logic;
        read_data  : out std_logic_vector(31 downto 0)
    );
end DataMem;

architecture Behavioral of DataMem is
    type mem_array is array (0 to 63) of std_logic_vector(7 downto 0); 
    signal mem_sig : mem_array := (others => (others => '0'));
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if MemRW = '1' then
                mem_sig(to_integer(unsigned(addr)))     <= write_data(7 downto 0);
                mem_sig(to_integer(unsigned(addr)) + 1) <= write_data(15 downto 8);
                mem_sig(to_integer(unsigned(addr)) + 2) <= write_data(23 downto 16);
                mem_sig(to_integer(unsigned(addr)) + 3) <= write_data(31 downto 24);
            end if;
        end if;
    end process;
    
    read_data <=     mem_sig(to_integer(unsigned(addr)) + 3) &
                     mem_sig(to_integer(unsigned(addr)) + 2) &
                     mem_sig(to_integer(unsigned(addr)) + 1) &
                     mem_sig(to_integer(unsigned(addr)));
end Behavioral;
