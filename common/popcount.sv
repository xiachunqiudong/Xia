module popcount #(
    parameter int unsigned INPUT_WIDTH = 256,
    localparam int unsigned PopcountWidth = $clog2(INPUT_WIDTH)+1
) (
    input logic [INPUT_WIDTH-1:0]     data_i,
    output logic [PopcountWidth-1:0] popcount_o
);

   localparam int unsigned PaddedWidth = 1 << $clog2(INPUT_WIDTH);

   logic [PaddedWidth-1:0]           padded_input;
   logic [PopcountWidth-2:0]         left_child_result, right_child_result;

   //Zero pad the input to next power of two
   always_comb begin
     padded_input = '0;
     padded_input[INPUT_WIDTH-1:0] = data_i;
   end

   //Recursive instantiation to build binary adder tree
   if (INPUT_WIDTH == 1) begin : single_node
     assign left_child_result  = 1'b0;
     assign right_child_result = padded_input[0];
   end else if (INPUT_WIDTH == 2) begin : leaf_node
     assign left_child_result  = padded_input[1];
     assign right_child_result = padded_input[0];
   end else begin : non_leaf_node
     popcount #(.INPUT_WIDTH(PaddedWidth / 2))
         left_child(
                    .data_i(padded_input[PaddedWidth-1:PaddedWidth/2]),
                    .popcount_o(left_child_result));

     popcount #(.INPUT_WIDTH(PaddedWidth / 2))
         right_child(
                     .data_i(padded_input[PaddedWidth/2-1:0]),
                     .popcount_o(right_child_result));
   end

   //Output assignment
   assign popcount_o = left_child_result + right_child_result;

endmodule : popcount
