----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/06/2021 09:14:56 PM
-- Design Name: 
-- Module Name: tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is
 -- Clocking and reset interface
signal clk: std_logic;
signal reset: std_logic;
        --Input data interface
signal a_in:  std_logic_vector(7 downto 0);
signal b_in:  std_logic_vector(7 downto 0);
        -- Output interface
signal q: std_logic_vector(7 downto 0);
signal r: std_logic_vector(7 downto 0);
        -- COmmand interface]
signal start: std_logic;
        --Status intefrace
signal ready: std_logic;
begin
    tb: entity work.Algoritam_deljenja(Behavioral)
        generic map(WIDTH=> 8)
        port map(clk=>clk,
                 reset=>reset,
                 a_in=>a_in,
                 b_in=>b_in,
                 q=>q,
                 r=>r,
                 start=>start,
                 ready=>ready);
       process is
       begin
       clk<='0', '1' after 50ns;
       wait for 100ns;
       end process;             
        
       process is
       begin
       reset<='1', '0' after 25ns;
       start<='1';
       a_in<=X"0A";
       b_in<=X"03";
       wait ;
       end process;            

end Behavioral;
