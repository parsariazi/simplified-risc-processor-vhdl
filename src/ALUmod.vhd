library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    Port (
        A        : in  std_logic_vector(31 downto 0);
        B        : in  std_logic_vector(31 downto 0);
        Sel      : in  std_logic_vector(1 downto 0);
        Result   : out std_logic_vector(31 downto 0)
    );
end ALU;

architecture Behavioral of ALU is
begin
    process(A, B, Sel)
    begin
        case Sel is
            when "00" =>  
                Result <= std_logic_vector(signed(A) + signed(B));
            when "01" =>  
                Result <= std_logic_vector(signed(A) - signed(B));
            when "10" =>  
                Result <= A and B;
            when "11" =>  
                Result <= A or B;
            when others =>
                Result <= (others => '0');
        end case;
    end process;
end Behavioral;
