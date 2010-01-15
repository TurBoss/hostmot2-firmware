library IEEE;
use IEEE.std_logic_1164.all;  -- defines std_logic types
use IEEE.std_logic_ARITH.ALL;
use IEEE.std_logic_UNSIGNED.ALL;
Library UNISIM;
use UNISIM.vcomponents.all;

--
-- Copyright (C) 2007, Peter C. Wallace, Mesa Electronics
-- http://www.mesanet.com
--
-- This program is is licensed under a disjunctive dual license giving you
-- the choice of one of the two following sets of free software/open source
-- licensing terms:
--
--    * GNU General Public License (GPL), version 2.0 or later
--    * 3-clause BSD License
-- 
--
-- The GNU GPL License:
-- 
--     This program is free software; you can redistribute it and/or modify
--     it under the terms of the GNU General Public License as published by
--     the Free Software Foundation; either version 2 of the License, or
--     (at your option) any later version.
-- 
--     This program is distributed in the hope that it will be useful,
--     but WITHOUT ANY WARRANTY; without even the implied warranty of
--     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--     GNU General Public License for more details.
-- 
--     You should have received a copy of the GNU General Public License
--     along with this program; if not, write to the Free Software
--     Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
-- 
-- 
-- The 3-clause BSD License:
-- 
--     Redistribution and use in source and binary forms, with or without
--     modification, are permitted provided that the following conditions
--     are met:
-- 
--         * Redistributions of source code must retain the above copyright
--           notice, this list of conditions and the following disclaimer.
-- 
--         * Redistributions in binary form must reproduce the above
--           copyright notice, this list of conditions and the following
--           disclaimer in the documentation and/or other materials
--           provided with the distribution.
-- 
--         * Neither the name of Mesa Electronics nor the names of its
--           contributors may be used to endorse or promote products
--           derived from this software without specific prior written
--           permission.
-- 
-- 
-- Disclaimer:
-- 
--     THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
--     "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
--     LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
--     FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
--     COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
--     INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
--     BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
--     LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
--     CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
--     LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
--     ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
--     POSSIBILITY OF SUCH DAMAGE.
-- 

use work.IDROMConst.all;	
use work.NumberOfModules.all;	
use work.MaxPinsPerModule.all;	
use work.CountPinsInRange.all;
use work.PinExists.all;

-------------------- option selection area ----------------------------


-------------------- select one card type------------------------------

--use work.i22_1000card.all;		-- needs 5i22.ucf and SP3 1000K 320 pin
--use work.i22_1500card.all;		-- needs 5i22.ucf and SP3 1500K 320 pin
--use work.i68card.all;				-- needs 4i68.ucf and SP3 400K 208 pin
--use work.i23card.all;				-- needs 5i23.ucf and SP3 400K 208 pin
use work.x20_1000card.all;			-- needs 7I68.ucf and SP3 1000K 456 pin
--use work.x20_1500card.all;		-- needs 7I68.ucf and SP3 1500K 456 pin
--use work.x20_2000card.all;		-- needs 7I68.ucf and SP3 2000K 456 pin. Note: ISE only


-----------------------------------------------------------------------


-------------------- select (or add) one pinout ---------------------------------

-- 72 I/O pinouts for 4I68, 5I23:
--use work.PIN_SVST8_4IM2_72.all;
--use work.PIN_SVST8_4_72.all;
--use work.PIN_SVST4_8_72.all;
--use work.PIN_SVST8_8IM2_72.all;
--use work.PIN_SVST2_4_7I47_72.all;
--use work.PIN_ST12_72.all;
--use work.PIN_SV12_72.all;
--use work.PIN_SVSP8_6_7I46_72.all;
--use work.PIN_24XQCTRONLY_72.all;
--use work.PIN_2X7I65_72.all;
--use work.PIN_SV12IM_2X7I48_72.all;
--use work.PIN_SVUA8_4_72.all;
--use work.PIN_JDOSA_BLUE_72.all;
--use work.PIN_JDOSA_YELLOW_72.all;

