library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity expressao is 
    port (
        SW: in std_logic_vector(15 downto 0); -- 4 entradas de 4 bits
        LEDR: out std_logic_vector(12 downto 0) -- saida de 13 bits
    );
end expressao;

architecture bhvr of expressao is
    
    component compressor7_2 is
        generic(n : natural := 12);
        port(
            A, B, C, D, E, F, G: in std_logic_vector(n - 1 downto 0);
            valorA, valorB: out std_logic_vector(n + 1 downto 0)
        );
    end component;

    signal A, B, C, D: std_logic_vector(3 downto 0);
    signal v0, v1, v2, v3, v4, v5, v6: std_logic_vector(12 downto 0);
    signal resultado: std_logic_vector(14 downto 0);
    signal somaA, somaB: std_logic_vector(13 downto 0);

    begin

    A <= SW(3 downto 0);
    B <= SW(7 downto 4);
    C <= SW(11 downto 8);
    D <= SW(15 downto 12);

    v0 <= D(3) & D(2) & C(3) & C(2) & A(3) & A(1) & A(2) & A(3) & A(2) & A(1) & C(0) & C(1) & D(0);
    v1 <= "00" & D(1) & D(0) & B(3) & B(2) & B(3) & A(0) & B(0) & B(1) & D(1) & C(1) & D(0);
    v2 <= "0000" & C(3) & C(2) & B(1) & B(3) & C(2) & B(1) & D(1) & C(1) & D(0);
    v3 <= "0000" & C(1) & C(0) & C(1) & C(0) & D(2) & B(1) & C(3) & C(1) & D(0);
    V4 <= "0000" & D(3) & D(2) & D(1) & B(0) & B(2) & C(3) & C(3) & A(0) & D(0);
    V5 <= "000000" & D(0) & D(3) & B(2) & C(3) & (not B(0)) & A(0) & D(0);
    V6 <= "0000000" & (not D(0)) & B(2) & C(3) & "000";

    comp: compressor7_2 
        generic map(n => 12)
        port map(
            A => v0, B => V1, C => V2, D => V3, E => V4, F => V5, G => V6,
            valorA => somaA, valorB => somaB
        );

    resultado <= somaA + somaB;
    LEDR <= resultado(12 downto 0);

end architecture;