library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

-- Created from usb.obj
-- On 2/23/2011

entity usbrom is
	port (
	addr: in std_logic_vector(10 downto 0);
	clk: in std_logic;
	din: in std_logic_vector(15 downto 0);
	dout: out std_logic_vector(15 downto 0);
	we: in std_logic);
end usbrom;

architecture syn of usbrom is
   type ram_type is array (0 to 2047) of std_logic_vector(15 downto 0);
   signal RAM : ram_type := 
   (
   x"0000", x"0000", x"6438", x"0100", x"E7E3", x"203C", x"0000", x"0000",
   x"0000", x"0101", x"B07B", x"0100", x"B7E3", x"0100", x"B7E6", x"0109",
   x"B7E7", x"013D", x"B7E8", x"0100", x"B7E9", x"0101", x"B07B", x"707B",
   x"97CD", x"A7C7", x"302F", x"0100", x"B07B", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"707C", x"B7D2", x"0101", x"B07B", x"77D2", x"0100",
   x"B7E6", x"0109", x"B7E7", x"013D", x"B7E8", x"0100", x"B7E9", x"77E6",
   x"E7C7", x"B7E6", x"77E7", x"F7C6", x"B7E7", x"77E8", x"F7C6", x"B7E8",
   x"77E9", x"F7C6", x"B7E9", x"4015", x"6438", x"0100", x"B07A", x"01EE",
   x"E06F", x"2045", x"0000", x"01FF", x"B41D", x"0150", x"0800", x"0104",
   x"0A00", x"0100", x"B7F3", x"0100", x"B7F6", x"0100", x"B7D5", x"63D4",
   x"77D2", x"B7CF", x"01C0", x"A7D2", x"304B", x"0000", x"01FF", x"B7F3",
   x"01C0", x"A7CF", x"B7DF", x"0000", x"0000", x"0180", x"E7DF", x"207C",
   x"013F", x"A7CF", x"B7E1", x"01FF", x"B7D5", x"0000", x"77E1", x"C7C6",
   x"0200", x"0200", x"0200", x"0200", x"0200", x"0A80", x"0300", x"A7D6",
   x"0880", x"0680", x"A7D7", x"C7D8", x"0A80", x"0000", x"0000", x"7880",
   x"B7CF", x"0C81", x"0000", x"0000", x"011F", x"A7CF", x"B7E0", x"0000",
   x"0000", x"01C0", x"E7DF", x"208C", x"0000", x"0000", x"01FF", x"E7CF",
   x"208C", x"0000", x"0000", x"1045", x"77CF", x"B800", x"0C01", x"01C0",
   x"A7CF", x"B7DF", x"01F0", x"A7CF", x"B7F6", x"013F", x"A7CF", x"B7E1",
   x"0108", x"A7CF", x"B7EA", x"0104", x"A7CF", x"B7D0", x"0103", x"A7CF",
   x"B7D1", x"0120", x"A7CF", x"B7CE", x"0150", x"E7F6", x"3125", x"0000",
   x"0000", x"01C0", x"E7DF", x"20B9", x"0120", x"E7CE", x"20B9", x"0100",
   x"E7D5", x"30B8", x"0000", x"0000", x"7880", x"B800", x"0C01", x"10B9",
   x"63A0", x"0140", x"E7DF", x"2125", x"0104", x"E7D0", x"20CD", x"0100",
   x"E7D5", x"30CB", x"0000", x"0000", x"7880", x"B800", x"7881", x"B801",
   x"0C02", x"0C82", x"10CD", x"63A0", x"63A0", x"0120", x"E7CE", x"2125",
   x"0100", x"E7D1", x"20DD", x"0110", x"A7CF", x"30DC", x"0000", x"7880",
   x"B800", x"0C01", x"0C81", x"10DD", x"63A0", x"0101", x"E7D1", x"20ED",
   x"0110", x"A7CF", x"30EB", x"0000", x"7880", x"B800", x"7881", x"B801",
   x"0C02", x"0C82", x"10ED", x"63A0", x"63A0", x"0102", x"E7D1", x"2103",
   x"0110", x"A7CF", x"30FF", x"0000", x"7880", x"B800", x"7881", x"B801",
   x"7882", x"B802", x"7883", x"B803", x"0C04", x"0C84", x"1103", x"63A0",
   x"63A0", x"63A0", x"63A0", x"0103", x"E7D1", x"2125", x"0110", x"A7CF",
   x"311D", x"0000", x"7880", x"B800", x"7881", x"B801", x"7882", x"B802",
   x"7883", x"B803", x"7884", x"B804", x"7885", x"B805", x"7886", x"B806",
   x"7887", x"B807", x"0C08", x"0C88", x"1125", x"63A0", x"63A0", x"63A0",
   x"63A0", x"63A0", x"63A0", x"63A0", x"63A0", x"0100", x"E7D5", x"212B",
   x"0000", x"0100", x"B7CF", x"0100", x"B800", x"0100", x"E7D5", x"3141",
   x"0000", x"7880", x"B7CF", x"0C81", x"B800", x"0C01", x"0400", x"E7D3",
   x"0600", x"F7D4", x"5141", x"0000", x"0000", x"0110", x"8411", x"B411",
   x"1045", x"77CF", x"208F", x"0000", x"0100", x"B7D5", x"0100", x"B800",
   x"0100", x"B7F3", x"0150", x"0800", x"0104", x"0A00", x"0000", x"0000",
   x"0100", x"B7F6", x"7800", x"B7CF", x"0C01", x"0000", x"0000", x"01C0",
   x"A7CF", x"B7DF", x"01F0", x"A7CF", x"B7F6", x"0108", x"A7CF", x"B7EA",
   x"0104", x"A7CF", x"B7D0", x"0103", x"A7CF", x"B7D1", x"0120", x"A7CF",
   x"B7CE", x"01C0", x"E7DF", x"2261", x"011F", x"A7CF", x"B7E0", x"0120",
   x"A7CF", x"B7CE", x"0480", x"B7DB", x"0680", x"B7DC", x"010F", x"E7E0",
   x"5192", x"0000", x"0000", x"0110", x"0880", x"0104", x"0A80", x"0480",
   x"C7E0", x"0880", x"0680", x"D7C6", x"0A80", x"0120", x"E7CE", x"218E",
   x"0000", x"0000", x"7800", x"0C01", x"B880", x"1191", x"0000", x"7880",
   x"6406", x"125D", x"0120", x"E7CE", x"21F4", x"0000", x"0000", x"01F7",
   x"E7CF", x"219F", x"0000", x"7800", x"0C01", x"B07A", x"11F3", x"01F8",
   x"E7CF", x"21B1", x"0100", x"E41A", x"21AC", x"0000", x"0000", x"0000",
   x"7800", x"0C01", x"B7D9", x"11B0", x"0000", x"7800", x"0C01", x"B7DD",
   x"11F3", x"01F9", x"E7CF", x"21C3", x"0100", x"E41A", x"21BE", x"0000",
   x"0000", x"0000", x"7800", x"0C01", x"B7DA", x"11C2", x"0000", x"7800",
   x"0C01", x"B7DE", x"11F3", x"01FA", x"E7CF", x"21DB", x"0100", x"E41A",
   x"21D2", x"0000", x"7800", x"0C01", x"C7D9", x"B7D9", x"77DA", x"D7C6",
   x"B7DA", x"11DA", x"0000", x"7800", x"0C01", x"C7DD", x"B7DD", x"77DE",
   x"D7C6", x"B7DE", x"11F3", x"01FD", x"E7CF", x"21E3", x"0000", x"7800",
   x"0C01", x"B7F0", x"11F3", x"01FE", x"E7CF", x"21F3", x"0000", x"7800",
   x"0C01", x"B7D2", x"0000", x"0000", x"015A", x"E7D2", x"21F2", x"0000",
   x"0000", x"103C", x"11F3", x"125D", x"01D0", x"E7CF", x"21FB", x"0000",
   x"0137", x"6406", x"125D", x"01D1", x"E7CF", x"2202", x"0000", x"0149",
   x"6406", x"125D", x"01D2", x"E7CF", x"2209", x"0000", x"0134", x"6406",
   x"125D", x"01D3", x"E7CF", x"2210", x"0000", x"0133", x"6406", x"125D",
   x"01D4", x"E7CF", x"2217", x"0000", x"0100", x"6406", x"125D", x"01DA",
   x"E7CF", x"221E", x"0000", x"0100", x"6406", x"125D", x"01DB", x"E7CF",
   x"2225", x"0000", x"742B", x"6406", x"125D", x"01DD", x"E7CF", x"222C",
   x"0000", x"0100", x"6406", x"125D", x"01DE", x"E7CF", x"2233", x"0000",
   x"0104", x"6406", x"125D", x"01DC", x"E7CF", x"223A", x"0000", x"0110",
   x"6406", x"125D", x"01D8", x"E7CF", x"2248", x"0000", x"0100", x"E41A",
   x"2245", x"0000", x"0000", x"77D9", x"1246", x"77DD", x"6406", x"125D",
   x"01D9", x"E7CF", x"2256", x"0000", x"0100", x"E41A", x"2253", x"0000",
   x"0000", x"77DA", x"1254", x"77DE", x"6406", x"125D", x"01DF", x"E7CF",
   x"225D", x"0000", x"015A", x"6406", x"125D", x"77DB", x"0880", x"77DC",
   x"0A80", x"013F", x"A7CF", x"B7E1", x"0150", x"E7F6", x"22C8", x"0107",
   x"A7CF", x"B7F6", x"0100", x"B7F4", x"0100", x"B7F5", x"0100", x"E7F6",
   x"2276", x"0101", x"B7F4", x"0100", x"B7F5", x"12A6", x"0101", x"E7F6",
   x"227E", x"0102", x"B7F4", x"01FF", x"B7F5", x"12A6", x"0102", x"E7F6",
   x"2286", x"0104", x"B7F4", x"0100", x"B7F5", x"12A6", x"0103", x"E7F6",
   x"228E", x"0108", x"B7F4", x"01FF", x"B7F5", x"12A6", x"0104", x"E7F6",
   x"2296", x"0110", x"B7F4", x"01FF", x"B7F5", x"12A6", x"0106", x"E7F6",
   x"229E", x"0140", x"B7F4", x"01FF", x"B7F5", x"12A6", x"0107", x"E7F6",
   x"22A6", x"0180", x"B7F4", x"01FF", x"B7F5", x"12A6", x"01D0", x"B7F0",
   x"0118", x"B7F1", x"741B", x"B7F2", x"77F0", x"E7C7", x"B7F0", x"77F1",
   x"F7C6", x"B7F1", x"42C1", x"0000", x"0000", x"01D0", x"B7F0", x"0118",
   x"B7F1", x"77F2", x"E7C7", x"B7F2", x"42C1", x"0180", x"8411", x"B411",
   x"1045", x"7089", x"97F5", x"A7F4", x"32AC", x"0000", x"0000", x"1399",
   x"0140", x"E7DF", x"2399", x"0104", x"E7D0", x"22DE", x"0100", x"E41A",
   x"22D8", x"0000", x"7800", x"B7D9", x"7801", x"B7DA", x"0C02", x"12DE",
   x"0000", x"7800", x"B7DD", x"7801", x"B7DE", x"0C02", x"0100", x"E41A",
   x"22F7", x"0000", x"0000", x"741D", x"22EB", x"0000", x"77D9", x"0880",
   x"77DA", x"0A80", x"12F6", x"77D9", x"B068", x"A7C9", x"B7CB", x"77DA",
   x"B069", x"0100", x"0A80", x"0160", x"C7CB", x"0880", x"12FC", x"77DD",
   x"0880", x"77DE", x"C7D8", x"0A80", x"0100", x"E41A", x"2308", x"0000",
   x"0000", x"741D", x"2307", x"01FF", x"E7D9", x"0103", x"F7DA", x"130C",
   x"01FF", x"E7DD", x"0103", x"F7DE", x"4316", x"0000", x"0000", x"0100",
   x"0880", x"0104", x"0A80", x"0120", x"8411", x"B411", x"0120", x"E7CE",
   x"2359", x"0100", x"E7D1", x"2322", x"0000", x"7800", x"B880", x"0C01",
   x"77C7", x"6416", x"0101", x"E7D1", x"232D", x"0000", x"7800", x"B880",
   x"7801", x"B881", x"0C02", x"77C8", x"6416", x"0102", x"E7D1", x"233C",
   x"0000", x"7800", x"B880", x"7801", x"B881", x"7802", x"B882", x"7803",
   x"B883", x"0C04", x"77CA", x"6416", x"0103", x"E7D1", x"2353", x"0000",
   x"7800", x"B880", x"7801", x"B881", x"7802", x"B882", x"7803", x"B883",
   x"7804", x"B884", x"7805", x"B885", x"7806", x"B886", x"7807", x"B887",
   x"0C08", x"77CC", x"6416", x"741D", x"3358", x"0000", x"0000", x"B06E",
   x"1399", x"741D", x"335E", x"0000", x"0000", x"B06D", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0100", x"E7D1", x"236B", x"0000", x"7880",
   x"6406", x"77C7", x"6416", x"0101", x"E7D1", x"2375", x"0000", x"7880",
   x"6406", x"7881", x"6406", x"77C8", x"6416", x"0102", x"E7D1", x"2383",
   x"0000", x"7880", x"6406", x"7881", x"6406", x"7882", x"6406", x"7883",
   x"6406", x"77CA", x"6416", x"0103", x"E7D1", x"2399", x"0000", x"7880",
   x"6406", x"7881", x"6406", x"7882", x"6406", x"7883", x"6406", x"7884",
   x"6406", x"7885", x"6406", x"7886", x"6406", x"7887", x"6406", x"77CC",
   x"6416", x"7800", x"2152", x"0000", x"0000", x"1045", x"0000", x"0000",
   x"01D0", x"B7F0", x"0118", x"B7F1", x"741B", x"B7F2", x"77F0", x"E7C7",
   x"B7F0", x"77F1", x"F7C6", x"B7F1", x"43BD", x"0000", x"01D0", x"B7F0",
   x"0118", x"B7F1", x"77F2", x"E7C7", x"B7F2", x"43BD", x"0000", x"77F3",
   x"33BD", x"0140", x"8411", x"B411", x"1045", x"0101", x"B07B", x"707B",
   x"97CD", x"A7C7", x"33A6", x"0000", x"0100", x"B07B", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"707C", x"B7D2", x"0101", x"B07B", x"77D2",
   x"77D2", x"B800", x"0C01", x"1800", x"01D0", x"B7F0", x"0118", x"B7F1",
   x"741B", x"B7F2", x"77F0", x"E7C7", x"B7F0", x"77F1", x"F7C6", x"B7F1",
   x"43F1", x"0000", x"01D0", x"B7F0", x"0118", x"B7F1", x"77F2", x"E7C7",
   x"B7F2", x"43F1", x"0000", x"77F3", x"33F1", x"0140", x"8411", x"B411",
   x"1045", x"0101", x"B07B", x"707B", x"97CD", x"A7C7", x"33DA", x"0000",
   x"0100", x"B07B", x"0000", x"0000", x"0000", x"0000", x"0000", x"707C",
   x"B7D2", x"0101", x"B07B", x"77D2", x"0000", x"1800", x"B7D2", x"707B",
   x"97CD", x"A7C8", x"3407", x"0105", x"B07B", x"0107", x"B07B", x"77D2",
   x"B07C", x"0000", x"0000", x"0101", x"B07B", x"1800", x"B7EB", x"77EA",
   x"3800", x"0480", x"C7EB", x"0880", x"0680", x"D7C6", x"0A80", x"0100",
   x"E41A", x"2432", x"0000", x"0000", x"741D", x"342D", x"77D9", x"C7EB",
   x"B7D9", x"77DA", x"D7C6", x"B7DA", x"1431", x"0480", x"B7D9", x"0680",
   x"B7DA", x"1437", x"0480", x"B7DD", x"0680", x"E7D8", x"B7DE", x"1800",
   x"0100", x"B7D2", x"B410", x"B411", x"B41A", x"B42B", x"B7F0", x"B7C6",
   x"0101", x"B7C7", x"0102", x"B7C8", x"0103", x"B7C9", x"0104", x"B7CA",
   x"0108", x"B7CC", x"01FF", x"B7CD", x"B41B", x"01F0", x"B7D6", x"0103",
   x"B7D7", x"010C", x"B7D8", x"01C0", x"B7DF", x"017A", x"B7D9", x"0100",
   x"B7DA", x"0100", x"B7DD", x"0100", x"B7DE", x"01B4", x"B7D3", x"0107",
   x"B7D4", x"1800", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
   x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000"
);

signal daddr: std_logic_vector(10 downto 0);

begin
   ausbrom: process (clk)
   begin
      if (clk'event and clk = '1') then
         if (we = '1') then
            RAM(conv_integer(addr)) <= din;
         end if;
         daddr <= addr;
      end if; -- clk 
   end process;

   dout <= RAM(conv_integer(daddr));
end;
