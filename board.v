module board(
	input [9:0] x, 
	input [9:0] y,
	input [9:0] cursor_x,
	input [9:0] cursor_y,
	input [17:0] square,
	output reg [9:0] red, 
	output reg [9:0] green, 
	output reg [9:0] blue);

reg [1:0] r;
reg [1:0] c;

reg [1:0] square2 [2:0] [2:0];

// Win detection
reg [5:0] CRD [7:0]; // [7:5]Column, [4:2]Row, [1:0]Diagonal;
reg [4:0] CRD_i;

always @(x, cursor_x, square) begin
	// Board
	if(y<480 && ((x>140 && x<160) || (x>300 && x<320))) begin
		red <= 10'h3ff;
		green <= 10'h3ff;
		blue <= 10'h3ff;
	end else if(x<480 && ((y>140 && y<160) || (y>300 && y<320))) begin
		red <= 10'h3ff;
		green <= 10'h3ff;
		blue <= 10'h3ff;
	end else if((x > (cursor_x - 10) && x < (cursor_x + 10)) && (y > (cursor_y - 10) && y < (cursor_y + 10))) begin
		red <= 10'h3ff;
		green <= 10'h3ff;
		blue <= 10'h3ff;
	end else begin
		red <= 10'h000;
		blue <= 10'h000;
		green <= 10'h000;
	end
	
	// Split into squares, square2[row][column]
	square2[0][0] <= square[17:16];
	square2[0][1] <= square[15:14];
	square2[0][2] <= square[13:12];
	square2[1][0] <= square[11:10];
	square2[1][1] <= square[9:8];
	square2[1][2] <= square[7:6];
	square2[2][0] <= square[5:4];
	square2[2][1] <= square[3:2];
	square2[2][2] <= square[1:0];
	
	// Check Win
	// Split Columns
	CRD[7][5:4] <= square2[0][0];
	CRD[7][3:2] <= square2[1][0];
	CRD[7][1:0] <= square2[2][0];

	CRD[6][5:4] <= square2[0][1];
	CRD[6][3:2] <= square2[1][1];
	CRD[6][1:0] <= square2[2][1];

	CRD[5][5:4] <= square2[0][2];
	CRD[5][3:2] <= square2[1][2];
	CRD[5][1:0] <= square2[2][2];

	// Split Rows
	CRD[4][5:4] <= square2[0][0];
	CRD[4][3:2] <= square2[0][1];
	CRD[4][1:0] <= square2[0][2];
	
	CRD[3][5:4] <= square2[1][0];
	CRD[3][3:2] <= square2[1][1];
	CRD[3][1:0] <= square2[1][2];
	
	CRD[2][5:4] <= square2[2][0];
	CRD[2][3:2] <= square2[2][1];
	CRD[2][1:0] <= square2[2][2];

	// Split Diagonals
	CRD[1][5:4] <= square2[0][0];
	CRD[1][3:2] <= square2[1][1];
	CRD[1][1:0] <= square2[2][2];

	CRD[0][5:4] <= square2[0][2];
	CRD[0][3:2] <= square2[1][1];
	CRD[0][1:0] <= square2[2][0];
	
	if(x > 480 && x < 560 && y > 70 && y < 100) begin
		for(CRD_i=0; CRD_i<=7; CRD_i = CRD_i+1) begin
			if(CRD[CRD_i] == 6'b010101) begin
				red <= 10'h3ff;
				green <= 10'h000;
				blue <= 10'h000;
			end else if(CRD[CRD_i] == 6'b101010) begin
				red <= 10'h000;
				green <= 10'h3ff;
				blue <= 10'h000;
			end
		end
	end
	

	// square
	for(r=0; r < 3; r=r+1) begin
		for(c=0; c < 3; c=c+1) begin
			if(x > (70+160*c - 50) && x < (70+160*c + 50) && y > (70+160*r - 50) && y < (70+160*r + 50)) begin
				if(!(x > (cursor_x - 10) && x < (cursor_x + 10) && y > (cursor_y - 10) && y < (cursor_y + 10))) begin
					if(square2[r][c] == 2'b01) begin 
						red <= 10'h3ff;
						green <= 10'h000;
						blue <= 10'h000;
					end else if(square2[r][c] == 2'b10)begin
						red <= 10'h000;
						green <= 10'h3ff;
						blue <= 10'h000;
					end
				end
			end
		end
	end
end




endmodule