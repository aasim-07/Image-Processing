`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:56:08 03/30/2016 
// Design Name: 
// Module Name:    edgedetect 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
/////////////////////////////////////////////////////////////////////////////////
module edge_det();
  reg [7:0]mem[0:8099];
  reg [7:0]pad_mem[0:8463];
  reg [7:0]store[0:8099] ;
  reg [7:0]temp[0:5];
  integer i,j,k,p,q,inc,st ;
  reg [14:0]add=0 ;
  reg [2:0]mcd;
  
  initial
  $readmemh("bwimage.txt",mem);
  
  initial                                  //edge detection begins
   begin
    for(i=0;i<92;i=i+1)
    begin
      pad_mem[i]=0;
      pad_mem[i+8372]=0;
    end
  
  for(j=0;j<90;j=j+1)
   begin
    add=j*92;
    pad_mem[92+add]=0;
    for(k=0;k<90;k=k+1)
      pad_mem[93+add+k]=mem[k+(j*90)] ; 
    
    pad_mem[183+add]=0;
   end
  
   mcd=$fopen("imedge.v");
   for(p=0;p<90;p=p+1)
    begin
      inc=p*92 ;
      st=p*90;
      for(q=0;q<90;q=q+1)
       begin
        temp[0]=pad_mem[q+inc];
        temp[1]=pad_mem[q+1+inc]*(2'b10);
        temp[2]=pad_mem[q+2+inc];
        temp[3]=pad_mem[q+184+inc]*(-1'b1);
        temp[4]=pad_mem[q+185+inc]*(-2'b10);
        temp[5]=pad_mem[q+186+inc]*(-1'b1);
        store[q+st]=temp[0]+temp[1]+temp[2]+temp[3]+temp[4]+temp[5];
        $fdisplayh(mcd,store[q+st]);
       end
    end 
   $fclose(mcd); 
 end                               //edge detection end
endmodule