-- 96 I/O pinouts for 5I22:
--use work.PIN_SV16_96.all;
--use work.PIN_SVST8_8_96.all;
--use work.PIN_SVST8_24_96.all;
--use work.PIN_SVSTSP8_12_6_96.all;

-- 144 I/O pinouts for 3X20
-- use work.PIN_SV24_144.all;
use work.PIN_SVST16_24_144.all;

------------------------------------------------------------------------


-- dont change anything below unless you know what you are doing -------	

entity Top9054HostMot2 is  -- for 5I22, 5I23, 4I68 PCI9054 based cards
  	generic						-- and 3X20 PEX8311 (PCI9056) based cards
	(  	
		ThePinDesc: PinDescType := PinDesc;
		TheModuleID: ModuleIDType := ModuleID;
		PWMRefWidth: integer := 13;		-- PWM resolution is PWMRefWidth-1 bits, MSB is for symmetrical mode 
		IDROMType: integer := 3;		
		UseStepGenPrescaler : boolean := true;
		UseIRQLogic: boolean := true;
		UseWatchDog: boolean := true;
		OffsetToModules: integer := 64;
		OffsetToPinDesc: integer := 448;
		BusWidth: integer := 32;
		AddrWidth: integer := 16;
		InstStride0: integer := 4;
		InstStride1: integer := 16;
		RegStride0: integer := 256;
		RegStride1: integer := 256
		);
	port 
   (
     -- bus interface signals --
--	LRD: in std_logic; 
--	LWR: in std_logic; 
	LW_R: in std_logic; 
--	ALE: in std_logic; 
	ADS: in std_logic; 
	BLAST: in std_logic; 
--	WAITOUT: in std_logic;
--	LOCKO: in std_logic;
--	CS0: in std_logic;
--	CS1: in std_logic;
	READY: out std_logic;
	BTERM: out std_logic;
	INT: out std_logic;
	HOLD: in std_logic; 
	HOLDA: inout std_logic;
	CCS: out std_logic;
--	RESET: in std_logic;
	DISABLECONF: out std_logic;
	
   LAD: inout std_logic_vector (31 downto 0); 			-- data/address bus
-- 	LA: in std_logic_vector (8 downto 2); 				-- non-muxed address bus
--		LBE: in std_logic_vector (3 downto 0); 				-- byte enables

	IOBITS: inout std_logic_vector (IOWidth -1 downto 0);			
	LCLK: in std_logic;

	-- led bits
	LEDS: out std_logic_vector(LEDCount -1 downto 0)

	);
end Top9054HostMot2;

architecture dataflow of Top9054HostMot2 is

--	alias SYNCLK: std_logic is LCLK;
-- misc global signals --
signal D: std_logic_vector (BusWidth-1 downto 0);							-- internal data bus
signal DPipe: std_logic_vector (BusWidth-1 downto 0);						-- read pipeline reg 
signal LADPipe: std_logic_vector (BusWidth-1 downto 0);					-- write pipeline reg
signal LW_RPipe: std_logic;
signal A: std_logic_vector (15 downto 2);
signal Read: std_logic;
signal ReadTSEn: std_logic;	
signal Write: std_logic;
signal Burst: std_logic;
signal NextA: std_logic_vector (15 downto 2);
signal ReadyFF: std_logic;
	
-- CLK multiplier DCM signals

signal fclk : std_logic;
signal clkfx: std_logic;
signal clk0: std_logic;

	-- Extract the number of modules of each type from the ModuleID
constant StepGens: integer := NumberOfModules(TheModuleID,StepGenTag);
constant QCounters: integer := NumberOfModules(TheModuleID,QCountTag);
constant MuxedQCounters: integer := NumberOfModules(TheModuleID,MuxedQCountTag);			-- non-muxed index mask
constant MuxedQCountersMIM: integer := NumberOfModules(TheModuleID,MuxedQCountMIMTag); -- muxed index mask
constant PWMGens : integer := NumberOfModules(TheModuleID,PWMTag);
constant TPPWMGens : integer := NumberOfModules(TheModuleID,TPPWMTag);
constant SPIs: integer := NumberOfModules(TheModuleID,SPITag);
constant BSPIs: integer := NumberOfModules(TheModuleID,BSPITag);
constant DBSPIs: integer := NumberOfModules(TheModuleID,DBSPITag);
constant SSSIs: integer := NumberOfModules(TheModuleID,SSSITag);   
constant UARTs: integer := NumberOfModules(TheModuleID,UARTRTag);
	-- extract the needed Stepgen table width from the max pin# used with a stepgen tag
