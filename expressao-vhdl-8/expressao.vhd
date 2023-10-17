library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity expressao is 
    port (
        SW: in std_logic_vector(15 downto 0); -- 4 entradas de 4 bits
        LEDR: out std_logic_vector(12 downto 0) -- saida de 13 bits
    );
end expressao;

architecture bhvr of expressao is
    
    component compressor7_2 is
        generic(n : natural := 13);
        port(
            A, B, C, D, E, F, G: in std_logic_vector(n - 1 downto 0); -- 13 bits
            valorA, valorB: out std_logic_vector(n + 2 downto 0) -- 15 bits
        );
    end component;

    signal A, B, C, D: std_logic_vector(3 downto 0);
    signal v0, v1, v2, v3, v4, v5, v6: std_logic_vector(12 downto 0);
    signal resultado: std_logic_vector(15 downto 0);
    signal somaA, somaB: std_logic_vector(15 downto 0);

    begin

    A <= SW(3 downto 0);
    B <= SW(7 downto 4);
    C <= SW(11 downto 8);
    D <= SW(15 downto 12);

    v0 <= D(2) & C(3) & C(2) & A(3) & A(1) & A(2) & A(3) & A(2) & A(1) & C(0) & C(1) & D(0); -- 13
    v1 <= '0' & D(3) & D(1) & D(0) & B(3) & B(2) & B(3) & A(0) & B(0) & B(1) & D(1) & C(1) & D(0); -- 13
    v2 <= "00" & D(3) & C(3) & C(2) & B(1) & B(3) & C(2) & B(1) & D(1) & C(1) & D(0);
    v3 <= "000" & C(1) & C(0) & C(1) & C(0) & D(2) & B(1) & C(3) & C(1) & D(0);
    V4 <= "000" & D(3) & D(2) & D(1) & B(0) & B(2) & C(3) & C(3) & A(0) & D(0);
    V5 <= "00000" & D(0) & D(3) & B(2) & C(3) & (not B(0)) & A(0) & D(0);
    V6 <= "000000" & (not D(0)) & B(2) & C(3) & "000";

    comp: compressor7_2 
        generic map(n => 12)
        port map(
            A => v0, B => V1, C => V2, D => V3, E => V4, F => V5, G => V6,
            valorA => somaA, valorB => somaB
        );

    resultado <= std_logic_vector(resize(signed(somaA) + signed(somaB), resultado'length));
    LEDR <= resultado(12 downto 0);

end architecture;
