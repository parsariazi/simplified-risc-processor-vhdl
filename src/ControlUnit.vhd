library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control is
    Port (
        opcode     : in  std_logic_vector(6 downto 0);
        funct3     : in  std_logic_vector(2 downto 0);
        funct7     : in  std_logic_vector(6 downto 0);
        ALUSel     : out std_logic_vector(1 downto 0);
        BSel       : out std_logic;
        RegWEn     : out std_logic;
        MemRW      : out std_logic;
        MemToReg   : out std_logic
    );
end Control;

architecture Behavioral of Control is
begin
    process(opcode, funct3, funct7)
    begin
        ALUSel    <= "00";
        BSel      <= '0';
        RegWEn    <= '0';
        MemRW     <= '0';
        MemToReg  <= '0';

        case opcode is
            when "0110011" => 
                BSel     <= '0';
                RegWEn   <= '1';
                MemToReg <= '0';
                case funct3 is
                    when "000" => 
                        if funct7 = "0000000" then
                            ALUSel <= "00"; 
                        elsif funct7 = "0100000" then
                            ALUSel <= "01"; 
                        end if;
                    when "111" => ALUSel <= "10"; 
                    when "110" => ALUSel <= "11"; 
                    when others => null;
                end case;

            when "0010011" =>  
                BSel     <= '1';
                RegWEn   <= '1';
                MemToReg <= '0';
                case funct3 is
                    when "000" => ALUSel <= "00"; 
                    when "111" => ALUSel <= "10"; 
                    when "110" => ALUSel <= "11";
                    when others => null;
                end case;

            when "0000011" => 
                BSel     <= '1';
                RegWEn   <= '1';
                MemToReg <= '1';
                ALUSel   <= "00"; 

            when "0100011" =>  
                BSel     <= '1';
                RegWEn   <= '0';
                MemRW    <= '1';
                ALUSel   <= "00"; 

            when others =>
                null;
        end case;
    end process;
end Behavioral;
