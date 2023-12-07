----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/06/03 17:12:17
-- Design Name: 
-- Module Name: control_seg - Behavioral
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

entity control_seg is
--  Port ( );
port(
    info: in std_logic_vector(39 downto 0);
    --pc模块(4条）
    LD_PC:out std_logic; --装载新地址
    M_PC:out std_logic; --PC 加 1 控制信号
    nPCH,nPCL:out std_logic --PC 输出总线控制信号
    --ROM 模块（2 条）
--    M_ROM :out std_logic; --ROM 片选信号
--    ROM_EN :out std_logic; --ROM 使能信号
--    --IR 模块（4 条）
--    LD_IR1,LD_IR2,LD_IR3 :out std_logic; --IR 指令存储控制信号
--    nARen :out std_logic; --IR 中 RAM 地址控制信号
--    --RN 模块（4 条）
--    Ri_CS :out std_logic; --RN 选择信号
--    Ri_EN :out std_logic; --RN 寄存器使能
--    RDRi,WRRi :out std_logic; --RN 读写信号
--    --ALU 模块（13 条）
--    M_A,M_B :out std_logic; --暂存器控制信号
--    M_F :out std_logic; --程序状态字控制信号
--    nALU_EN :out std_logic; --ALU 运算结果输出使能
--    nPSW_EN :out std_logic; --PSW 输出使能
--    C0 :out std_logic; --进位输入
--    S:out std_logic_vector(4 downto 0); --运算类型和操作选择
--    F_in:out std_logic_vector(1 downto 0); --移位功能选择
--    --RAM 模块（3 条）
--    RAM_CS :out std_logic; --RAM 片选信号
--    nRAM_EN :out std_logic; --RAM 输出使能信号
--    wr_nRD :out std_logic -- 读写信号

);
end control_seg;

architecture Behavioral of control_seg is

begin

process
begin
    if info(39)='1' then
        LD_PC<='1';
    elsif info(38)='1' then
        M_PC<='1';
    elsif info(37)='1' then
        nPCH<='1';
    elsif info(36)='1' then
        nPCL<='1';
    end if;
    
    
end process;

end Behavioral;
