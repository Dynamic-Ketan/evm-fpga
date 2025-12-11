`timescale 1ns / 1ps

module evm_display_three_candidates(
    input clk,
    input vote_enable,
    input A,
    input B,
    input C,
    input rst,
    output reg [6:0] display,
    output reg [3:0] an,
    output reg ledA,
    output reg ledB,
    output reg ledC
);

    reg [3:0] votes [0:2];
    reg show_results = 0;
    reg btn_last [0:3];
    reg [15:0] debounce_counter = 0;

    // Voting logic with debouncing
    always @(posedge clk) begin
        if (rst == 1) begin
            votes[0] <= 0;
            votes[1] <= 0;
            votes[2] <= 0;
            show_results <= 0;
        end else if (vote_enable) begin
            if (A && !btn_last[0] && debounce_counter == 0 && votes[0] < 9) begin
                votes[0] <= votes[0] + 1;
                debounce_counter <= 16'hFFFF;
            end
            if (B && !btn_last[1] && debounce_counter == 0 && votes[1] < 9) begin
                votes[1] <= votes[1] + 1;
                debounce_counter <= 16'hFFFF;
            end
            if (C && !btn_last[2] && debounce_counter == 0 && votes[2] < 9) begin
                votes[2] <= votes[2] + 1;
                debounce_counter <= 16'hFFFF;
            end
        end

        if (!vote_enable && !show_results) begin
            show_results <= 1;
        end

        btn_last[0] <= A;
        btn_last[1] <= B;
        btn_last[2] <= C;

        if (debounce_counter > 0) debounce_counter <= debounce_counter - 1;
    end

    // 7-segment multiplexing
    reg [15:0] refresh_counter = 0;
    always @(posedge clk) begin
        refresh_counter <= refresh_counter + 1;

        if (show_results) begin
            case (refresh_counter[15:14])
                2'b00: begin
                    display <= seven_seg(votes[0]);
                    an <= 4'b1011;
                end
                2'b01: begin
                    display <= seven_seg(votes[1]);
                    an <= 4'b1101;
                end
                2'b10: begin
                    display <= seven_seg(votes[2]);
                    an <= 4'b1110;
                end
                default: begin
                    display <= 7'b1111111;
                    an <= 4'b1111;
                end
            endcase
        end else begin
            display <= 7'b1111111;
            an <= 4'b1111;
        end
    end

    // Winner detection
    always @(posedge clk) begin
        if (show_results) begin
            if (votes[0] > votes[1] && votes[0] > votes[2]) begin
                ledA <= 1;
                ledB <= 0;
                ledC <= 0;
            end
            else if (votes[1] > votes[0] && votes[1] > votes[2]) begin
                ledA <= 0;
                ledB <= 1;
                ledC <= 0;
            end
            else if (votes[2] > votes[0] && votes[2] > votes[1]) begin
                ledA <= 0;
                ledB <= 0;
                ledC <= 1;
            end
            else begin
                ledA <= 0;
                ledB <= 0;
                ledC <= 0;
            end
        end else begin
            ledA <= 0;
            ledB <= 0;
            ledC <= 0;
        end
    end

    function [6:0] seven_seg;
        input [3:0] digit;
        begin
            case (digit)
                4'd0: seven_seg = 7'b0000001;
                4'd1: seven_seg = 7'b1001111;
                4'd2: seven_seg = 7'b0010010;
                4'd3: seven_seg = 7'b0000110;
                4'd4: seven_seg = 7'b1001100;
                4'd5: seven_seg = 7'b0100100;
                4'd6: seven_seg = 7'b0100000;
                4'd7: seven_seg = 7'b0001111;
                4'd8: seven_seg = 7'b0000000;
                4'd9: seven_seg = 7'b0000100;
                default: seven_seg = 7'b1111111;
            endcase
        end
    endfunction

endmodule