constant StepGenTableWidth: integer := MaxPinsPerModule(ThePinDesc,StepGenTag);
	-- extract how many BSPI CS pins are needed
constant BSPICSWidth: integer := CountPinsInRange(ThePinDesc,BSPITag,BSPICS0Pin,BSPICS7Pin);
	-- extract how many DBSPI CS pins are needed
constant DBSPICSWidth: integer := CountPinsInRange(ThePinDesc,DBSPITag,DBSPICS0Pin,DBSPICS7Pin);
constant UseProbe: boolean := PinExists(ThePinDesc,QCountTag,QCountProbePin);
constant UseMuxedProbe: boolean := PinExists(ThePinDesc,MuxedQCountTag,MuxedQCountProbePin);	
begin

   ClockMult : DCM
   generic map (
      CLKDV_DIVIDE => 2.0,
      CLKFX_DIVIDE => 2, 
      CLKFX_MULTIPLY => 4,			-- 4 FOR 96 MHz/100, 5 for 120/125, 6 for 144/150
      CLKIN_DIVIDE_BY_2 => FALSE, 
      CLKIN_PERIOD => 20.0,          
      CLKOUT_PHASE_SHIFT => "NONE", 
      CLK_FEEDBACK => "1X",         
      DESKEW_ADJUST => "SYSTEM_SYNCHRONOUS", 
                                            
      DFS_FREQUENCY_MODE => "LOW",
      DLL_FREQUENCY_MODE => "LOW",
      DUTY_CYCLE_CORRECTION => TRUE,
      FACTORY_JF => X"C080",
      PHASE_SHIFT => 0, 
      STARTUP_WAIT => FALSE)
   port map (
 
      CLK0 => clk0,   	-- 
      CLKFB => clk0,  	-- DCM clock feedback
		CLKFX => clkfx,
      CLKIN => LCLK,    -- Clock input (from IBUFG, BUFG or DCM)
      PSCLK => '0',   	-- Dynamic phase adjust clock input
      PSEN => '0',     	-- Dynamic phase adjust enable input
      PSINCDEC => '0', 	-- Dynamic phase adjust increment/decrement
      RST => '0'        -- DCM asynchronous reset input
   );
  
  BUFG_inst : BUFG
   port map (
      O => FClk,    -- Clock buffer output
      I => clkfx      -- Clock buffer input
   );

  -- End of DCM_inst instantiation
 
