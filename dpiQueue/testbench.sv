// Testbench which gets data from the different model counter blocks
// Author: Adam Herrmann

// We try to get 5 values from counter 0, and 3 values from counter 1
// Since each model counter counts exactly 4 values, we should get an 
// error when we try to get the 5th value. Since we only get 3 values 
// from counter 1, we will have a value left over which is flagged as
// an error.

module dpi_tb;

  import "DPI-C" context function void startModel();
  import "DPI-C" context function int getDataFromUnit(int id);
  import "DPI-C" context function int getDataCountFromUnit(int id);
  
  initial
  begin
    // Run the model to generate reference data
    $display("[SV TB] Starting model");
    startModel();
    $display("[SV TB] Model finished");
    
  	// Get data from the model for unit 0
    $display("[SV TB] Received %0d from C++ world", getDataFromUnit(0));
    $display("[SV TB] Received %0d from C++ world", getDataFromUnit(0));
    $display("[SV TB] Received %0d from C++ world", getDataFromUnit(0));
    $display("[SV TB] Received %0d from C++ world", getDataFromUnit(0));
    $display("[SV TB] Received %0d from C++ world", getDataFromUnit(0));
      
    // Get data from the model for unit 1
    $display("[SV TB] Received %0d from C++ world", getDataFromUnit(1));
    $display("[SV TB] Received %0d from C++ world", getDataFromUnit(1));
    $display("[SV TB] Received %0d from C++ world", getDataFromUnit(1));
    
    // Check queues for units
    if(getDataCountFromUnit(0))
      $display("[SV TB] ERROR: Data left over in model queue 1");
    
    if(getDataCountFromUnit(1))
      $display("[SV TB] ERROR: Data left over in model queue 1");
    
    // ...
  end
  
endmodule