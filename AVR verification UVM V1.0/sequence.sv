class  my_sequence extends uvm_sequence#(txn_pkg);
       
       `uvm_object_utils(my_sequence)
        
        parameter N=11;
        txn_pkg t;
        
        bit [15:0]inst_arr[0:N-1] = '{16'b1110_0010_0101_0011, 16'b1110_0000_0011_0000, 16'b1110_0000_0110_0000, 16'b0001_0100_0101_0011, 16'b1111_0000_0010_0100, 16'b1001_0100_0110_0011, 16'b0001_1000_0101_0011, 16'b1111_0000_0010_0101, 16'b1111_0100_0000_1100, 16'b1011_1000_0110_0000, 16'b1100_0000_0010_1011};    //division
        
        //bit [15:0]inst_arr[0:N-1] = '{16'b1110_0001_0001_0011, 16'b1011_1000_0001_0000, 16'b1110_0000_0010_0101, 16'b1011_1000_0010_0000, 16'b0001_1000_0010_0001, 16'b1011_1000_0001_0000, 16'b1110_0000_0001_1011};  //subtraction with carry
        
        //bit [15:0]inst_arr[0:N-1] = '{16'b1110_0000_0101_0011, 16'b1110_0000_0011_0101, 16'b1110_0000_0110_0000, 16'b0000_1100_0110_0011, 16'b1001_0100_0101_1010, 16'b0011_0000_0101_0000, 16'b1111_0000_0010_0001, 16'b1100_0000_0000_1111, 16'b1011_1000_0110_0000, 16'b1100_0000_0010_0111};//multiplication
        
        //bit [15:0]inst_arr[0:N-1] = '{16'b1110_0010_0101_0011, 16'b1110_0000_0011_0101, 16'b1110_0000_0110_0000, 16'b0001_0100_0101_0011, 16'b1111_0000_0010_0100, 16'b1001_0100_0110_0011, 16'b0001_1000_0101_0011, 16'b1111_0000_0010_0101, 16'b1111_0100_0000_1100, 16'b1011_1000_0110_0000, 16'b1100_0000_0010_1011};    //division
        
        //bit [15:0]inst_arr[0:N-1] = '{16'b1110_0000_0101_0011, 16'b1110_0000_0011_0101, 16'b1110_0000_0110_0000, 16'b0000_1100_0110_0011, 16'b1001_0100_0101_1010, 16'b0011_0000_0101_0000, 16'b1111_0100_0000_1100, 16'b1011_1000_0110_0000, 16'b1100_0000_0010_0011};       //multiplication
        
        //bit [15:0]inst_arr[0:N-1] = '{16'b1110_0000_0011_0001, 16'b1110_0000_0101_0010, 16'b0000_1100_0001_0010};
        //bit [15:0]inst_arr[0:N-1] = '{16'b0000_1100_0101_0110};
        //bit [15:0]inst_arr[0:N-1] = '{16'b1110_0000_0110_0101,16'b1011_1000_0110_0000};


        function new(string name = "");
           super.new(name);
        endfunction
	
	
	task body();
            for(byte i=0;i<N;i++) begin
                     t=txn_pkg::type_id::create("t");
                     start_item(t);
                     t.wr_data = inst_arr[i];
                     t.wr_addr = i;
                     t.we = 2'b11;
                     $display("-----Sequence-----   Time=%0t",$time);
                     t.print();
                     //#10;
                     finish_item(t);
            end
            
            t=txn_pkg::type_id::create("t");
            start_item(t);
            t.wr_data = 16'b0000_0000_0000_0000;
            t.wr_addr = 8'hFF;
            t.we = 2'b00;
            $display("-----Sequence-----   Time=%0t",$time);
            t.print();
            finish_item(t);
            //end
       endtask

endclass