ahostmot2: entity HostMot2
	generic map (
		thepindesc => ThePinDesc,
		themoduleid => TheModuleID,
		stepgens  => StepGens,
		qcounters  => QCounters,
		muxedqcounters => MuxedQCounters,
		muxedqcountersmim => MuxedQCountersMIM,
		useprobe => UseProbe,
		usemuxedprobe => UseMuxedProbe,
		pwmgens  => PWMGens,
		spis  => SPIs,
		bspis => BSPIs,
		dbspis => DBSPIs,		
		sssis  => SSSIs,
		uarts  => UARTs,
		tppwmgens  => TPPWMGens,		
		pwmrefwidth  => PWMRefWidth,
		stepgentablewidth  => StepGenTableWidth,
		bspicswidth => BSPICSWidth,
		dbspicswidth => DBSPICSWidth,
		idromtype  => IDROMType,		
	   sepclocks  => SepClocks,
		onews  => OneWS,
		usestepgenprescaler => UseStepGenPrescaler,
		useirqlogic  => UseIRQLogic,
		usewatchdog  => UseWatchDog,
		offsettomodules  => OffsetToModules,
		offsettopindesc  => OffsetToPinDesc,
		clockhigh  => ClockHigh,
		clocklow  => ClockLow,
		boardnamelow => BoardNameLow,
		boardnamehigh => BoardNameHigh,
		fpgasize  => FPGASize,
		fpgapins  => FPGAPins,
		ioports  => IOPorts,
		iowidth  => IOWidth,
		portwidth  => PortWidth,
		buswidth  => BusWidth,
		addrwidth  => AddrWidth,
		inststride0 => InstStride0,
		inststride1 => InstStride1,
		regstride0 => RegStride0,
		regstride1 => RegStride1,
		ledcount  => LEDCount
		)
	port map (
		ibus =>  LADPipe,
		obus => D,
		addr => NextA,
		read => Read,
		write => Write,
		clklow => LCLK,
		clkhigh =>  FClk,
		int => INT, 
		iobits => IOBITS,			
		leds => LEDS	
		);

	LADDrivers: process (DPipe,ReadTSEn,LCLK)
	begin 
		if rising_edge(LCLK) then
			DPipe <= D;
			LADPipe <= LAD;
		end if;
		
		if ReadTSEn ='1' then	
			LAD <= DPipe;
		else
			LAD <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";			
		end if;
	end process LADDrivers;

	BusCycleGen: process (LCLK,ADS, LAD, ReadyFF, A, Burst, LW_RPipe)				-- added 1 wait state (read/write)
	begin
		if rising_edge(LCLK) then
			A <= NextA;								-- always update our latched address
	  		if ADS = '0' then						-- if *ADS then latch address & indicate start of burst
				Burst <= '1';
			end if;

			if BLAST = '0' and ReadyFF= '1' then	  			-- end of burst
				Burst <= '0';
			end if;
			
			if OneWS then			
				if Burst = '1' then
					ReadyFF <= not ReadyFF; 		-- just one wait state so toggle ReadyFF
				else
					ReadyFF <= '0';					-- idle not ready
				end if;
			else
				ReadyFF <= '1';						-- always ready if OneWS not used
			end if;
			LW_RPipe <= LW_R;
		end if; -- lclk
		if ADS = '0' then				 			-- NextA is combinatorial next address
			NextA <=	LAD(15 downto 2);			-- we need this for address lookahead for block RAM
		else										
			if ReadyFF = '1' then				
				NextA <= A+1;
			else
				NextA <= A;	
			end if;
		end if;
		
		Write <= Burst and LW_RPipe and ReadyFF; 			-- A write is any time during burst when LW_R is high and ReadyFF is high
																		-- Note that write writes the data from the LADPipe register to the destination						
		ReadTSEn <= Burst and not LW_RPipe;		         -- ReadTSEn is any time during burst when LW_R is low  = tri state enable on DPipe output			
		Read <= Burst and not LW_RPipe and not ReadyFF;	-- A read is any time during burst when LW_R is low and ReadyFF is low = internal read data enable to DPipe input			
		
		READY <= not ReadyFF;									-- note: target only! 	
	end process BusCycleGen;



	Not4I68or3X20: if (BoardNameHigh /= BoardName4I68) and (BoardNameHigh /= BoardName3X20) generate  
		DoHandshake: process (HOLD)
		begin
			HOLDA <= HOLD;
			CCS <= '1';
			DISABLECONF <= '0';
			BTERM <= '1';
		end process DoHandShake;
	end generate;

	Is4I68: if BoardNameHigh = BoardName4I68 generate	-- because the standard 4I68 does not have CCS connected
		DoHandshake: process (HOLD)
		begin
			HOLDA <= HOLD;
			DISABLECONF <= 'Z';
			BTERM <= '1';
		end process DoHandShake;
	end generate;
	
	Is3X20: if (BoardNameHigh = BoardName3X20) generate	-- because 3X20 does not have DISABLECONF connected
		DoHandshake: process (HOLD) -- 3X20 has no DISABLECONF
		begin
			HOLDA <= HOLD;
			CCS <= '1';
			BTERM <= '1';
		end process DoHandShake;
	end generate;	
	
end dataflow;

  