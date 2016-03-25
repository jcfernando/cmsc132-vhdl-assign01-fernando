library IEEE; use IEEE.std_logic_1164.all;

entity alarm_encoder is
	port(alarm: out std_logic; in1,in2,in3,out1,out2,out3: in std_logic);
end entity;

architecture priority of alarm_encoder is
begin
	process(in1,in2,in3,out1,out2,out3) is
		begin
			alarm <= (in1 or in2 or in3) AND (out1 or out2 or out3);
	end process;
end architecture priority;
