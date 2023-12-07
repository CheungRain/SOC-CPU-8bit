----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/05/27 18:12:47
-- Design Name: 
-- Module Name: module_273 - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity module_273 is
--  Port ( );
port(
    d:in std_logic_vector(7 downto 0);
    clk:in std_logic;
    q:out std_logic_vector(7 downto 0)
);
end module_273;

architecture Behavioral of module_273 is

begin

process(clk)
begin
    if rising_edge(clk) then
        q<=d;
    end if;
end process;

end Behavioral;
