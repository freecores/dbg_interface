//////////////////////////////////////////////////////////////////////
////                                                              ////
////  dbg_register.v                                              ////
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
//
//
//
//

`include "dbg_timescale.v"

module dbg_register(DataIn, DataOut, Write, Clk, Reset, Default);

parameter WIDTH = 8; // default parameter of the register width

input [WIDTH-1:0] DataIn;

input Write;
input Clk;
input Reset;
input [WIDTH-1:0] Default;

output [WIDTH-1:0] DataOut;
reg    [WIDTH-1:0] DataOut;

//always @ (posedge Clk or posedge Reset)
always @ (posedge Clk)
begin
  if(Reset)
    DataOut[WIDTH-1:0]<=#1 Default;
  else
    begin
      if(Write)                         // write
        DataOut[WIDTH-1:0]<=#1 DataIn[WIDTH-1:0];
    end
end


endmodule   // Register

