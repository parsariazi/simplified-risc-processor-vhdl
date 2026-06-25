library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TopMod is
    Port (
        clk          : in  std_logic;
        reset        : in  std_logic;
        pcoutput     : out std_logic_vector(5 downto 0);
        instruction  : out std_logic_vector(31 downto 0)
    );
end TopMod;

architecture Behavioral of TopMod is

    signal pc            : std_logic_vector(5 downto 0);
    signal instr         : std_logic_vector(31 downto 0);
    signal opcode        : std_logic_vector(6 downto 0);
    signal funct3        : std_logic_vector(2 downto 0);
    signal funct7        : std_logic_vector(6 downto 0);
    signal rs1, rs2, rd  : std_logic_vector(4 downto 0);
    signal imm12         : std_logic_vector(11 downto 0);

    signal Adata, Bdata   : std_logic_vector(31 downto 0);
    signal ALU_in2        : std_logic_vector(31 downto 0);
    signal ALU_result     : std_logic_vector(31 downto 0);
    signal imm32          : std_logic_vector(31 downto 0);
    signal memout         : std_logic_vector(31 downto 0);
    signal write_back_data: std_logic_vector(31 downto 0);

    signal ALUSel    : std_logic_vector(1 downto 0);
    signal BSel      : std_logic;
    signal RegWEn    : std_logic;
    signal MemRW     : std_logic;
    signal MemToReg  : std_logic;

begin
    PC_Unit: entity work.PC
        port map (
            clk     => clk,
            res   => reset,
            pcoutput  => pc
        );

    InstrMem: entity work.InsMem
        port map (
            add        => pc,
            ins => instr
        );

    opcode   <= instr(6 downto 0);
    rd       <= instr(11 downto 7);
    funct3   <= instr(14 downto 12);
    rs1      <= instr(19 downto 15);
    rs2      <= instr(24 downto 20);
    funct7   <= instr(31 downto 25);
    imm12    <= instr(31 downto 20);

    ImmGen: entity work.ImmediateGenerator
        port map (
            immediate_in  => imm12,
            immediate_out => imm32
        );

    RegFile: entity work.Regfile
        port map (
            clk     => clk,
            RegWEn  => RegWEn,
            AddresA  => rs1,
            AddresB  => rs2,
            AddresD  => rd,
            DataD  => write_back_data,
            DataA  => Adata,
            DataB  => Bdata
        );

    ALU_in2 <= imm32 when BSel = '1' else Bdata;

    ALU_Core: entity work.ALU
        port map (
            A        => Adata,
            B        => ALU_in2,
            Sel      => ALUSel,
            Result   => ALU_result
        );

    DataMem: entity work.DataMem
        port map (
            clk        => clk,
            addr       => ALU_result(5 downto 0),
            write_data => Bdata,
            MemRW      => MemRW,
            read_data  => memout
        );

    write_back_data <= memout when MemToReg = '1' else ALU_result;

    Control: entity work.Control
        port map (
            opcode    => opcode,
            funct3    => funct3,
            funct7    => funct7,
            ALUSel    => ALUSel,
            BSel      => BSel,
            RegWEn    => RegWEn,
            MemRW     => MemRW,
            MemToReg  => MemToReg
        );

    pcoutput      <= pc;
    instruction <= instr;

end Behavioral;
