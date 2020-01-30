`default_nettype none

module fsqrt(
  input wire [31:0] x,
  output wire [31:0] y);

  wire s;
  wire [7:0] e;
  wire [22:0] m;

  assign {s,e,m} = x;

  wire [24:0] ma;
  assign ma =  (|e && ~e[0:0]) ? {2'b1,m} :
                (|e && e[0:0]) ? {1'b1,m,1'b0} :
                (m[22]) ? {1'b0,m,1'b0} :
                (m[21] || m[20]) ? {m[21:0],3'b0} :
                (m[19] || m[18]) ? {m[19:0],5'b0} : 
                (m[17] || m[16]) ? {m[17:0],7'b0} : 
                (m[15] || m[14]) ? {m[15:0],9'b0} : 
                (m[13] || m[12]) ? {m[13:0],11'b0} : 
                (m[11] || m[10]) ? {m[11:0],13'b0} : 
                (m[9] || m[8]) ? {m[9:0],15'b0} : 
                (m[7] || m[6]) ? {m[7:0],17'b0} : 
                (m[5] || m[4]) ? {m[5:0],19'b0} : 
                (m[3] || m[2]) ? {m[3:0],21'b0} : {m[1:0],23'b0};

  wire [7:0] ea;
  assign ea = (|e) ? {1'b0,e[7:1]} + 64 :
               (m[22]) ? 8'd64 :
               (m[21] || m[20]) ? 63 :
               (m[19] || m[18]) ? 62 : 
               (m[17] || m[16]) ? 61 : 
               (m[15] || m[14]) ? 60 : 
               (m[13] || m[12]) ? 59 : 
               (m[11] || m[10]) ? 58 : 
               (m[9] || m[8]) ? 57 : 
               (m[7] || m[6]) ? 56 : 
               (m[5] || m[4]) ? 55 : 
               (m[3] || m[2]) ? 54 : 53;

  wire [27:0] init;
  assign init = (ma[24:17] == 8'b1000000) ? {1'b0,27'b101101000101000011111100000} :
                  (ma[24:17] == 8'b1000001) ? {1'b0,27'b101100101110111101000001010} :
                  (ma[24:17] == 8'b1000010) ? {1'b0,27'b101100011001010110001001000} :
                  (ma[24:17] == 8'b1000011) ? {1'b0,27'b101100000100001110000110110} :
                  (ma[24:17] == 8'b1000100) ? {1'b0,27'b101011101111100011110010010} :
                  (ma[24:17] == 8'b1000101) ? {1'b0,27'b101011011011010110000111000} :
                  (ma[24:17] == 8'b1000110) ? {1'b0,27'b101011000111100100000011101} :
                  (ma[24:17] == 8'b1000111) ? {1'b0,27'b101010110100001100101010010} :
                  (ma[24:17] == 8'b1001000) ? {1'b0,27'b101010100001001110111111101} :
                  (ma[24:17] == 8'b1001001) ? {1'b0,27'b101010001110101010001011101} :
                  (ma[24:17] == 8'b1001010) ? {1'b0,27'b101001111100011101011000101} :
                  (ma[24:17] == 8'b1001011) ? {1'b0,27'b101001101010100111110011110} :
                  (ma[24:17] == 8'b1001100) ? {1'b0,27'b101001011001001000101100001} :
                  (ma[24:17] == 8'b1001101) ? {1'b0,27'b101001000111111111010011010} :
                  (ma[24:17] == 8'b1001110) ? {1'b0,27'b101000110111001010111100110} :
                  (ma[24:17] == 8'b1001111) ? {1'b0,27'b101000100110101010111110001} :
                  (ma[24:17] == 8'b1010000) ? {1'b0,27'b101000010110011110101110110} :
                  (ma[24:17] == 8'b1010001) ? {1'b0,27'b101000000110100101100111110} :
                  (ma[24:17] == 8'b1010010) ? {1'b0,27'b100111110110111111000011111} :
                  (ma[24:17] == 8'b1010011) ? {1'b0,27'b100111100111101010011111100} :
                  (ma[24:17] == 8'b1010100) ? {1'b0,27'b100111011000100111011000100} :
                  (ma[24:17] == 8'b1010101) ? {1'b0,27'b100111001001110101001110001} :
                  (ma[24:17] == 8'b1010110) ? {1'b0,27'b100110111011010011100000111} :
                  (ma[24:17] == 8'b1010111) ? {1'b0,27'b100110101101000001110010100} :
                  (ma[24:17] == 8'b1011000) ? {1'b0,27'b100110011110111111100110001} :
                  (ma[24:17] == 8'b1011001) ? {1'b0,27'b100110010001001100011111111} :
                  (ma[24:17] == 8'b1011010) ? {1'b0,27'b100110000011101000000101001} :
                  (ma[24:17] == 8'b1011011) ? {1'b0,27'b100101110110010001111011111} :
                  (ma[24:17] == 8'b1011100) ? {1'b0,27'b100101101001001001101011100} :
                  (ma[24:17] == 8'b1011101) ? {1'b0,27'b100101011100001110111100010} :
                  (ma[24:17] == 8'b1011110) ? {1'b0,27'b100101001111100001010111001} :
                  (ma[24:17] == 8'b1011111) ? {1'b0,27'b100101000011000000100101111} :
                  (ma[24:17] == 8'b1100000) ? {1'b0,27'b100100110110101100010011011} :
                  (ma[24:17] == 8'b1100001) ? {1'b0,27'b100100101010100100001011001} :
                  (ma[24:17] == 8'b1100010) ? {1'b0,27'b100100011110100111111001001} :
                  (ma[24:17] == 8'b1100011) ? {1'b0,27'b100100010010110111001010011} :
                  (ma[24:17] == 8'b1100100) ? {1'b0,27'b100100000111010001101100100} :
                  (ma[24:17] == 8'b1100101) ? {1'b0,27'b100011111011110111001101110} :
                  (ma[24:17] == 8'b1100110) ? {1'b0,27'b100011110000100111011100101} :
                  (ma[24:17] == 8'b1100111) ? {1'b0,27'b100011100101100010001000111} :
                  (ma[24:17] == 8'b1101000) ? {1'b0,27'b100011011010100111000010011} :
                  (ma[24:17] == 8'b1101001) ? {1'b0,27'b100011001111110101111001011} :
                  (ma[24:17] == 8'b1101010) ? {1'b0,27'b100011000101001110011111001} :
                  (ma[24:17] == 8'b1101011) ? {1'b0,27'b100010111010110000100101000} :
                  (ma[24:17] == 8'b1101100) ? {1'b0,27'b100010110000011011111101000} :
                  (ma[24:17] == 8'b1101101) ? {1'b0,27'b100010100110010000011001100} :
                  (ma[24:17] == 8'b1101110) ? {1'b0,27'b100010011100001101101101011} :
                  (ma[24:17] == 8'b1101111) ? {1'b0,27'b100010010010010011101011110} :
                  (ma[24:17] == 8'b1110000) ? {1'b0,27'b100010001000100010001000100} :
                  (ma[24:17] == 8'b1110001) ? {1'b0,27'b100001111110111000110111011} :
                  (ma[24:17] == 8'b1110010) ? {1'b0,27'b100001110101010111101101000} :
                  (ma[24:17] == 8'b1110011) ? {1'b0,27'b100001101011111110011110001} :
                  (ma[24:17] == 8'b1110100) ? {1'b0,27'b100001100010101100111111101} :
                  (ma[24:17] == 8'b1110101) ? {1'b0,27'b100001011001100011000111001} :
                  (ma[24:17] == 8'b1110110) ? {1'b0,27'b100001010000100000101010010} :
                  (ma[24:17] == 8'b1110111) ? {1'b0,27'b100001000111100101011111000} :
                  (ma[24:17] == 8'b1111000) ? {1'b0,27'b100000111110110001011011111} :
                  (ma[24:17] == 8'b1111001) ? {1'b0,27'b100000110110000100010111010} :
                  (ma[24:17] == 8'b1111010) ? {1'b0,27'b100000101101011110001000000} :
                  (ma[24:17] == 8'b1111011) ? {1'b0,27'b100000100100111110100101100} :
                  (ma[24:17] == 8'b1111100) ? {1'b0,27'b100000011100100101100110111} :
                  (ma[24:17] == 8'b1111101) ? {1'b0,27'b100000010100010011000011110} :
                  (ma[24:17] == 8'b1111110) ? {1'b0,27'b100000001100000110110100010} :
                  (ma[24:17] == 8'b1111111) ? {1'b0,27'b100000000100000000110000001} :
                  (ma[24:17] == 8'b10000000) ? {1'b0,27'b11111111100000000101111110} :
                  (ma[24:17] == 8'b10000001) ? {1'b0,27'b11111110100000110101011110} :
                  (ma[24:17] == 8'b10000010) ? {1'b0,27'b11111101100010010011100110} :
                  (ma[24:17] == 8'b10000011) ? {1'b0,27'b11111100100100011111011101} :
                  (ma[24:17] == 8'b10000100) ? {1'b0,27'b11111011100111011000001011} :
                  (ma[24:17] == 8'b10000101) ? {1'b0,27'b11111010101010111100111100} :
                  (ma[24:17] == 8'b10000110) ? {1'b0,27'b11111001101111001100111010} :
                  (ma[24:17] == 8'b10000111) ? {1'b0,27'b11111000110100000111010010} :
                  (ma[24:17] == 8'b10001000) ? {1'b0,27'b11110111111001101011010011} :
                  (ma[24:17] == 8'b10001001) ? {1'b0,27'b11110110111111111000001100} :
                  (ma[24:17] == 8'b10001010) ? {1'b0,27'b11110110000110101101001101} :
                  (ma[24:17] == 8'b10001011) ? {1'b0,27'b11110101001110001001101001} :
                  (ma[24:17] == 8'b10001100) ? {1'b0,27'b11110100010110001100110011} :
                  (ma[24:17] == 8'b10001101) ? {1'b0,27'b11110011011110110101111110} :
                  (ma[24:17] == 8'b10001110) ? {1'b0,27'b11110010101000000100100000} :
                  (ma[24:17] == 8'b10001111) ? {1'b0,27'b11110001110001110111101111} :
                  (ma[24:17] == 8'b10010000) ? {1'b0,27'b11110000111100001111000011} :
                  (ma[24:17] == 8'b10010001) ? {1'b0,27'b11110000000111001001110100} :
                  (ma[24:17] == 8'b10010010) ? {1'b0,27'b11101111010010100111011011} :
                  (ma[24:17] == 8'b10010011) ? {1'b0,27'b11101110011110100111010001} :
                  (ma[24:17] == 8'b10010100) ? {1'b0,27'b11101101101011001000110011} :
                  (ma[24:17] == 8'b10010101) ? {1'b0,27'b11101100111000001011011100} :
                  (ma[24:17] == 8'b10010110) ? {1'b0,27'b11101100000101101110101001} :
                  (ma[24:17] == 8'b10010111) ? {1'b0,27'b11101011010011110001111000} :
                  (ma[24:17] == 8'b10011000) ? {1'b0,27'b11101010100010010100100101} :
                  (ma[24:17] == 8'b10011001) ? {1'b0,27'b11101001110001010110010010} :
                  (ma[24:17] == 8'b10011010) ? {1'b0,27'b11101001000000110110011110} :
                  (ma[24:17] == 8'b10011011) ? {1'b0,27'b11101000010000110100101000} :
                  (ma[24:17] == 8'b10011100) ? {1'b0,27'b11100111100001010000010100} :
                  (ma[24:17] == 8'b10011101) ? {1'b0,27'b11100110110010001001000010} :
                  (ma[24:17] == 8'b10011110) ? {1'b0,27'b11100110000011011110010101} :
                  (ma[24:17] == 8'b10011111) ? {1'b0,27'b11100101010101001111110000} :
                  (ma[24:17] == 8'b10100000) ? {1'b0,27'b11100100100111011100111000} :
                  (ma[24:17] == 8'b10100001) ? {1'b0,27'b11100011111010000101010001} :
                  (ma[24:17] == 8'b10100010) ? {1'b0,27'b11100011001101001000100000} :
                  (ma[24:17] == 8'b10100011) ? {1'b0,27'b11100010100000100110001010} :
                  (ma[24:17] == 8'b10100100) ? {1'b0,27'b11100001110100011101110111} :
                  (ma[24:17] == 8'b10100101) ? {1'b0,27'b11100001001000101111001100} :
                  (ma[24:17] == 8'b10100110) ? {1'b0,27'b11100000011101011001110001} :
                  (ma[24:17] == 8'b10100111) ? {1'b0,27'b11011111110010011101001110} :
                  (ma[24:17] == 8'b10101000) ? {1'b0,27'b11011111000111111001001100} :
                  (ma[24:17] == 8'b10101001) ? {1'b0,27'b11011110011101101101010010} :
                  (ma[24:17] == 8'b10101010) ? {1'b0,27'b11011101110011111001001011} :
                  (ma[24:17] == 8'b10101011) ? {1'b0,27'b11011101001010011100100000} :
                  (ma[24:17] == 8'b10101100) ? {1'b0,27'b11011100100001010110111100} :
                  (ma[24:17] == 8'b10101101) ? {1'b0,27'b11011011111000101000001001} :
                  (ma[24:17] == 8'b10101110) ? {1'b0,27'b11011011010000001111110010} :
                  (ma[24:17] == 8'b10101111) ? {1'b0,27'b11011010101000001101100010} :
                  (ma[24:17] == 8'b10110000) ? {1'b0,27'b11011010000000100001000110} :
                  (ma[24:17] == 8'b10110001) ? {1'b0,27'b11011001011001001010001010} :
                  (ma[24:17] == 8'b10110010) ? {1'b0,27'b11011000110010001000011011} :
                  (ma[24:17] == 8'b10110011) ? {1'b0,27'b11011000001011011011100110} :
                  (ma[24:17] == 8'b10110100) ? {1'b0,27'b11010111100101000011010111} :
                  (ma[24:17] == 8'b10110101) ? {1'b0,27'b11010110111110111111011110} :
                  (ma[24:17] == 8'b10110110) ? {1'b0,27'b11010110011001001111100111} :
                  (ma[24:17] == 8'b10110111) ? {1'b0,27'b11010101110011110011100010} :
                  (ma[24:17] == 8'b10111000) ? {1'b0,27'b11010101001110101010111110} :
                  (ma[24:17] == 8'b10111001) ? {1'b0,27'b11010100101001110101101001} :
                  (ma[24:17] == 8'b10111010) ? {1'b0,27'b11010100000101010011010100} :
                  (ma[24:17] == 8'b10111011) ? {1'b0,27'b11010011100001000011101101} :
                  (ma[24:17] == 8'b10111100) ? {1'b0,27'b11010010111101000110100101} :
                  (ma[24:17] == 8'b10111101) ? {1'b0,27'b11010010011001011011101100} :
                  (ma[24:17] == 8'b10111110) ? {1'b0,27'b11010001110110000010110100} :
                  (ma[24:17] == 8'b10111111) ? {1'b0,27'b11010001010010111011101100} :
                  (ma[24:17] == 8'b11000000) ? {1'b0,27'b11010000110000000110000110} :
                  (ma[24:17] == 8'b11000001) ? {1'b0,27'b11010000001101100001110100} :
                  (ma[24:17] == 8'b11000010) ? {1'b0,27'b11001111101011001110100111} :
                  (ma[24:17] == 8'b11000011) ? {1'b0,27'b11001111001001001100010010} :
                  (ma[24:17] == 8'b11000100) ? {1'b0,27'b11001110100111011010100110} :
                  (ma[24:17] == 8'b11000101) ? {1'b0,27'b11001110000101111001010110} :
                  (ma[24:17] == 8'b11000110) ? {1'b0,27'b11001101100100101000010101} :
                  (ma[24:17] == 8'b11000111) ? {1'b0,27'b11001101000011100111010110} :
                  (ma[24:17] == 8'b11001000) ? {1'b0,27'b11001100100010110110001011} :
                  (ma[24:17] == 8'b11001001) ? {1'b0,27'b11001100000010010100101010} :
                  (ma[24:17] == 8'b11001010) ? {1'b0,27'b11001011100010000010100100} :
                  (ma[24:17] == 8'b11001011) ? {1'b0,27'b11001011000001111111101110} :
                  (ma[24:17] == 8'b11001100) ? {1'b0,27'b11001010100010001011111100} :
                  (ma[24:17] == 8'b11001101) ? {1'b0,27'b11001010000010100111000010} :
                  (ma[24:17] == 8'b11001110) ? {1'b0,27'b11001001100011010000110101} :
                  (ma[24:17] == 8'b11001111) ? {1'b0,27'b11001001000100001001001001} :
                  (ma[24:17] == 8'b11010000) ? {1'b0,27'b11001000100101001111110011} :
                  (ma[24:17] == 8'b11010001) ? {1'b0,27'b11001000000110100100101000} :
                  (ma[24:17] == 8'b11010010) ? {1'b0,27'b11000111101000000111011110} :
                  (ma[24:17] == 8'b11010011) ? {1'b0,27'b11000111001001111000001010} :
                  (ma[24:17] == 8'b11010100) ? {1'b0,27'b11000110101011110110100000} :
                  (ma[24:17] == 8'b11010101) ? {1'b0,27'b11000110001110000010011000} :
                  (ma[24:17] == 8'b11010110) ? {1'b0,27'b11000101110000011011100111} :
                  (ma[24:17] == 8'b11010111) ? {1'b0,27'b11000101010011000010000011} :
                  (ma[24:17] == 8'b11011000) ? {1'b0,27'b11000100110101110101100011} :
                  (ma[24:17] == 8'b11011001) ? {1'b0,27'b11000100011000110101111011} :
                  (ma[24:17] == 8'b11011010) ? {1'b0,27'b11000011111100000011000101} :
                  (ma[24:17] == 8'b11011011) ? {1'b0,27'b11000011011111011100110101} :
                  (ma[24:17] == 8'b11011100) ? {1'b0,27'b11000011000011000011000011} :
                  (ma[24:17] == 8'b11011101) ? {1'b0,27'b11000010100110110101100101} :
                  (ma[24:17] == 8'b11011110) ? {1'b0,27'b11000010001010110100010100} :
                  (ma[24:17] == 8'b11011111) ? {1'b0,27'b11000001101110111111000101} :
                  (ma[24:17] == 8'b11100000) ? {1'b0,27'b11000001010011010101110001} :
                  (ma[24:17] == 8'b11100001) ? {1'b0,27'b11000000110111111000001111} :
                  (ma[24:17] == 8'b11100010) ? {1'b0,27'b11000000011100100110010111} :
                  (ma[24:17] == 8'b11100011) ? {1'b0,27'b11000000000001100000000001} :
                  (ma[24:17] == 8'b11100100) ? {1'b0,27'b10111111100110100101000100} :
                  (ma[24:17] == 8'b11100101) ? {1'b0,27'b10111111001011110101011000} :
                  (ma[24:17] == 8'b11100110) ? {1'b0,27'b10111110110001010000110110} :
                  (ma[24:17] == 8'b11100111) ? {1'b0,27'b10111110010110110111010110} :
                  (ma[24:17] == 8'b11101000) ? {1'b0,27'b10111101111100101000110000} :
                  (ma[24:17] == 8'b11101001) ? {1'b0,27'b10111101100010100100111101} :
                  (ma[24:17] == 8'b11101010) ? {1'b0,27'b10111101001000101011110110} :
                  (ma[24:17] == 8'b11101011) ? {1'b0,27'b10111100101110111101010011} :
                  (ma[24:17] == 8'b11101100) ? {1'b0,27'b10111100010101011001001101} :
                  (ma[24:17] == 8'b11101101) ? {1'b0,27'b10111011111011111111011101} :
                  (ma[24:17] == 8'b11101110) ? {1'b0,27'b10111011100010101111111100} :
                  (ma[24:17] == 8'b11101111) ? {1'b0,27'b10111011001001101010100100} :
                  (ma[24:17] == 8'b11110000) ? {1'b0,27'b10111010110000101111001101} :
                  (ma[24:17] == 8'b11110001) ? {1'b0,27'b10111010010111111101110000} :
                  (ma[24:17] == 8'b11110010) ? {1'b0,27'b10111001111111010110001000} :
                  (ma[24:17] == 8'b11110011) ? {1'b0,27'b10111001100110111000001110} :
                  (ma[24:17] == 8'b11110100) ? {1'b0,27'b10111001001110100011111011} :
                  (ma[24:17] == 8'b11110101) ? {1'b0,27'b10111000110110011001001010} :
                  (ma[24:17] == 8'b11110110) ? {1'b0,27'b10111000011110010111110011} :
                  (ma[24:17] == 8'b11110111) ? {1'b0,27'b10111000000110011111110010} :
                  (ma[24:17] == 8'b11111000) ? {1'b0,27'b10110111101110110000111111} :
                  (ma[24:17] == 8'b11111001) ? {1'b0,27'b10110111010111001011010101} :
                  (ma[24:17] == 8'b11111010) ? {1'b0,27'b10110110111111101110101110} :
                  (ma[24:17] == 8'b11111011) ? {1'b0,27'b10110110101000011011000101} :
                  (ma[24:17] == 8'b11111100) ? {1'b0,27'b10110110010001010000010100} :
                  (ma[24:17] == 8'b11111101) ? {1'b0,27'b10110101111010001110010100} :
                  (ma[24:17] == 8'b11111110) ? {1'b0,27'b10110101100011010101000001} : {1'b0,27'b10110101001100100100010101};

  wire [27:0] y1;
  wire [106:0] p1;
  assign p1 = ({27'b0,2'b11,78'b0} - ({80'b0,ma,2'b0} * {79'b0,init} * {79'b0,init})) * {79'b0,init};
  assign y1 = (p1[78] && (|p1[77:0] || p1[79])) ? p1[106:79] + 28'b1 : p1[106:79];
  
  wire [27:0] y2;
  wire [106:0] p2;
  assign p2 = ({27'b0,2'b11,78'b0} - ({80'b0,ma,2'b0} * {79'b0,y1} * {79'b0,y1})) * {79'b0,y1};
  assign y2 = (p2[78] && (|p2[77:0] || p2[79])) ? p2[106:79] + 28'b1 : p2[106:79];

  wire [24:0] mye;
  assign mye = (y2[27]) ? ((y2[3]) ? {1'b0, y2[27:4]} + 25'b1 : {1'b0, y2[27:4]}) :
                (y2[26]) ? ((y2[2]) ? {1'b0, y2[26:3]} + 25'b1 : {1'b0, y2[26:3]}) :
                (y2[25]) ? ((y2[1]) ? {1'b0, y2[25:2]} + 25'b1 : {1'b0, y2[25:2]}) :
                (y2[0]) ? {1'b0, y2[24:1]} + 25'b0 : {1'b0, y2[24:1]};

  wire [22:0] my;
  assign my = (mye[24]) ? 23'b0 : mye[22:0];

  wire [7:0] eye;
  assign eye = (y2[27]) ? 255 - ea :
                (y2[26]) ? 254 - ea :
                (y2[25]) ? 253 - ea : 252 - ea;

  wire [7:0] ey;
  assign ey = (mye[24]) ? eye + 8'b1 : eye;

  wire [31:0] y_mul;
  wire ovf_mul;

  fmul u1(x, {s, ey, my}, y_mul, ovf_mul);

  wire nzm;
  assign nzm = |m;

  assign y = (e == 8'd255 && nzm) ? {s,8'd255,1'b1,m[21:0]} : 
              (s == 1'b0 && e == 8'd255 && ~nzm) ? {1'b0,8'd255,23'b0} :
              (~|x) ? {1'b0,8'b0,23'b0} : 
              (s == 1'b1 && ~|x[30:0]) ? {1'b1,8'b0,23'b0} : 
              (s == 1'b1) ? {1'b1,8'd255,1'b1,22'b0} : y_mul;

endmodule

`default_nettype wire