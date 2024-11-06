/*
 * Copyright (c) 2024 Uri Shaked
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

parameter LOGO_SIZE = 128;  // Size of the logo in pixels
parameter DISPLAY_WIDTH = 640;  // VGA display width
parameter DISPLAY_HEIGHT = 480;  // VGA display height

module bitmap_rom (
    input wire [6:0] x,
    input wire [6:0] y,
    output wire pixel
);

  reg [7:0] mem[511:0];
  initial begin
    mem[0] = 8'h00;
    mem[1] = 8'h00;
    mem[2] = 8'h00;
    mem[3] = 8'hf0;
    mem[4] = 8'h00;
    mem[5] = 8'h00;
    mem[6] = 8'h00;
    mem[7] = 8'h00;
    mem[8] = 8'h00;
    mem[9] = 8'h00;
    mem[10] = 8'h00;
    mem[11] = 8'h90;
    mem[12] = 8'h03;
    mem[13] = 8'h00;
    mem[14] = 8'h00;
    mem[15] = 8'h00;
    mem[16] = 8'h00;
    mem[17] = 8'h00;
    mem[18] = 8'h00;
    mem[19] = 8'h10;
    mem[20] = 8'h0c;
    mem[21] = 8'h00;
    mem[22] = 8'hf8;
    mem[23] = 8'h01;
    mem[24] = 8'h00;
    mem[25] = 8'h7c;
    mem[26] = 8'h00;
    mem[27] = 8'h10;
    mem[28] = 8'h30;
    mem[29] = 8'hc0;
    mem[30] = 8'h07;
    mem[31] = 8'h01;
    mem[32] = 8'h80;
    mem[33] = 8'hff;
    mem[34] = 8'h03;
    mem[35] = 8'h10;
    mem[36] = 8'hc0;
    mem[37] = 8'h7f;
    mem[38] = 8'h00;
    mem[39] = 8'h01;
    mem[40] = 8'he0;
    mem[41] = 8'hc7;
    mem[42] = 8'h0f;
    mem[43] = 8'h10;
    mem[44] = 8'h80;
    mem[45] = 8'h0d;
    mem[46] = 8'h00;
    mem[47] = 8'h01;
    mem[48] = 8'hf0;
    mem[49] = 8'h00;
    mem[50] = 8'h1e;
    mem[51] = 8'h18;
    mem[52] = 8'hf8;
    mem[53] = 8'h7f;
    mem[54] = 8'h00;
    mem[55] = 8'h01;
    mem[56] = 8'h38;
    mem[57] = 8'h00;
    mem[58] = 8'h38;
    mem[59] = 8'ha6;
    mem[60] = 8'h07;
    mem[61] = 8'hc0;
    mem[62] = 8'h81;
    mem[63] = 8'h00;
    mem[64] = 8'h1c;
    mem[65] = 8'h00;
    mem[66] = 8'hb0;
    mem[67] = 8'he1;
    mem[68] = 8'h00;
    mem[69] = 8'h00;
    mem[70] = 8'h83;
    mem[71] = 8'h00;
    mem[72] = 8'hfc;
    mem[73] = 8'h7f;
    mem[74] = 8'ha0;
    mem[75] = 8'h1b;
    mem[76] = 8'h00;
    mem[77] = 8'h00;
    mem[78] = 8'hcc;
    mem[79] = 8'h00;
    mem[80] = 8'hfe;
    mem[81] = 8'h7f;
    mem[82] = 8'h60;
    mem[83] = 8'h0e;
    mem[84] = 8'h00;
    mem[85] = 8'h00;
    mem[86] = 8'hd8;
    mem[87] = 8'h01;
    mem[88] = 8'hfe;
    mem[89] = 8'h7f;
    mem[90] = 8'hc0;
    mem[91] = 8'h06;
    mem[92] = 8'h00;
    mem[93] = 8'h00;
    mem[94] = 8'h70;
    mem[95] = 8'h02;
    mem[96] = 8'h00;
    mem[97] = 8'h07;
    mem[98] = 8'hc0;
    mem[99] = 8'h02;
    mem[100] = 8'h00;
    mem[101] = 8'h00;
    mem[102] = 8'h20;
    mem[103] = 8'h04;
    mem[104] = 8'h03;
    mem[105] = 8'h07;
    mem[106] = 8'h00;
    mem[107] = 8'h03;
    mem[108] = 8'h00;
    mem[109] = 8'h00;
    mem[110] = 8'h40;
    mem[111] = 8'h0c;
    mem[112] = 8'h03;
    mem[113] = 8'h07;
    mem[114] = 8'h80;
    mem[115] = 8'h01;
    mem[116] = 8'h08;
    mem[117] = 8'h00;
    mem[118] = 8'h40;
    mem[119] = 8'h03;
    mem[120] = 8'h03;
    mem[121] = 8'hff;
    mem[122] = 8'h9f;
    mem[123] = 8'h21;
    mem[124] = 8'h09;
    mem[125] = 8'h09;
    mem[126] = 8'h80;
    mem[127] = 8'h01;
    mem[128] = 8'h03;
    mem[129] = 8'hff;
    mem[130] = 8'h9f;
    mem[131] = 8'h91;
    mem[132] = 8'h8d;
    mem[133] = 8'h9b;
    mem[134] = 8'h80;
    mem[135] = 8'h01;
    mem[136] = 8'h03;
    mem[137] = 8'hff;
    mem[138] = 8'hdf;
    mem[139] = 8'h90;
    mem[140] = 8'hcf;
    mem[141] = 8'hba;
    mem[142] = 8'h00;
    mem[143] = 8'h01;
    mem[144] = 8'h03;
    mem[145] = 8'hc7;
    mem[146] = 8'h41;
    mem[147] = 8'hf8;
    mem[148] = 8'h2b;
    mem[149] = 8'hee;
    mem[150] = 8'h09;
    mem[151] = 8'h01;
    mem[152] = 8'h07;
    mem[153] = 8'hc7;
    mem[154] = 8'h61;
    mem[155] = 8'h78;
    mem[156] = 8'h39;
    mem[157] = 8'h82;
    mem[158] = 8'h0b;
    mem[159] = 8'h03;
    mem[160] = 8'h06;
    mem[161] = 8'hc7;
    mem[162] = 8'h21;
    mem[163] = 8'h3e;
    mem[164] = 8'h19;
    mem[165] = 8'h00;
    mem[166] = 8'h13;
    mem[167] = 8'h02;
    mem[168] = 8'h0e;
    mem[169] = 8'hc0;
    mem[170] = 8'he1;
    mem[171] = 8'h27;
    mem[172] = 8'h10;
    mem[173] = 8'h00;
    mem[174] = 8'h17;
    mem[175] = 8'h02;
    mem[176] = 8'h0c;
    mem[177] = 8'hc0;
    mem[178] = 8'he1;
    mem[179] = 8'h27;
    mem[180] = 8'h00;
    mem[181] = 8'h10;
    mem[182] = 8'h1e;
    mem[183] = 8'h02;
    mem[184] = 8'h1c;
    mem[185] = 8'hc0;
    mem[186] = 8'hc1;
    mem[187] = 8'h24;
    mem[188] = 8'h00;
    mem[189] = 8'h10;
    mem[190] = 8'h1a;
    mem[191] = 8'h02;
    mem[192] = 8'h38;
    mem[193] = 8'hc0;
    mem[194] = 8'h99;
    mem[195] = 8'h26;
    mem[196] = 8'h00;
    mem[197] = 8'h10;
    mem[198] = 8'h12;
    mem[199] = 8'h02;
    mem[200] = 8'hf0;
    mem[201] = 8'hc0;
    mem[202] = 8'h9d;
    mem[203] = 8'h26;
    mem[204] = 8'h00;
    mem[205] = 8'h10;
    mem[206] = 8'h02;
    mem[207] = 8'h06;
    mem[208] = 8'he0;
    mem[209] = 8'hc7;
    mem[210] = 8'hcd;
    mem[211] = 8'h22;
    mem[212] = 8'h00;
    mem[213] = 8'h10;
    mem[214] = 8'h02;
    mem[215] = 8'h04;
    mem[216] = 8'h80;
    mem[217] = 8'hff;
    mem[218] = 8'h41;
    mem[219] = 8'h23;
    mem[220] = 8'h00;
    mem[221] = 8'h10;
    mem[222] = 8'h03;
    mem[223] = 8'h0c;
    mem[224] = 8'h00;
    mem[225] = 8'h7c;
    mem[226] = 8'h40;
    mem[227] = 8'h21;
    mem[228] = 8'h00;
    mem[229] = 8'h10;
    mem[230] = 8'h01;
    mem[231] = 8'h08;
    mem[232] = 8'h00;
    mem[233] = 8'h00;
    mem[234] = 8'hc0;
    mem[235] = 8'h21;
    mem[236] = 8'h00;
    mem[237] = 8'h10;
    mem[238] = 8'h01;
    mem[239] = 8'h08;
    mem[240] = 8'h00;
    mem[241] = 8'h00;
    mem[242] = 8'hc0;
    mem[243] = 8'h03;
    mem[244] = 8'h00;
    mem[245] = 8'h10;
    mem[246] = 8'h41;
    mem[247] = 8'h0a;
    mem[248] = 8'h00;
    mem[249] = 8'h00;
    mem[250] = 8'h60;
    mem[251] = 8'h06;
    mem[252] = 8'h00;
    mem[253] = 8'h00;
    mem[254] = 8'h41;
    mem[255] = 8'h0e;
    mem[256] = 8'h00;
    mem[257] = 8'h00;
    mem[258] = 8'h20;
    mem[259] = 8'h0e;
    mem[260] = 8'h1e;
    mem[261] = 8'h00;
    mem[262] = 8'h41;
    mem[263] = 8'h1c;
    mem[264] = 8'h00;
    mem[265] = 8'h00;
    mem[266] = 8'he0;
    mem[267] = 8'h1a;
    mem[268] = 8'he2;
    mem[269] = 8'h07;
    mem[270] = 8'h5f;
    mem[271] = 8'h3c;
    mem[272] = 8'h00;
    mem[273] = 8'h00;
    mem[274] = 8'hc0;
    mem[275] = 8'h7b;
    mem[276] = 8'h02;
    mem[277] = 8'h04;
    mem[278] = 8'h5f;
    mem[279] = 8'h1d;
    mem[280] = 8'h00;
    mem[281] = 8'h7c;
    mem[282] = 8'hc0;
    mem[283] = 8'hff;
    mem[284] = 8'h07;
    mem[285] = 8'h84;
    mem[286] = 8'h7f;
    mem[287] = 8'h0f;
    mem[288] = 8'h80;
    mem[289] = 8'hff;
    mem[290] = 8'h83;
    mem[291] = 8'hff;
    mem[292] = 8'h0f;
    mem[293] = 8'hf2;
    mem[294] = 8'hff;
    mem[295] = 8'h0f;
    mem[296] = 8'he0;
    mem[297] = 8'hc7;
    mem[298] = 8'h0f;
    mem[299] = 8'h03;
    mem[300] = 8'hfe;
    mem[301] = 8'h3f;
    mem[302] = 8'hfb;
    mem[303] = 8'h06;
    mem[304] = 8'hf0;
    mem[305] = 8'h00;
    mem[306] = 8'h1e;
    mem[307] = 8'h06;
    mem[308] = 8'hf4;
    mem[309] = 8'hff;
    mem[310] = 8'h03;
    mem[311] = 8'h03;
    mem[312] = 8'h38;
    mem[313] = 8'h00;
    mem[314] = 8'h38;
    mem[315] = 8'h0c;
    mem[316] = 8'h78;
    mem[317] = 8'hfb;
    mem[318] = 8'h80;
    mem[319] = 8'h01;
    mem[320] = 8'h1c;
    mem[321] = 8'h00;
    mem[322] = 8'h70;
    mem[323] = 8'h78;
    mem[324] = 8'hf8;
    mem[325] = 8'hef;
    mem[326] = 8'hf0;
    mem[327] = 8'h00;
    mem[328] = 8'h0c;
    mem[329] = 8'hfc;
    mem[330] = 8'h60;
    mem[331] = 8'hc0;
    mem[332] = 8'hbf;
    mem[333] = 8'hea;
    mem[334] = 8'h1f;
    mem[335] = 8'h00;
    mem[336] = 8'h0e;
    mem[337] = 8'hfe;
    mem[338] = 8'he1;
    mem[339] = 8'h00;
    mem[340] = 8'h2e;
    mem[341] = 8'he7;
    mem[342] = 8'h03;
    mem[343] = 8'h00;
    mem[344] = 8'h06;
    mem[345] = 8'hcf;
    mem[346] = 8'hc3;
    mem[347] = 8'h00;
    mem[348] = 8'h3e;
    mem[349] = 8'h60;
    mem[350] = 8'h03;
    mem[351] = 8'h00;
    mem[352] = 8'h07;
    mem[353] = 8'h87;
    mem[354] = 8'h03;
    mem[355] = 8'h1e;
    mem[356] = 8'h1c;
    mem[357] = 8'he0;
    mem[358] = 8'he1;
    mem[359] = 8'h01;
    mem[360] = 8'h03;
    mem[361] = 8'h87;
    mem[362] = 8'hc3;
    mem[363] = 8'h73;
    mem[364] = 8'h16;
    mem[365] = 8'he0;
    mem[366] = 8'h39;
    mem[367] = 8'h0f;
    mem[368] = 8'h03;
    mem[369] = 8'h87;
    mem[370] = 8'h7b;
    mem[371] = 8'hc0;
    mem[372] = 8'h1b;
    mem[373] = 8'h40;
    mem[374] = 8'h0f;
    mem[375] = 8'hf8;
    mem[376] = 8'h03;
    mem[377] = 8'hcf;
    mem[378] = 8'h1d;
    mem[379] = 8'h00;
    mem[380] = 8'h0b;
    mem[381] = 8'h40;
    mem[382] = 8'h03;
    mem[383] = 8'he0;
    mem[384] = 8'h03;
    mem[385] = 8'hfe;
    mem[386] = 8'h73;
    mem[387] = 8'h00;
    mem[388] = 8'h0b;
    mem[389] = 8'h40;
    mem[390] = 8'h06;
    mem[391] = 8'h38;
    mem[392] = 8'h03;
    mem[393] = 8'hfc;
    mem[394] = 8'hc3;
    mem[395] = 8'h81;
    mem[396] = 8'h0d;
    mem[397] = 8'hc0;
    mem[398] = 8'h06;
    mem[399] = 8'h0e;
    mem[400] = 8'h03;
    mem[401] = 8'hc0;
    mem[402] = 8'h03;
    mem[403] = 8'he7;
    mem[404] = 8'h07;
    mem[405] = 8'h80;
    mem[406] = 8'h9e;
    mem[407] = 8'h03;
    mem[408] = 8'h07;
    mem[409] = 8'he0;
    mem[410] = 8'h41;
    mem[411] = 8'hbc;
    mem[412] = 8'h07;
    mem[413] = 8'h80;
    mem[414] = 8'hf7;
    mem[415] = 8'h00;
    mem[416] = 8'h06;
    mem[417] = 8'hfe;
    mem[418] = 8'hc1;
    mem[419] = 8'h00;
    mem[420] = 8'h04;
    mem[421] = 8'h80;
    mem[422] = 8'h07;
    mem[423] = 8'h00;
    mem[424] = 8'h0e;
    mem[425] = 8'hfe;
    mem[426] = 8'he0;
    mem[427] = 8'h00;
    mem[428] = 8'h06;
    mem[429] = 8'h80;
    mem[430] = 8'h00;
    mem[431] = 8'h00;
    mem[432] = 8'h0c;
    mem[433] = 8'h3e;
    mem[434] = 8'h60;
    mem[435] = 8'h00;
    mem[436] = 8'h02;
    mem[437] = 8'h80;
    mem[438] = 8'h01;
    mem[439] = 8'h00;
    mem[440] = 8'h1c;
    mem[441] = 8'h00;
    mem[442] = 8'h70;
    mem[443] = 8'hf8;
    mem[444] = 8'h03;
    mem[445] = 8'h00;
    mem[446] = 8'h7f;
    mem[447] = 8'h00;
    mem[448] = 8'h38;
    mem[449] = 8'h00;
    mem[450] = 8'h38;
    mem[451] = 8'h06;
    mem[452] = 8'h13;
    mem[453] = 8'h11;
    mem[454] = 8'h81;
    mem[455] = 8'h01;
    mem[456] = 8'hf0;
    mem[457] = 8'h00;
    mem[458] = 8'h1e;
    mem[459] = 8'h01;
    mem[460] = 8'h17;
    mem[461] = 8'h11;
    mem[462] = 8'h01;
    mem[463] = 8'h02;
    mem[464] = 8'he0;
    mem[465] = 8'hc7;
    mem[466] = 8'h8f;
    mem[467] = 8'h80;
    mem[468] = 8'had;
    mem[469] = 8'haa;
    mem[470] = 8'h03;
    mem[471] = 8'h04;
    mem[472] = 8'h80;
    mem[473] = 8'hff;
    mem[474] = 8'h43;
    mem[475] = 8'h80;
    mem[476] = 8'h49;
    mem[477] = 8'h4c;
    mem[478] = 8'h07;
    mem[479] = 8'h08;
    mem[480] = 8'h00;
    mem[481] = 8'h7c;
    mem[482] = 8'h20;
    mem[483] = 8'hc0;
    mem[484] = 8'hff;
    mem[485] = 8'hff;
    mem[486] = 8'h0f;
    mem[487] = 8'h10;
    mem[488] = 8'h00;
    mem[489] = 8'h00;
    mem[490] = 8'h10;
    mem[491] = 8'h20;
    mem[492] = 8'hff;
    mem[493] = 8'hff;
    mem[494] = 8'h19;
    mem[495] = 8'h20;
    mem[496] = 8'h00;
    mem[497] = 8'h00;
    mem[498] = 8'h08;
    mem[499] = 8'h1e;
    mem[500] = 8'h1b;
    mem[501] = 8'hd8;
    mem[502] = 8'hf0;
    mem[503] = 8'h41;
    mem[504] = 8'h00;
    mem[505] = 8'h00;
    mem[506] = 8'hfc;
    mem[507] = 8'h01;
    mem[508] = 8'h0e;
    mem[509] = 8'h70;
    mem[510] = 8'h00;
    mem[511] = 8'hfe;
  end

  wire [8:0] addr = {y[6:1], x[6:4]};
  assign pixel = mem[addr][x[3:1]];

endmodule

module palette (
    input  wire [2:0] color_index,
    output wire [5:0] rrggbb
);

  reg [5:0] palette[7:0];

  initial begin
    palette[0] = 6'b101011;
    palette[1] = 6'b010111;
    palette[2] = 6'b000111;
    palette[3] = 6'b011011;
    palette[4] = 6'b001011;
    palette[5] = 6'b001111;
    palette[6] = 6'b101111;
    palette[7] = 6'b111111;
  end

  assign rrggbb = palette[color_index];

endmodule

module tt_um_vga_example(
  input  wire [7:0] ui_in,    // Dedicated inputs
  output wire [7:0] uo_out,   // Dedicated outputs
  input  wire [7:0] uio_in,   // IOs: Input path
  output wire [7:0] uio_out,  // IOs: Output path
  output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
  input  wire       ena,      // always 1 when the design is powered, so you can ignore it
  input  wire       clk,      // clock
  input  wire       rst_n     // reset_n - low to reset
);

  // VGA signals
  wire hsync;
  wire vsync;
  reg [1:0] R;
  reg [1:0] G;
  reg [1:0] B;
  wire video_active;
  wire [9:0] pix_x;
  wire [9:0] pix_y;

  // Configuration
  wire cfg_tile = ui_in[0];
  wire cfg_solid_color = ui_in[1];

  // TinyVGA PMOD
  assign uo_out  = {hsync, B[0], G[0], R[0], vsync, B[1], G[1], R[1]};

  // Unused outputs assigned to 0.
  assign uio_out = 0;
  assign uio_oe  = 0;

  // Suppress unused signals warning
  wire _unused_ok = &{ena, ui_in[7:1], uio_in};

  reg [9:0] prev_y;

  hvsync_generator vga_sync_gen (
      .clk(clk),
      .reset(~rst_n),
      .hsync(hsync),
      .vsync(vsync),
      .display_on(video_active),
      .hpos(pix_x),
      .vpos(pix_y)
  );

  reg [9:0] logo_left;
  reg [9:0] logo_top;
  reg dir_x;
  reg dir_y;

  wire pixel_value;
  reg [2:0] color_index;
  wire [5:0] color;

  wire [9:0] x = pix_x - logo_left;
  wire [9:0] y = pix_y - logo_top;
  wire logo_pixels = cfg_tile || (x[9:7] == 0 && y[9:7] == 0);

  bitmap_rom rom1 (
      .x(x[6:0]),
      .y(y[6:0]),
      .pixel(pixel_value)
  );

  wire [2:0] solid_color_index = {color_index[0], color_index[1], color_index[2]};
  wire [2:0] gradient_color_index = {y[4:2] - x[4:2] + logo_left[4:2]};

  palette palette_inst (
      .color_index(cfg_solid_color ? solid_color_index : gradient_color_index),
      .rrggbb(color)
  );

  // RGB output logic
  always @(posedge clk) begin
    if (~rst_n) begin
      R <= 0;
      G <= 0;
      B <= 0;
    end else begin
      R <= 0;
      G <= 0;
      B <= 0;
      if (video_active && logo_pixels) begin
        R <= pixel_value ? color[5:4] : 0;
        G <= pixel_value ? color[3:2] : 0;
        B <= pixel_value ? color[1:0] : 0;
      end
    end
  end

  // Bouncing logic
  always @(posedge clk) begin
    if (~rst_n) begin
      logo_left <= 200;
      logo_top <= 200;
      dir_y <= 0;
      dir_x <= 1;
      color_index <= 0;
    end else begin
      prev_y <= pix_y;
      if (pix_y == 0 && prev_y != pix_y) begin
        logo_left <= logo_left + (dir_x ? 1 : -1);
        logo_top  <= logo_top + (dir_y ? 1 : -1);
        if (logo_left - 1 == 0 && !dir_x) begin
          dir_x <= 1;
          color_index <= color_index + 1;
        end
        if (logo_left + 1 == DISPLAY_WIDTH - LOGO_SIZE && dir_x) begin
          dir_x <= 0;
          color_index <= color_index + 1;
        end
        if (logo_top - 1 == 0 && !dir_y) begin
          dir_y <= 1;
          color_index <= color_index + 1;
        end
        if (logo_top + 1 == DISPLAY_HEIGHT - LOGO_SIZE && dir_y) begin
          dir_y <= 0;
          color_index <= color_index + 1;
        end
      end
    end
  end

endmodule
