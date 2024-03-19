module ras #(
    parameter DATA_WIDTH = 64,
    parameter DATA_DEPTH = 4
)(
    input  logic                  rst_ni,
    input  logic                  clk_i,
    input  logic                  bp_flush_i,
    input  logic                  ras_push_i,
    input  logic                  ras_pop_i,
    input  logic [DATA_WIDTH-1:0] ras_data_i,
    output logic                  ras_data_vld_o,
    output logic [DATA_WIDTH-1:0] ras_data_o
);

    logic [DATA_WIDTH-1:0] [DATA_DEPTH-1:0] data_d, data_q;
    logic [DATA_DEPTH-1:0] data_vld_d, data_vld_q;

    always_comb begin
        data_d = data_q;
        data_vld_d = data_vld_q;

        if(ras_push_i) begin
            data_d[0] = ras_data_i;
            data_vld_d[0] = 1'b1;
            data_d[DATA_DEPTH-1:1] = data_q[DATA_DEPTH-2:0];
        end

        if(ras_pop_i) begin
        end

        if(ras_push_i && ras_pop_i) begin
        end

    end

endmodule