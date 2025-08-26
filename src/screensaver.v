/*
 * Copyright (c) 2024 Tiny Tapeout LTD
 * SPDX-License-Identifier: Apache-2.0
 * Author: Uri Shaked
 */

`default_nettype none

parameter LOGO_SIZE = 128;  // Size of the logo in pixels
parameter DISPLAY_WIDTH = 640;  // VGA display width
parameter DISPLAY_HEIGHT = 480;  // VGA display height

`define COLOR_WHITE 3'd7

module tt_um_rebeccargb_tt09ball_screensaver (
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

  // Tiny VGA Pmod
  assign uo_out = {hsync, B[0], G[0], R[0], vsync, B[1], G[1], R[1]};

  // Gamepad Pmod
  wire gamepad_start, gamepad_up, gamepad_down, gamepad_left, gamepad_right;
  reg gamepad_start_prev;

  /* verilator lint_off PINMISSING */
  gamepad_pmod_single gamepad (
      // Inputs:
      .rst_n(rst_n),
      .clk(clk),
      .pmod_data(ui_in[6]),
      .pmod_clk(ui_in[5]),
      .pmod_latch(ui_in[4]),

      // Outputs:
      .start(gamepad_start),
      .up(gamepad_up),
      .down(gamepad_down),
      .left(gamepad_left),
      .right(gamepad_right)
  );
  /* verilator lint_on PINMISSING */

  // Unused outputs assigned to 0.
  assign uio_out = 0;
  assign uio_oe  = 0;

  // Suppress unused signals warning
  wire _unused = &{ena, ui_in[7:1], uio_in, 1'b0};

  reg [9:0] prev_y;

  vga_sync_generator vga_sync_gen (
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
  reg manual_mode;

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


  always @(posedge clk) begin
    if (~rst_n) begin
      logo_left <= 200;
      logo_top <= 200;
      dir_y <= 0;
      dir_x <= 1;
      color_index <= 0;
      gamepad_start_prev <= 0;
      manual_mode <= 0;
      prev_y <= 0;
    end else begin
      // Bouncing logic
      prev_y <= pix_y;
      if (pix_y == 0 && prev_y != pix_y) begin
        if (manual_mode) begin
          logo_manual_control();
        end else begin
          bounce_logo();
        end
        if (gamepad_start & ~gamepad_start_prev) begin
          manual_mode <= ~manual_mode;
        end
        gamepad_start_prev <= gamepad_start;
      end
    end
  end


  task logo_manual_control;
    if (gamepad_left && logo_left > 0) begin
      logo_left <= logo_left - 1;
    end
    if (gamepad_right && logo_left + 1 < DISPLAY_WIDTH - LOGO_SIZE) begin
      logo_left <= logo_left + 1;
    end
    if (gamepad_up && logo_top > 0) begin
      logo_top <= logo_top - 1;
    end
    if (gamepad_down && logo_top + 1 < DISPLAY_HEIGHT - LOGO_SIZE) begin
      logo_top <= logo_top + 1;
    end
  endtask


  task bounce_logo;
    logo_left <= logo_left + (dir_x ? 1 : -1);
    logo_top  <= logo_top + (dir_y ? 1 : -1);

    if (gamepad_left) begin
      dir_x <= 0;
    end else if (gamepad_right) begin
      dir_x <= 1;
    end

    if (gamepad_up) begin
      dir_y <= 0;
    end else if (gamepad_down) begin
      dir_y <= 1;
    end

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
  endtask

endmodule
