---------------------------------------------------------------------------------------------------
--
-- Title       : Binary a RNS moduli set {256, 15, 17}
-- Author      : Prof. Héctor Pettenghi
-- Company     : UFSC EEL
--
---------------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity traditionalSystem_RNStoBin is
	generic (n : natural := 4);
	port(R1: in std_LOGIC_VECTOR(7 downto 0);
		  R2: in std_LOGIC_VECTOR(11 downto 8);
		  R3: in std_LOGIC_VECTOR(16 downto 12);
		  output : out STD_LOGIC_VECTOR(15 downto 0));
end traditionalSystem_RNStoBin;
  
architecture Structural of traditionalSystem_RNStoBin is
 
  component CSA_EAC is
     generic (n : natural := 8);
  	 port( I0 : in STD_LOGIC_VECTOR((n-1) downto 0);
           I1 : in STD_LOGIC_VECTOR((n-1) downto 0);
           I2 : in STD_LOGIC_VECTOR((n-1) downto 0);
           S : out STD_LOGIC_VECTOR((n-1) downto 0);
           C : out STD_LOGIC_VECTOR((n-1) downto 0));
  end component;
  
  component CPA_mod255 is 
  	generic (n : natural := 8);
    port( s1 : in STD_LOGIC_VECTOR (n-1 downto 0);
          c1 : in STD_LOGIC_VECTOR (n-1 downto 0);
          f : out STD_LOGIC_VECTOR(n-1 downto 0));
  end component;

signal zeros : std_logic_vector(n-2 downto 0); -- 3 bits
signal A, B, Cn, D: std_logic_vector(2*n-1 downto 0); -- 8 bits
signal sum0_2n_m1 , carry0_2n_m1 : std_logic_vector(2*n-1 downto 0);
signal sum1_2n_m1 , carry1_2n_m1 : std_logic_vector(2*n-1 downto 0);
signal saida : std_logic_vector(2*n-1 downto 0); -- 8 bits
signal ones : std_logic_vector(2*n-1 downto 0); -- 8 bits
signal iR1: std_LOGIC_VECTOR(7 downto 0);
signal iR2: std_LOGIC_VECTOR(3 downto 0);
signal iR3: std_LOGIC_VECTOR(4 downto 0);
  
begin
  
  ones <= (others => '1');
  zeros <= (others => '0');
  
  iR1 <= R1;
  iR2 <= R2;
  iR3 <= R3;
  	 
  A(2*n-1 downto 0) <= not(R1);
  B(2*n-1 downto 0) <= (iR2(0) & iR2(3 downto 0) & iR2(3 downto 1));
  Cn(2*n-1 downto 0) <= (iR3(0) & zeros & iR3(4 downto 1));
  D(2*n-1 downto 0) <= not(iR3 & zeros);
  
  comp0_2n_m1: CSA_EAC generic map	(n => 2*n)
  	port map (I0 => A, I1 => B, I2 => Cn, S => sum0_2n_m1, C => carry0_2n_m1);
  
  comp1_2n_m1: CSA_EAC generic map	(n => 2*n)
  	port map (I0 => sum0_2n_m1, I1 => carry0_2n_m1, I2 => D, S => sum1_2n_m1, C => carry1_2n_m1);
  
  add_2n_m1: CPA_mod255 generic map	(n => 2*n)
    port map(s1 => sum1_2n_m1, c1 => carry1_2n_m1, f => saida); 

  output(4*n-1 downto 0) <= (saida & R1);  
  
  end Structural;

  