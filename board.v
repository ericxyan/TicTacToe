module board(
	input [9:0] x, 
	input [9:0] y,
	input [9:0] cursor_x,
	input [9:0] cursor_y,
	input [8:0] square,
	output reg [9:0] red, 
	output reg [9:0] green, 
	output reg [9:0] blue);

reg [1:0] r;
reg [1:0] c;
reg [2:0] square2 [2:0];

always @(square) begin
square2[0][0] <= square[0];
square2[0][1] <= square[1];
square2[0][2] <= square[2];
square2[1][0] <= square[3];
square2[1][1] <= square[4];
square2[1][2] <= square[5];
square2[2][0] <= square[6];
square2[2][1] <= square[7];
square2[2][2] <= square[8];
end

always @(x, cursor_x) begin
	// Board

	if(y<480 && ((x>140 && x<160) || (x>300 && x<320))) begin
		red = 10'h3ff;
		green = 10'h3ff;
		blue = 10'h3ff;
	end else if(x<480 && ((y>140 && y<160) || (y>300 && y<320))) begin
		red = 10'h3ff;
		green = 10'h3ff;
		blue = 10'h3ff;
	end else if((x > (cursor_x - 10) && x < (cursor_x + 10)) && (y > (cursor_y - 10) && y < (cursor_y + 10))) begin
		red = 10'h3ff;
		green = 10'h3ff;
		blue = 10'h3ff;
	end else begin
		red = 10'h000;
		blue = 10'h000;
		green = 10'h000;
	end

	// square
	for(r=0; r < 3; r=r+1) begin
		for(c=0; c < 3; c=c+1) begin
			if(x > (70+160*c - 50) && x < (70+160*c + 50) && y > (70+160*r - 50) && y < (70+160*r + 50)) begin
					if(square2[r][c] == 1) begin
						red = 10'h3ff;
						green = 10'h000;
						blue = 10'h000;
					end
					if(square2[r][c] == 2)begin
						red = 10'h000;
						green = 10'h3ff;
						blue = 10'h000;
					end
			end
		end
	end
	
end


endmodule
