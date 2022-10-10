module test;

  reg clock;
  reg reset;
  reg test_expr;
  
  ovl_example ovl_example(clock, reset, test_expr);
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, test);

    clock = 0;
    reset = 1;
    test_expr = 0;
    
    $display("ovl_never does not fire at reset");
    test_expr = 1;
    toggle_clock();
    
    $display({"ovl_never does not fire ",
    	"when test_expr is FALSE"});
    reset = 0;
    test_expr = 0;
    toggle_clock();
    
    $display("ovl_never FIRES when test_exp is X");
    test_expr = 1'bx;
    toggle_clock();

    $display("ovl_never FIRES when test_exp is 1");
    test_expr = 1'b1;
    toggle_clock();

    $finish;
  end
  
  task toggle_clock;
    repeat (2) #5 clock = ~clock;
  endtask
