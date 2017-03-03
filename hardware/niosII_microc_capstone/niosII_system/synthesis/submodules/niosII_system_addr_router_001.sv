// (C) 2001-2013 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// $Id: //acds/rel/12.1sp1/ip/merlin/altera_merlin_router/altera_merlin_router.sv.terp#1 $
// $Revision: #1 $
// $Date: 2012/10/10 $
// $Author: swbranch $

// -------------------------------------------------------
// Merlin Router
//
// Asserts the appropriate one-hot encoded channel based on 
// either (a) the address or (b) the dest id. The DECODER_TYPE
// parameter controls this behaviour. 0 means address decoder,
// 1 means dest id decoder.
//
// In the case of (a), it also sets the destination id.
// -------------------------------------------------------

`timescale 1 ns / 1 ns

module niosII_system_addr_router_001_default_decode
  #(
     parameter DEFAULT_CHANNEL = 2,
               DEFAULT_DESTID = 2 
   )
  (output [102 - 99 : 0] default_destination_id,
   output [12-1 : 0] default_src_channel
  );

  assign default_destination_id = 
    DEFAULT_DESTID[102 - 99 : 0];
  generate begin : default_decode
    if (DEFAULT_CHANNEL == -1)
      assign default_src_channel = '0;
    else
      assign default_src_channel = 12'b1 << DEFAULT_CHANNEL;
  end
  endgenerate

endmodule


module niosII_system_addr_router_001
(
    // -------------------
    // Clock & Reset
    // -------------------
    input clk,
    input reset,

    // -------------------
    // Command Sink (Input)
    // -------------------
    input                       sink_valid,
    input  [113-1 : 0]    sink_data,
    input                       sink_startofpacket,
    input                       sink_endofpacket,
    output                      sink_ready,

    // -------------------
    // Command Source (Output)
    // -------------------
    output                          src_valid,
    output reg [113-1    : 0] src_data,
    output reg [12-1 : 0] src_channel,
    output                          src_startofpacket,
    output                          src_endofpacket,
    input                           src_ready
);

    // -------------------------------------------------------
    // Local parameters and variables
    // -------------------------------------------------------
    localparam PKT_ADDR_H = 67;
    localparam PKT_ADDR_L = 36;
    localparam PKT_DEST_ID_H = 102;
    localparam PKT_DEST_ID_L = 99;
    localparam ST_DATA_W = 113;
    localparam ST_CHANNEL_W = 12;
    localparam DECODER_TYPE = 0;

    localparam PKT_TRANS_WRITE = 70;
    localparam PKT_TRANS_READ  = 71;

    localparam PKT_ADDR_W = PKT_ADDR_H-PKT_ADDR_L + 1;
    localparam PKT_DEST_ID_W = PKT_DEST_ID_H-PKT_DEST_ID_L + 1;




    // -------------------------------------------------------
    // Figure out the number of bits to mask off for each slave span
    // during address decoding
    // -------------------------------------------------------
    localparam PAD0 = log2ceil(64'h1000000 - 64'h800000);
<<<<<<< HEAD
    localparam PAD1 = log2ceil(64'h1800000 - 64'h1400000);
    localparam PAD2 = log2ceil(64'h1900000 - 64'h1880000);
    localparam PAD3 = log2ceil(64'h1908000 - 64'h1904000);
    localparam PAD4 = log2ceil(64'h1909000 - 64'h1908800);
    localparam PAD5 = log2ceil(64'h1909400 - 64'h1909000);
    localparam PAD6 = log2ceil(64'h1909420 - 64'h1909400);
    localparam PAD7 = log2ceil(64'h1909430 - 64'h1909420);
    localparam PAD8 = log2ceil(64'h1909438 - 64'h1909430);
    localparam PAD9 = log2ceil(64'h1909440 - 64'h1909438);
    localparam PAD10 = log2ceil(64'h1909448 - 64'h1909440);
    localparam PAD11 = log2ceil(64'h190944a - 64'h1909448);
=======
    localparam PAD1 = log2ceil(64'h1080000 - 64'h1000000);
    localparam PAD2 = log2ceil(64'h1088000 - 64'h1084000);
    localparam PAD3 = log2ceil(64'h1089000 - 64'h1088800);
    localparam PAD4 = log2ceil(64'h1089400 - 64'h1089000);
    localparam PAD5 = log2ceil(64'h1089420 - 64'h1089400);
    localparam PAD6 = log2ceil(64'h1089430 - 64'h1089420);
    localparam PAD7 = log2ceil(64'h1089438 - 64'h1089430);
    localparam PAD8 = log2ceil(64'h1089440 - 64'h1089438);
    localparam PAD9 = log2ceil(64'h1089448 - 64'h1089440);
    localparam PAD10 = log2ceil(64'h108944a - 64'h1089448);
>>>>>>> 5ad83e7060fa5395a087dcd97f7ed6f833c3ac8b
    // -------------------------------------------------------
    // Work out which address bits are significant based on the
    // address range of the slaves. If the required width is too
    // large or too small, we use the address field width instead.
    // -------------------------------------------------------
<<<<<<< HEAD
    localparam ADDR_RANGE = 64'h190944a;
=======
    localparam ADDR_RANGE = 64'h108944a;
>>>>>>> 5ad83e7060fa5395a087dcd97f7ed6f833c3ac8b
    localparam RANGE_ADDR_WIDTH = log2ceil(ADDR_RANGE);
    localparam OPTIMIZED_ADDR_H = (RANGE_ADDR_WIDTH > PKT_ADDR_W) ||
                                  (RANGE_ADDR_WIDTH == 0) ?
                                        PKT_ADDR_H :
                                        PKT_ADDR_L + RANGE_ADDR_WIDTH - 1;
    localparam RG = RANGE_ADDR_WIDTH-1;

      wire [PKT_ADDR_W-1 : 0] address = sink_data[OPTIMIZED_ADDR_H : PKT_ADDR_L];

    // -------------------------------------------------------
    // Pass almost everything through, untouched
    // -------------------------------------------------------
    assign sink_ready        = src_ready;
    assign src_valid         = sink_valid;
    assign src_startofpacket = sink_startofpacket;
    assign src_endofpacket   = sink_endofpacket;

    wire [PKT_DEST_ID_W-1:0] default_destid;
    wire [12-1 : 0] default_src_channel;




    niosII_system_addr_router_001_default_decode the_default_decode(
      .default_destination_id (default_destid),
      .default_src_channel (default_src_channel)
    );

    always @* begin
        src_data    = sink_data;
        src_channel = default_src_channel;

        src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = default_destid;
        // --------------------------------------------------
        // Address Decoder
        // Sets the channel and destination ID based on the address
        // --------------------------------------------------

        // ( 0x800000 .. 0x1000000 )
        if ( {address[RG:PAD0],{PAD0{1'b0}}} == 25'h800000 ) begin
<<<<<<< HEAD
            src_channel = 12'b000000001000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 3;
        end

        // ( 0x1400000 .. 0x1800000 )
        if ( {address[RG:PAD1],{PAD1{1'b0}}} == 25'h1400000 ) begin
            src_channel = 12'b000000010000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 4;
        end

        // ( 0x1880000 .. 0x1900000 )
        if ( {address[RG:PAD2],{PAD2{1'b0}}} == 25'h1880000 ) begin
            src_channel = 12'b000000000100;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 2;
        end

        // ( 0x1904000 .. 0x1908000 )
        if ( {address[RG:PAD3],{PAD3{1'b0}}} == 25'h1904000 ) begin
            src_channel = 12'b000000000010;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 1;
        end

        // ( 0x1908800 .. 0x1909000 )
        if ( {address[RG:PAD4],{PAD4{1'b0}}} == 25'h1908800 ) begin
            src_channel = 12'b000000000001;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 0;
        end

        // ( 0x1909000 .. 0x1909400 )
        if ( {address[RG:PAD5],{PAD5{1'b0}}} == 25'h1909000 ) begin
            src_channel = 12'b100000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 11;
        end

        // ( 0x1909400 .. 0x1909420 )
        if ( {address[RG:PAD6],{PAD6{1'b0}}} == 25'h1909400 ) begin
            src_channel = 12'b000001000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 6;
        end

        // ( 0x1909420 .. 0x1909430 )
        if ( {address[RG:PAD7],{PAD7{1'b0}}} == 25'h1909420 ) begin
            src_channel = 12'b010000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 10;
        end

        // ( 0x1909430 .. 0x1909438 )
        if ( {address[RG:PAD8],{PAD8{1'b0}}} == 25'h1909430 ) begin
            src_channel = 12'b000100000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 8;
        end

        // ( 0x1909438 .. 0x1909440 )
        if ( {address[RG:PAD9],{PAD9{1'b0}}} == 25'h1909438 ) begin
            src_channel = 12'b000010000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 7;
        end

        // ( 0x1909440 .. 0x1909448 )
        if ( {address[RG:PAD10],{PAD10{1'b0}}} == 25'h1909440 ) begin
            src_channel = 12'b000000100000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 5;
        end

        // ( 0x1909448 .. 0x190944a )
        if ( {address[RG:PAD11],{PAD11{1'b0}}} == 25'h1909448 ) begin
            src_channel = 12'b001000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 9;
=======
            src_channel = 11'b00000000100;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 2;
        end

        // ( 0x1000000 .. 0x1080000 )
        if ( {address[RG:PAD1],{PAD1{1'b0}}} == 25'h1000000 ) begin
            src_channel = 11'b00000001000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 3;
        end

        // ( 0x1084000 .. 0x1088000 )
        if ( {address[RG:PAD2],{PAD2{1'b0}}} == 25'h1084000 ) begin
            src_channel = 11'b00000000010;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 1;
        end

        // ( 0x1088800 .. 0x1089000 )
        if ( {address[RG:PAD3],{PAD3{1'b0}}} == 25'h1088800 ) begin
            src_channel = 11'b00000000001;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 0;
        end

        // ( 0x1089000 .. 0x1089400 )
        if ( {address[RG:PAD4],{PAD4{1'b0}}} == 25'h1089000 ) begin
            src_channel = 11'b10000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 10;
        end

        // ( 0x1089400 .. 0x1089420 )
        if ( {address[RG:PAD5],{PAD5{1'b0}}} == 25'h1089400 ) begin
            src_channel = 11'b00000100000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 5;
        end

        // ( 0x1089420 .. 0x1089430 )
        if ( {address[RG:PAD6],{PAD6{1'b0}}} == 25'h1089420 ) begin
            src_channel = 11'b01000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 9;
        end

        // ( 0x1089430 .. 0x1089438 )
        if ( {address[RG:PAD7],{PAD7{1'b0}}} == 25'h1089430 ) begin
            src_channel = 11'b00010000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 7;
        end

        // ( 0x1089438 .. 0x1089440 )
        if ( {address[RG:PAD8],{PAD8{1'b0}}} == 25'h1089438 ) begin
            src_channel = 11'b00001000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 6;
        end

        // ( 0x1089440 .. 0x1089448 )
        if ( {address[RG:PAD9],{PAD9{1'b0}}} == 25'h1089440 ) begin
            src_channel = 11'b00000010000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 4;
        end

        // ( 0x1089448 .. 0x108944a )
        if ( {address[RG:PAD10],{PAD10{1'b0}}} == 25'h1089448 ) begin
            src_channel = 11'b00100000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 8;
>>>>>>> 5ad83e7060fa5395a087dcd97f7ed6f833c3ac8b
        end

end


    // --------------------------------------------------
    // Ceil(log2()) function
    // --------------------------------------------------
    function integer log2ceil;
        input reg[65:0] val;
        reg [65:0] i;

        begin
            i = 1;
            log2ceil = 0;

            while (i < val) begin
                log2ceil = log2ceil + 1;
                i = i << 1;
            end
        end
    endfunction

endmodule


