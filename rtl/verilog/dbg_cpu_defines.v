//////////////////////////////////////////////////////////////////////
////                                                              ////
////  dbg_cpu_defines.v                                           ////
////                                                              ////
////                                                              ////
////  This file is part of the SoC Debug Interface.               ////
////  http://www.opencores.org/projects/DebugInterface/           ////
////                                                              ////
////  Author(s):                                                  ////
////       Igor Mohor (igorm@opencores.org)                       ////
////                                                              ////
////                                                              ////
////  All additional information is avaliable in the README.txt   ////
////  file.                                                       ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 - 2004 Authors                            ////
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
// Revision 1.5  2004/03/31 14:34:09  igorm
// data_cnt_lim length changed to reduce number of warnings.
//
// Revision 1.4  2004/03/28 20:27:02  igorm
// New release of the debug interface (3rd. release).
//
// Revision 1.3  2004/03/22 16:35:46  igorm
// Temp version before changing dbg interface.
//
// Revision 1.2  2004/01/17 17:01:14  mohor
// Almost finished.
//
// Revision 1.1  2004/01/16 14:53:33  mohor
// *** empty log message ***
//
//
//
                                                                                 
                                                                                 

// Defining length of the command
`define DBG_CPU_CMD_LEN          3'd4
`define DBG_CPU_CMD_CNT_WIDTH    3

// Defining length of the access_type field
`define DBG_CPU_ACC_TYPE_LEN     3'd4

// Defining length of the address
`define DBG_CPU_ADR_LEN          6'd32

// Defining length of the length register
`define DBG_CPU_LEN_LEN          5'd16

// Defining total length of the DR needed
`define DBG_CPU_DR_LEN           (`DBG_CPU_ACC_TYPE_LEN + `DBG_CPU_ADR_LEN + `DBG_CPU_LEN_LEN)

// Defining length of the CRC
`define DBG_CPU_CRC_LEN          6'd32
`define DBG_CPU_CRC_CNT_WIDTH    6

// Defining length of status
`define DBG_CPU_STATUS_LEN       3'd4
`define DBG_CPU_STATUS_CNT_WIDTH 3

// Defining length of the data
`define DBG_CPU_DATA_CNT_WIDTH      (`DBG_CPU_LEN_LEN + 3)
`define DBG_CPU_DATA_CNT_LIM_WIDTH   `DBG_CPU_LEN_LEN

// Defining length of the control register
`define DBG_CPU_CTRL_LEN         2

//Defining commands
`define DBG_CPU_GO               4'h0
`define DBG_CPU_RD_COMM          4'h1
`define DBG_CPU_WR_COMM          4'h2
`define DBG_CPU_RD_CTRL          4'h3
`define DBG_CPU_WR_CTRL          4'h4

// Defining access types for wishbone
`define DBG_CPU_WRITE            4'h2
`define DBG_CPU_READ             4'h6


