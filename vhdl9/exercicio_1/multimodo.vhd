library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity multimodo is
    port(
        SW : in std_logic_vector(17 downto 0);
        KEY : in std_logic_vector(1 downto 0);
        LEDR : out std_logic_vector(15 downto 0);
        clock_50 : in std_logic
    );
end entity;

architecture bhvr of multimodo is

component mux4_1 is
    generic(n :positive:=16);
    port ( A, B, C, D : in STD_LOGIC_VECTOR (n-1 downto 0); -- 16 bits
           sel : in std_logic_vector(1 downto 0);
           S : out STD_LOGIC_VECTOR (n-1 downto 0)); -- 16 bits
end component;

component registrador is
    port (
        clk, reset, enable : in std_logic; -- 1 bit
        data_in : in std_logic_vector(15 downto 0); -- 16 bits
        data_out : out std_logic_vector(15 downto 0) -- 16 bits
    );
end component;

signal iXq, qXq : integer; -- 16 bits
signal input_reg, output_reg : std_logic_vector(15 downto 0); -- 16 bits
signal clk, rst : std_logic; -- 1 bit

begin

    clk <= not KEY(1);
    rst <= not KEY(0);

    iXq <= to_integer(unsigned(SW(15 downto 0))) * to_integer(output_reg);
    qXq <= to_integer(output_reg) * to_integer(output_reg);

    mux: mux4_1
    port map(
        A => std_logic_vector(iXq(15 downto 0)),
        B => SW(15 downto 0),
        C => output_reg,
        D => std_logic_vector(qXq(15 downto 0)),
        sel => SW(17 downto 16),
        S => input_reg
    );

    reg: registrador
    port map(
        clk => clock_50,
        reset => rst,
        enable => clk,
        data_in => input_reg,
        data_out => output_reg
    );

    LEDR <= output_reg;

end architecture;

-- constante : 6 (15)