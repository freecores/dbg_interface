//////////////////////////////////////////////////////////////////////
////                                                              ////
////  dbg_registers.v                                             ////
////                                                              ////
////                                                              ////
////  This file is part of the SoC/OpenRISC Development Interface ////
////  http://www.opencores.org/cores/DebugInterface/              ////
////                                                              ////
////                                                              ////
////  Author(s):                                                  ////
////       Igor Mohor                                             ////
////       igorm@opencores.org                                    ////
////                                                              ////
////                                                              ////
////  All additional information is avaliable in the README.txt   ////
////  file.                                                       ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000,2001 Authors                              ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: not supported by cvs2svn $
// Revision 1.5  2001/11/26 10:47:09  mohor
// Crc generation is different for read or write commands. Small synthesys fixes.
//
// Revision 1.4  2001/10/19 11:40:02  mohor
// dbg_timescale.v changed to timescale.v This is done for the simulation of
// few different cores in a single project.
//
// Revision 1.3  2001/10/15 09:55:47  mohor
// Wishbone interface added, few fixes for better performance,
// hooks for boundary scan testing added.
//
// Revision 1.2  2001/09/18 14:13:47  mohor
// Trace fixed. Some registers changed, trace simplified.
//
// Revision 1.1.1.1  2001/09/13 13:49:19  mohor
// Initial official release.
//
// Revision 1.3  2001/06/01 22:22:35  mohor
// This is a backup. It is not a fully working version. Not for use, yet.
//
// Revision 1.2  2001/05/18 13:10:00  mohor
// Headers changed. All additional information is now avaliable in the README.txt file.
//
// Revision 1.1.1.1  2001/05/18 06:35:10  mohor
// Initial release
//
//

// synopsys translate_off
`include "timescale.v"
// synopsys translate_on
`include "dbg_defines.v"

module dbg_registers(data_in, data_out, address, rw, access, clk, bp, reset, 
                     `ifdef TRACE_ENABLED
                     ContinMode, 
                     TraceEnable, WpTrigger, BpTrigger, LSSTrigger, 
                     ITrigger, TriggerOper, WpQualif, BpQualif, LSSQualif, IQualif, 
                     QualifOper, RecordPC, RecordLSEA, RecordLDATA, 
                     RecordSDATA, RecordReadSPR, RecordWriteSPR, RecordINSTR, 
                     WpTriggerValid, BpTriggerValid, LSSTriggerValid, ITriggerValid, 
                     WpQualifValid, BpQualifValid, LSSQualifValid, IQualifValid,
                     WpStop, BpStop, LSSStop, IStop, StopOper, WpStopValid, BpStopValid, 
                     LSSStopValid, IStopValid, 
                     `endif
                     risc_stall, risc_reset
                    );

parameter Tp = 1;

input [31:0] data_in;
input [4:0] address;

input rw;
input access;
input clk;
input bp;
input reset;

output [31:0] data_out;
reg    [31:0] data_out;

`ifdef TRACE_ENABLED
  output ContinMode;
  output TraceEnable;
  
  output [10:0] WpTrigger;
  output        BpTrigger;
  output [3:0]  LSSTrigger;
  output [1:0]  ITrigger;
  output [1:0]  TriggerOper;
  
  output        WpTriggerValid;
  output        BpTriggerValid;
  output        LSSTriggerValid;
  output        ITriggerValid;
  
  output [10:0] WpQualif;
  output        BpQualif;
  output [3:0]  LSSQualif;
  output [1:0]  IQualif;
  output [1:0]  QualifOper;
  
  output        WpQualifValid;
  output        BpQualifValid;
  output        LSSQualifValid;
  output        IQualifValid;
  
  output [10:0] WpStop;
  output        BpStop;
  output [3:0]  LSSStop;
  output [1:0]  IStop;
  output [1:0]  StopOper;
  
  output WpStopValid;
  output BpStopValid;
  output LSSStopValid;
  output IStopValid;
  
  output RecordPC;
  output RecordLSEA;
  output RecordLDATA;
  output RecordSDATA;
  output RecordReadSPR;
  output RecordWriteSPR;
  output RecordINSTR;
`endif

  output risc_stall;
  output risc_reset;

  wire MODER_Acc =   (address == `MODER_ADR)   & access;
  wire RISCOP_Acc =  (address == `RISCOP_ADR)  & access;
