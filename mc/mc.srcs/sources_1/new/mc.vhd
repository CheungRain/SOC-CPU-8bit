----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/06/03 11:37:54
-- Design Name: 
-- Module Name: mc - Behavioral
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
use IEEE.STD_LOGIC_TEXTIO.ALL;
use STD.TEXTIO.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mc is
-- cm存放微程序 uir存放现行微指令 微地址形成电路--提供微地址 微地址寄存器--存放现在微地址
--微命令组合成微指令，微指令组合成微程序，微指令包含微命令字段（与控制有关）和微地址字段
port(
    clk_mc,clk: in std_logic;--微程序控制器时钟信号
    nreset: in std_logic;--异步复位
    ir: in std_logic_vector(7 downto 2);--ir操作码信息 27条指令 5位编码 8位微地址
    m_ua: in std_logic;--微地址控制信号
    cmrom_cs: in std_logic;--控制存储器选通信号
    --cm_out:inout std_logic_vector(47 downto 0); --控制信号输出 39条控制信号(微命令)+8位微地址=47 水平微指令 直接型编码 256*48bit 测试使用
    sel:out std_logic_vector(15 downto 0);--数码管选择信号
    dis:out std_logic_vector(7 downto 0)--数码管显示信号
);
end mc;

architecture Behavioral of mc is
component cm is --控制存储器
Port (
    addr:in std_logic_vector(7 downto 0);
    oe:in std_logic;
    reset:in std_logic;
    dout:out std_logic_vector(47 downto 0)
  );
end component;

component DLED is
Port (
    clk,rst: in std_logic;
    cm_out:in std_logic_vector(47 downto 0);
    sel:out std_logic_vector(15 downto 0);   --选择信号
    dis:out std_logic_vector(7 downto 0)    --输出数码管
   );
end component;

type state is(s0,s1,s2,s3,s4,s5);
signal s:state;
signal clk_out:std_logic;--消抖输出时钟信号
signal addr:std_logic_vector(7 downto 0);--微程序入口地址
signal uir:std_logic_vector(47 downto 0):=(others=>'0');--微指令
signal uar: std_logic_vector(7 downto 0);--微地址寄存器
signal cm_out:std_logic_vector(47 downto 0);--微指令寄存器输出

begin
u1:cm port map(addr,cmrom_cs,nreset,uir);
u2:DLED port map(clk,nreset,cm_out,sel,dis);


process(clk_out,nreset)
begin
    if nreset='1' then
        uar<="00000000";
        cm_out<=(others=>'0');
    elsif rising_edge(clk_out) and cmrom_cs='0' then
        addr<=uar;
        if m_ua='0' then --判断是否为程序入口地址
            if uir="000000000011000100011001111100110111100100000000" or uir="000000000011000100011001111100110111100000000000" then
                    uar<=ir&"00"; --指令寄存器高6位 因为微指令首地址为4的倍数  
           else
                uar<=uir(7 downto 0);  
            end if;
        end if;
        cm_out<=uir;--微指令寄存器输出
    end if;
end process;

process(nreset,clk_mc,clk)--按键消抖
variable count:integer:=1000;
begin
    if nreset='1' then
       s<=s0; 
    elsif rising_edge(clk) then
        case s is
            when s0 =>
                if clk_mc='1' then
                    s<=s1;
                else
                    clk_out<='0';
                end if;
            when s1 =>
                count:=count-1;
                if count=0 then
                    count:=1000;
                    s<=s2;
                else 
                    null;
                end if;
            when s2 =>
                if clk_mc='1' then
                    s<=s3;
                else
                    s<=s0;
                end if;
            when s3 =>
                if clk_mc='1' then
                    s<=s4;
                else
                    s<=s0;
                end if;
            when s4 =>
                if clk_mc='1' then
                    clk_out<='1';
                    s<=s5;
                else
                    s<=s0;
                end if;
            when s5 =>
                if clk_mc='1' then
                    null;
                else
                    s<=s0;
                    clk_out<='0';
                end if;
        end case;
    end if;
end process;

end Behavioral;
