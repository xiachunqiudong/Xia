// SRAM Behavioral Model
module sram #(
  localparam DATA_WIDTH = 64,
  localparam NUM_WORDS  = 8,
  localparam ADDR_WIDTH = $clog2(NUM_WORDS)
)(
  input logic                   clk_i,
  input logic                   req_i,
  input logic                   we_i,
  input logic  [ADDR_WIDTH-1:0] addr_i,
  input logic  [DATA_WIDTH-1:0] wdata_i,
  input logic  [DATA_WIDTH-1:0] be_i,
  output logic [DATA_WIDTH-1:0] rdata_o
);

  logic [ADDR_WIDTH-1:0] addr_q;
  logic [DATA_WIDTH-1:0] ram [NUM_WORDS-1:0];

  assign rdata_o = ram[addr_q];

  always_ff @(posedge clk_i) begin
    if (req_i) begin
      if (we_i) begin // Write
        for (int i = 0; i < DATA_WIDTH; i = i + 1) begin
          if (be_i[i]) begin
            ram[addr_i][i] <= wdata_i[i];
          end
        end
      end
      else begin // Read
        addr_q <= addr_i;
      end
    end
  end

endmodule