`ifdef TRACE_ENABLED
  wire TSEL_Acc =    (address == `TSEL_ADR)    & access;
  wire QSEL_Acc =    (address == `QSEL_ADR)    & access;
  wire SSEL_Acc =    (address == `SSEL_ADR)    & access;
  wire RECSEL_Acc =  (address == `RECSEL_ADR)  & access;
`endif

  
  wire MODER_Wr =   MODER_Acc   &  rw;
  wire RISCOP_Wr =  RISCOP_Acc  &  rw;
`ifdef TRACE_ENABLED
  wire TSEL_Wr =    TSEL_Acc    &  rw;
  wire QSEL_Wr =    QSEL_Acc    &  rw;
  wire SSEL_Wr =    SSEL_Acc    &  rw;
  wire RECSEL_Wr =  RECSEL_Acc  &  rw;
`endif


  
  wire MODER_Rd =   MODER_Acc   &  ~rw;
  wire RISCOP_Rd =  RISCOP_Acc  &  ~rw;
`ifdef TRACE_ENABLED
  wire TSEL_Rd =    TSEL_Acc    &  ~rw;
  wire QSEL_Rd =    QSEL_Acc    &  ~rw;
  wire SSEL_Rd =    SSEL_Acc    &  ~rw;
  wire RECSEL_Rd =  RECSEL_Acc  &  ~rw;
`endif


  wire [31:0] MODEROut;
  wire [1:1]  RISCOPOut;

`ifdef TRACE_ENABLED
  wire [31:0] TSELOut;
  wire [31:0] QSELOut;
  wire [31:0] SSELOut;
  wire [6:0]  RECSELOut;
`endif


`ifdef TRACE_ENABLED
  assign MODEROut[15:0] = 16'h0001;
  assign MODEROut[31:18] = 14'h0;
`else
  assign MODEROut[31:0] = 32'h0000;
`endif


  reg RiscStallBp;
  always @(posedge clk or posedge reset)
  begin
    if(reset)
      RiscStallBp <= 1'b0;
    else
    if(bp)                      // Breakpoint sets bit
      RiscStallBp <= 1'b1;
    else
    if(RISCOP_Wr)               // Register access can set or clear bit
      RiscStallBp <= data_in[0];
  end

  dbg_register #(1)  RISCOP (.data_in(data_in[1]), .data_out(RISCOPOut[1]), .write(RISCOP_Wr),   .clk(clk), .reset(reset), .defaulty(1'b0));


`ifdef TRACE_ENABLED
  dbg_register #(2)  MODER  (.data_in(data_in[17:16]), .data_out(MODEROut[17:16]), .write(MODER_Wr),   .clk(clk), .reset(reset), .defaulty(`MODER_DEF));
  dbg_register #(32) TSEL   (.data_in(data_in),      .data_out(TSELOut),    .write(TSEL_Wr),    .clk(clk), .reset(reset), .defaulty(`TSEL_DEF));
  dbg_register #(32) QSEL   (.data_in(data_in),      .data_out(QSELOut),    .write(QSEL_Wr),    .clk(clk), .reset(reset), .defaulty(`QSEL_DEF));
  dbg_register #(32) SSEL   (.data_in(data_in),      .data_out(SSELOut),    .write(SSEL_Wr),    .clk(clk), .reset(reset), .defaulty(`SSEL_DEF));
  dbg_register #(7) RECSEL  (.data_in(data_in[6:0]), .data_out(RECSELOut),  .write(RECSEL_Wr),  .clk(clk), .reset(reset), .defaulty(`RECSEL_DEF));
`endif



always @ (posedge clk)
begin
  if(MODER_Rd)    data_out<= #Tp MODEROut;
  else
  if(RISCOP_Rd)   data_out<= #Tp {30'h0, RISCOPOut[1], risc_stall};
`ifdef TRACE_ENABLED
  else
  if(TSEL_Rd)     data_out<= #Tp TSELOut;
  else
  if(QSEL_Rd)     data_out<= #Tp QSELOut;
  else
  if(SSEL_Rd)     data_out<= #Tp SSELOut;
  else
  if(RECSEL_Rd)   data_out<= #Tp {25'h0, RECSELOut};
`endif
  else            data_out<= #Tp 'h0;
end

`ifdef TRACE_ENABLED
  assign TraceEnable       = MODEROut[16];
  assign ContinMode        = MODEROut[17];
  
  assign WpTrigger[10:0]   = TSELOut[10:0];
  assign WpTriggerValid    = TSELOut[11];
  assign BpTrigger         = TSELOut[12];
  assign BpTriggerValid    = TSELOut[13];
  assign LSSTrigger[3:0]   = TSELOut[19:16];
  assign LSSTriggerValid   = TSELOut[20];
  assign ITrigger[1:0]     = TSELOut[22:21];
  assign ITriggerValid     = TSELOut[23];
  assign TriggerOper[1:0]  = TSELOut[31:30];
  
  assign WpQualif[10:0]    = QSELOut[10:0];
  assign WpQualifValid     = QSELOut[11];
  assign BpQualif          = QSELOut[12];
  assign BpQualifValid     = QSELOut[13];
  assign LSSQualif[3:0]    = QSELOut[19:16];
  assign LSSQualifValid    = QSELOut[20];
  assign IQualif[1:0]      = QSELOut[22:21];
  assign IQualifValid      = QSELOut[23];
  assign QualifOper[1:0]   = QSELOut[31:30];
  
  assign WpStop[10:0]    = SSELOut[10:0];
  assign WpStopValid     = SSELOut[11];
  assign BpStop          = SSELOut[12];
  assign BpStopValid     = SSELOut[13];
  assign LSSStop[3:0]    = SSELOut[19:16];
  assign LSSStopValid    = SSELOut[20];
  assign IStop[1:0]      = SSELOut[22:21];
  assign IStopValid      = SSELOut[23];
  assign StopOper[1:0]   = SSELOut[31:30];
  
  
  assign RecordPC           = RECSELOut[0];
  assign RecordLSEA         = RECSELOut[1];
  assign RecordLDATA        = RECSELOut[2];
  assign RecordSDATA        = RECSELOut[3];
  assign RecordReadSPR      = RECSELOut[4];
  assign RecordWriteSPR     = RECSELOut[5];
  assign RecordINSTR        = RECSELOut[6];
`endif

  assign risc_stall          = bp | RiscStallBp;   // bp asynchronously sets the risc_stall, then RiscStallBp (from register) holds it active
  assign risc_reset          = RISCOPOut[1];

endmodule
