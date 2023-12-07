----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/06/04 13:09:31
-- Design Name: 
-- Module Name: DLED - Behavioral
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

entity DLED is
  Port (
    clk,rst: in std_logic;
    cm_out:in std_logic_vector(47 downto 0);
    sel:out std_logic_vector(15 downto 0);   --选择信号
    dis:out std_logic_vector(7 downto 0)    --输出数码管
   );
end DLED;

architecture Behavioral of DLED is
type states is (s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11);     --用5状态机实现
signal next_state: states:=s0;
signal clk_out:std_logic:='0';   --输出时钟信号，对输入时钟分频
begin

    process(clk)    --负责对输入的时钟信号分频 200000分频
    variable count:integer:=0;
    begin
        if clk'event and clk='1' then
            count:=count+1;
        end if;
        if count>=100000 and clk_out='0' then
            clk_out<='1';
            count:=0;
        elsif count>=100000 and clk_out='1' then
            clk_out<='0';
            count:=0;
        end if;
    end process;
    --clk_out<=clk; --测试仿真使用
    process(clk_out,rst,cm_out)
    begin
        if rst='1' then
            next_state<=s0;
            sel<="0000000000000000";
            dis<="11000000";
        elsif clk_out'event and clk_out='1' then
            case next_state is
                when s0=>
                    sel<="0111111111111111";          --选中高位数码管
                    case cm_out(47 downto 44) is
                        when "0000"=>dis<="11000000";
                        when "0001"=>dis<="11111001";
                        when "0010"=>dis<="10100100";
                        when "0011"=>dis<="10110000";
                        when "0100"=>dis<="10011001";
                        when "0101"=>dis<="10010010";
                        when "0110"=>dis<="10000010";
                        when "0111"=>dis<="11111000";
                        when "1000"=>dis<="10000000";
                        when "1001"=>dis<="10010000";
                        when "1010"=>dis<="10001000";
                        when "1011"=>dis<="10000011";
                        when "1100"=>dis<="11000110";
                        when "1101"=>dis<="10100001";
                        when "1110"=>dis<="10000110";
                        when "1111"=>dis<="10001110";
                        when others=>dis<="11111111";
                   end case;
                   next_state<=s1;
                when s1=>
                    sel<="1011111111111111";          --选中低位数码管
                    case cm_out(43 downto 40) is
                        when "0000"=>dis<="11000000";
                        when "0001"=>dis<="11111001";
                        when "0010"=>dis<="10100100";
                        when "0011"=>dis<="10110000";
                        when "0100"=>dis<="10011001";
                        when "0101"=>dis<="10010010";
                        when "0110"=>dis<="10000010";
                        when "0111"=>dis<="11111000";
                        when "1000"=>dis<="10000000";
                        when "1001"=>dis<="10010000";
                        when "1010"=>dis<="10001000";
                        when "1011"=>dis<="10000011";
                        when "1100"=>dis<="11000110";
                        when "1101"=>dis<="10100001";
                        when "1110"=>dis<="10000110";
                        when "1111"=>dis<="10001110";
                        when others=>dis<="11111111";
                   end case;
                   next_state<=s2;
               when s2=>
                    sel<="1101111111111111";          --选中低位数码管
                    case cm_out(39 downto 36) is
                        when "0000"=>dis<="11000000";
                        when "0001"=>dis<="11111001";
                        when "0010"=>dis<="10100100";
                        when "0011"=>dis<="10110000";
                        when "0100"=>dis<="10011001";
                        when "0101"=>dis<="10010010";
                        when "0110"=>dis<="10000010";
                        when "0111"=>dis<="11111000";
                        when "1000"=>dis<="10000000";
                        when "1001"=>dis<="10010000";
                        when "1010"=>dis<="10001000";
                        when "1011"=>dis<="10000011";
                        when "1100"=>dis<="11000110";
                        when "1101"=>dis<="10100001";
                        when "1110"=>dis<="10000110";
                        when "1111"=>dis<="10001110";
                        when others=>dis<="11111111";
                   end case;
                   next_state<=s3;
               when s3=>
                    sel<="1110111111111111";          --选中低位数码管
                    case cm_out(35 downto 32) is
                        when "0000"=>dis<="11000000";
                        when "0001"=>dis<="11111001";
                        when "0010"=>dis<="10100100";
                        when "0011"=>dis<="10110000";
                        when "0100"=>dis<="10011001";
                        when "0101"=>dis<="10010010";
                        when "0110"=>dis<="10000010";
                        when "0111"=>dis<="11111000";
                        when "1000"=>dis<="10000000";
                        when "1001"=>dis<="10010000";
                        when "1010"=>dis<="10001000";
                        when "1011"=>dis<="10000011";
                        when "1100"=>dis<="11000110";
                        when "1101"=>dis<="10100001";
                        when "1110"=>dis<="10000110";
                        when "1111"=>dis<="10001110";
                        when others=>dis<="11111111";
                   end case;
                   next_state<=s4;
               when s4=>
                    sel<="1111011111111111";          --选中低位数码管
                    case cm_out(31 downto 28) is
                        when "0000"=>dis<="11000000";
                        when "0001"=>dis<="11111001";
                        when "0010"=>dis<="10100100";
                        when "0011"=>dis<="10110000";
                        when "0100"=>dis<="10011001";
                        when "0101"=>dis<="10010010";
                        when "0110"=>dis<="10000010";
                        when "0111"=>dis<="11111000";
                        when "1000"=>dis<="10000000";
                        when "1001"=>dis<="10010000";
                        when "1010"=>dis<="10001000";
                        when "1011"=>dis<="10000011";
                        when "1100"=>dis<="11000110";
                        when "1101"=>dis<="10100001";
                        when "1110"=>dis<="10000110";
                        when "1111"=>dis<="10001110";
                        when others=>dis<="11111111";
                   end case;
                   next_state<=s5;
               when s5=>
                    sel<="1111101111111111";          --选中低位数码管
                    case cm_out(27 downto 24) is
                        when "0000"=>dis<="11000000";
                        when "0001"=>dis<="11111001";
                        when "0010"=>dis<="10100100";
                        when "0011"=>dis<="10110000";
                        when "0100"=>dis<="10011001";
                        when "0101"=>dis<="10010010";
                        when "0110"=>dis<="10000010";
                        when "0111"=>dis<="11111000";
                        when "1000"=>dis<="10000000";
                        when "1001"=>dis<="10010000";
                        when "1010"=>dis<="10001000";
                        when "1011"=>dis<="10000011";
                        when "1100"=>dis<="11000110";
                        when "1101"=>dis<="10100001";
                        when "1110"=>dis<="10000110";
                        when "1111"=>dis<="10001110";
                        when others=>dis<="11111111";
                   end case;
                   next_state<=s6;
               when s6=>
                    sel<="1111110111111111";          --选中低位数码管
                    case cm_out(23 downto 20) is
                        when "0000"=>dis<="11000000";
                        when "0001"=>dis<="11111001";
                        when "0010"=>dis<="10100100";
                        when "0011"=>dis<="10110000";
                        when "0100"=>dis<="10011001";
                        when "0101"=>dis<="10010010";
                        when "0110"=>dis<="10000010";
                        when "0111"=>dis<="11111000";
                        when "1000"=>dis<="10000000";
                        when "1001"=>dis<="10010000";
                        when "1010"=>dis<="10001000";
                        when "1011"=>dis<="10000011";
                        when "1100"=>dis<="11000110";
                        when "1101"=>dis<="10100001";
                        when "1110"=>dis<="10000110";
                        when "1111"=>dis<="10001110";
                        when others=>dis<="11111111";
                   end case;
                   next_state<=s7;
               when s7=>
                    sel<="1111111011111111";          --选中低位数码管
                    case cm_out(19 downto 16) is
                        when "0000"=>dis<="11000000";
                        when "0001"=>dis<="11111001";
                        when "0010"=>dis<="10100100";
                        when "0011"=>dis<="10110000";
                        when "0100"=>dis<="10011001";
                        when "0101"=>dis<="10010010";
                        when "0110"=>dis<="10000010";
                        when "0111"=>dis<="11111000";
                        when "1000"=>dis<="10000000";
                        when "1001"=>dis<="10010000";
                        when "1010"=>dis<="10001000";
                        when "1011"=>dis<="10000011";
                        when "1100"=>dis<="11000110";
                        when "1101"=>dis<="10100001";
                        when "1110"=>dis<="10000110";
                        when "1111"=>dis<="10001110";
                        when others=>dis<="11111111";
                   end case;
                   next_state<=s8;
               when s8=>
                    sel<="1111111101111111";          --选中低位数码管
                    case cm_out(15 downto 12) is
                        when "0000"=>dis<="11000000";
                        when "0001"=>dis<="11111001";
                        when "0010"=>dis<="10100100";
                        when "0011"=>dis<="10110000";
                        when "0100"=>dis<="10011001";
                        when "0101"=>dis<="10010010";
                        when "0110"=>dis<="10000010";
                        when "0111"=>dis<="11111000";
                        when "1000"=>dis<="10000000";
                        when "1001"=>dis<="10010000";
                        when "1010"=>dis<="10001000";
                        when "1011"=>dis<="10000011";
                        when "1100"=>dis<="11000110";
                        when "1101"=>dis<="10100001";
                        when "1110"=>dis<="10000110";
                        when "1111"=>dis<="10001110";
                        when others=>dis<="11111111";
                   end case;
                   next_state<=s9;
               when s9=>
                    sel<="1111111110111111";          --选中低位数码管
                    case cm_out(11 downto 8) is
                        when "0000"=>dis<="11000000";
                        when "0001"=>dis<="11111001";
                        when "0010"=>dis<="10100100";
                        when "0011"=>dis<="10110000";
                        when "0100"=>dis<="10011001";
                        when "0101"=>dis<="10010010";
                        when "0110"=>dis<="10000010";
                        when "0111"=>dis<="11111000";
                        when "1000"=>dis<="10000000";
                        when "1001"=>dis<="10010000";
                        when "1010"=>dis<="10001000";
                        when "1011"=>dis<="10000011";
                        when "1100"=>dis<="11000110";
                        when "1101"=>dis<="10100001";
                        when "1110"=>dis<="10000110";
                        when "1111"=>dis<="10001110";
                        when others=>dis<="11111111";
                   end case;
                   next_state<=s10;
               when s10=>
                    sel<="1111111111011111";          --选中低位数码管
                    case cm_out(7 downto 4) is
                        when "0000"=>dis<="11000000";
                        when "0001"=>dis<="11111001";
                        when "0010"=>dis<="10100100";
                        when "0011"=>dis<="10110000";
                        when "0100"=>dis<="10011001";
                        when "0101"=>dis<="10010010";
                        when "0110"=>dis<="10000010";
                        when "0111"=>dis<="11111000";
                        when "1000"=>dis<="10000000";
                        when "1001"=>dis<="10010000";
                        when "1010"=>dis<="10001000";
                        when "1011"=>dis<="10000011";
                        when "1100"=>dis<="11000110";
                        when "1101"=>dis<="10100001";
                        when "1110"=>dis<="10000110";
                        when "1111"=>dis<="10001110";
                        when others=>dis<="11111111";
                   end case;
                   next_state<=s11;
               when s11=>
                    sel<="1111111111101111";          --选中低位数码管
                    case cm_out(3 downto 0) is
                        when "0000"=>dis<="11000000";
                        when "0001"=>dis<="11111001";
                        when "0010"=>dis<="10100100";
                        when "0011"=>dis<="10110000";
                        when "0100"=>dis<="10011001";
                        when "0101"=>dis<="10010010";
                        when "0110"=>dis<="10000010";
                        when "0111"=>dis<="11111000";
                        when "1000"=>dis<="10000000";
                        when "1001"=>dis<="10010000";
                        when "1010"=>dis<="10001000";
                        when "1011"=>dis<="10000011";
                        when "1100"=>dis<="11000110";
                        when "1101"=>dis<="10100001";
                        when "1110"=>dis<="10000110";
                        when "1111"=>dis<="10001110";
                        when others=>dis<="11111111";
                   end case;
                   next_state<=s0;
               end case;
           end if;
       end process;
end Behavioral;
