`timescale 1ns / 1ps

module evm_tb;

    reg clk;
    reg vote_enable;
    reg A, B, C;
    reg rst;
    wire [6:0] display;
    wire [3:0] an;
    wire ledA, ledB, ledC;
    
    evm_display_three_candidates dut (
        .clk(clk),
        .vote_enable(vote_enable),
        .A(A),
        .B(B),
        .C(C),
        .rst(rst),
        .display(display),
        .an(an),
        .ledA(ledA),
        .ledB(ledB),
        .ledC(ledC)
    );
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        rst = 0;
        vote_enable = 0;
        A = 0;
        B = 0;
        C = 0;
        
        rst = 1;
        #100;
        rst = 0;
        #100;
        
        vote_enable = 1;
        #100;
        
        repeat(5) begin
            A = 1;
            #100;
            A = 0;
            #700000;
        end
        
        repeat(3) begin
            B = 1;
            #100;
            B = 0;
            #700000;
        end
        
        C = 1;
        #100;
        C = 0;
        #700000;
        
        vote_enable = 0;
        #1000000;
        
        $display("Results:");
        $display("A: %0d | B: %0d | C: %0d", dut.votes[0], dut.votes[1], dut.votes[2]);
        $display("LEDs - A:%b B:%b C:%b", ledA, ledB, ledC);
        
        #1000;
        $finish;
    end

endmodule
