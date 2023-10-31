library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity registrador is
    port (
        clk, reset, enable : in std_logic;
        data_in : in std_logic_vector(15 downto 0);
        data_out : out std_logic_vector(15 downto 0)
    );
end entity registrador;

architecture Behavioral of registrador is
    signal reg : std_logic_vector(15 downto 0);
begin
    process (clk, reset)
    begin
        if reset = '1' then
            reg <= (others => '0');
        elsif rising_edge(clk) then
            if enable = '1' then
                reg <= data_in;
            end if;
        end if;
    end process;

    data_out <= reg;
end architecture Behavioral;
