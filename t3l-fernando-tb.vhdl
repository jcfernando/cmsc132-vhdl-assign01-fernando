library IEEE; use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_alarm is
	constant MAX_COMB: integer := 256;
	constant DELAY: time := 10 ns;
end entity;

architecture priority_tb of tb_alarm is

	component alarm_encoder is
			port(alarm: out std_logic; in1,in2,in3,out1,out2,out3: in std_logic);
	end component;
	
	signal alarm: std_logic;
	signal in1,in2,in3,out1,out2,out3: std_logic;
	
begin --architecture

	uut: component alarm_encoder port map(alarm, in1,in2,in3,out1,out2,out3);
	main: process is
			variable temp: unsigned(5 downto 0);
			variable expected_alarm: std_logic;
			variable error_count: integer := 0;
			
	begin --process
	
		report "start simulation";
		
		for i in 0 to 63 loop
			temp := TO_UNSIGNED(i, 6);
			--assign each input a value from temp
			in1 <= temp(5);
			out1 <= temp(4);
			
			in2 <= temp(3);
			out2 <= temp(2);
			
			in3 <= temp(1);
			out3 <= temp(0);
			
			if ((i=0) AND (i=1) AND (i=2)) then 
					expected_alarm := '0';
			else
				if( temp(5) = '1' ) then
					if( temp(4) = '1' ) then expected_alarm := '1';
					elsif ( temp(2) = '1' ) then expected_alarm := '1';
					elsif ( temp(0) = '1' ) then expected_alarm := '1';
					else expected_alarm := '0';
					end if;
				elsif( temp(3) = '1' ) then
					if( temp(4) = '1' ) then expected_alarm := '1';
					elsif ( temp(2) = '1' ) then expected_alarm := '1';
					elsif ( temp(0) = '1' ) then expected_alarm := '1';
					else expected_alarm := '0';
					end if;
				elsif( temp(1) = '1' ) then
					if( temp(4) = '1' ) then expected_alarm := '1';
					elsif ( temp(2) = '1' ) then expected_alarm := '1';
					elsif ( temp(0) = '1' ) then expected_alarm := '1';
					else expected_alarm := '0';
					end if;
				else expected_alarm := '0';
				end if;
			end if;
			wait for DELAY;
			
			assert(expected_alarm = alarm)
				report "ERROR: Expected ALARM " & std_logic'image(expected_alarm) & " /= actual alarm " & 
					std_logic'image(alarm) & " at time " & time'image(now);
				
			if  (expected_alarm /= alarm)
				then error_count := error_count + 1;
			end if;
		end loop;
		
		wait for DELAY;
		assert (error_count = 0)
			report "ERROR: There were " &
				integer'image(error_count) & " errors!";
			if(error_count = 0)
				then report "Simulation completed with NO errors.";
			end if;
		wait;
	end process;
end architecture priority_tb;

--CHOICES:
--take note, some other answers to the blanks are not included below:

--1) component priority_encoder_4_2 port map(valid, encoded, i3,i2,i1,i0);
--2) tb_arch
--3) tb_priority_encoder_4_2
--4) port (valid: out std_logic; encoded: out std_logic_vector(1 downto 0); i3,i2,i1,i0: in std_logic );



