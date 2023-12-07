----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/06/03 16:08:57
-- Design Name: 
-- Module Name: mc_tb - Behavioral
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

entity mc_tb is
--  Port ( );
end mc_tb;

architecture Behavioral of mc_tb is
component mc is
-- cm存放微程序 uir存放现行微指令 微地址形成电路--提供微地址 微地址寄存器--存放现在微地址
--微命令组合成微指令，微指令组合成微程序，微指令包含微命令字段（与控制有关）和微地址字段

port(
    clk_mc,clk: in std_logic;--微程序控制器时钟信号
    nreset: in std_logic;--异步复位
    ir: in std_logic_vector(7 downto 2);--ir操作码信息 27条指令 5位编码 8位微地址
    m_ua: in std_logic;--微地址控制信号
    cmrom_cs: in std_logic;--控制存储器选通信号
    cm_out:inout std_logic_vector(47 downto 0); --控制信号输出 39条控制信号(微命令)+8位微地址=47 水平微指令 直接型编码 256*48bit
    sel:out std_logic_vector(15 downto 0);--数码管选择信号
    dis:out std_logic_vector(7 downto 0)--数码管显示信号
--    cm_out:inout std_logic_vector(47 downto 0); --控制信号输出 39条控制信号(微命令)+8位微地址=47 水平微指令 直接型编码 256*48bit
--    LD_PC:out std_logic; --装载新地址
--    M_PC:out std_logic; --PC 加 1 控制信号
--    nPCH,nPCL:out std_logic; --PC 输出总线控制信号
--    M_ROM :out std_logic; --ROM 片选信号
--    ROM_EN :out std_logic --ROM 使能信号
);
end component;
signal clk_mc,clk,clk_out:  std_logic:='0';--微程序控制器时钟信号
signal nreset: std_logic:='1';--异步复位
signal ir:  std_logic_vector(7 downto 2):="001001";--ir操作码信息 27条指令 5位编码 8位微地址
signal m_ua:  std_logic:='0';--微地址控制信号
signal cmrom_cs:  std_logic:='0';--控制存储器选通信号
signal cm_out: std_logic_vector(47 downto 0); --控制信号输出 39条控制信号(微命令)+8位微地址=47 水平微指令 直接型编码 256*48bit
signal sel:std_logic_vector(15 downto 0);--数码管选择信号
signal dis: std_logic_vector(7 downto 0);--数码管显示信号
begin
u1: mc port map(clk_mc,clk,nreset,ir,m_ua,cmrom_cs,cm_out,sel,dis);
process
begin
    clk_mc<='0';
    wait for 12 ns;
    clk_mc<='1';
    wait for 12 ns;
end process;

process
begin
    clk<='1';
    wait for 1 ns;
    clk<='0';
    wait for 1 ns;
end process;

process
begin
    nreset<='1';
    wait for 12 ns;
    nreset<='0';
    wait;
end process;
end Behavioral;
