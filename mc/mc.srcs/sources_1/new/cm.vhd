----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/06/03 15:19:29
-- Design Name: 
-- Module Name: cm - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use STD.TEXTIO.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cm is --控制存储器
  Port (
    addr:in std_logic_vector(7 downto 0);
    oe:in std_logic;
    reset:in std_logic;
    dout:out std_logic_vector(47 downto 0)
  );
end cm;

architecture Behavioral of cm is
type matrix is array(integer range<>) of std_logic_vector(47 downto 0);
signal rom:matrix(255 downto 0);
signal count:std_logic_vector(255 downto 0);
procedure load_rom(signal data_word:out matrix;signal count:out std_logic_vector(255 downto 0)) is
    file romfile:text open read_mode is "D:\cm.txt"; --微指令文件
    variable lbuf:line;
    variable i:integer:=0;
    variable fdata:std_logic_vector(47 downto 0);
begin
    while not endfile(romfile) loop
        readline(romfile,lbuf);
        read(lbuf,fdata);
        data_word(i)<=fdata;
        count(i)<='1';
        i:=i+1;
        exit when i=256;
    end loop;
end procedure;
begin
    load_rom(rom,count);
    dout<=rom(conv_integer(addr))when oe='0' and reset='0' and count(conv_integer(addr))='1'
        else (others=>'0');
end Behavioral;
