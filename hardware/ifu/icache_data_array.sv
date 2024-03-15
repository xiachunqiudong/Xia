module icache_data_array
#(
  parameter ICACHE_DATA_WIDTH  = 256,
  parameter ICACHE_INTEX_WIDTH = 6
)
(
  input  logic                          clk_i,
  input  logic                          rst_i,
  input  logic [ICACHE_INTEX_WIDTH-1:0] icache_index_i,
  output logic [ICACHE_DATA_WIDTH-1:0]  icache_rdata_o,
  input  logic [ICACHE_DATA_WIDTH-1:0]  icache_wdata_i,
  input  logic                          icache_wen_i
);


  


endmodule