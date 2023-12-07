----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/05/31 22:11:49
-- Design Name: 
-- Module Name: alu_tb - Behavioral
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

entity alu_tb is
--  Port ( );
end alu_tb;

architecture Behavioral of alu_tb is
component alu is
--  Port ( );
port(
    clk_alu: in std_logic;--时钟信号
    nreset: in std_logic;--复位信号
    m_a: in std_logic;--暂存器控制信号
    m_b: in std_logic;--暂存器控制信号
    m_f: in std_logic;--程序状态字控制信号
    alu_en: in std_logic;--alu运算输出使能
    psw_en: in std_logic;--psw输出使能
    c0: in std_logic;--进位输入
    s: in std_logic_vector(4 downto 0);--运算类型和操作选择
    f_in: in std_logic_vector(1 downto 0);--移位功能选择
    data: inout std_logic_vector(7 downto 0);--数据总线
    ac: out std_logic;--半进位标志
    cy: out std_logic;---进位标志
    zn: out std_logic;--零标志
    ov: out std_logic; --溢出标志
    ans:out std_logic_vector(7 downto 0)
);
end component;
signal clk_alu: std_logic;--时钟信号
signal nreset: std_logic;--复位信号
signal m_a: std_logic:='1';--暂存器控制信号
signal m_b: std_logic:='0';--暂存器控制信号
signal m_f: std_logic:='0';--程序状态字控制信号
signal alu_en:  std_logic:='0';--alu运算输出使能
signal psw_en:  std_logic:='0';--psw输出使能
signal c0:  std_logic:='0';--进位输入
signal s: std_logic_vector(4 downto 0):="00110";--运算类型和操作选择
signal f_in:  std_logic_vector(1 downto 0):="00";--移位功能选择
signal data:  std_logic_vector(7 downto 0):="00000000";--数据总线
signal ac: std_logic;--半进位标志
signal cy: std_logic;---进位标志
signal zn: std_logic;--零标志
signal ov: std_logic; --溢出标志
signal ans:std_logic_vector(7 downto 0);
begin
u1: alu port map(clk_alu,nreset,m_a,m_b,m_f,alu_en,psw_en,c0,s,f_in,data,ac,cy,zn,ov,ans);

process
begin
clk_alu<='0';
wait for 10 ns;
clk_alu<='1';
wait for 10 ns;
end process;

process
begin
nreset<='1';
wait for 20 ns;
nreset<='0';
m_a<='1';
m_b<='0';
wait for 40 ns;
data<="00000001";
m_a<='0';
m_b<='1';
wait for 40 ns;
m_a<='0';
m_b<='0';
wait for 20 ns;
alu_en<='1';
psw_en<='1';
wait for 20 ns;
nreset<='0';
wait for 60 ns;
f_in<="01";
wait for 20 ns;
f_in<="10";
wait for 20 ns;
f_in<="11";
wait;
end process;

end Behavioral;
