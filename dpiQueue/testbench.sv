// Testbench which gets data from the different model counter blocks
// Author: Adam Herrmann

// We try to get 5 values from counter 0, and 3 values from counter 1
// Since each model counter counts exactly 4 values, we should get an 
// error when we try to get the 5th value. Since we only get 3 values 
// from counter 1, we will have a value left over which is flagged as
// an error.

module dpi_tb;

  typedef struct 
  {
  	int data;
    int info;
  } ModelData;
  
  import "DPI-C" context function void startModel();
  import "DPI-C" context function void structTest(ModelData data);
  import "DPI-C" context function int getDataFromUnit(int id);
  import "DPI-C" context function int getDataCountFromUnit(int id);
  export "DPI-C" function sendDataFromUnit;
  
  ModelData data;
  
  initial
  begin
    // Run the model to generate reference data
    $display("[SV TB] Starting model");
    startModel();
    $display("[SV TB] Model finished");
    
    // Test of points struct being passed from SV->CPP->SV (not working)
    data.data = 1;
    data.info = 2;
    structTest(data);
    $display("[SV TB] Struct data: %0d, info: %0d", data.data, data.info);
    
  	// Get data from the model for unit 0
    for(int i = 0; i < 5; i++)
      $display("[SV TB] Received %0d from C++ world", getDataFromUnit(0));
      
    // Get data from the model for unit 1
    for(int i = 0; i < 3; i++)
      $display("[SV TB] Received %0d from C++ world", getDataFromUnit(1));
    
    // Check queues for units
    if(getDataCountFromUnit(0))
      $display("[SV TB] ERROR: Data left over in model queue 1");
    
    if(getDataCountFromUnit(1))
      $display("[SV TB] ERROR: Data left over in model queue 1");
    
    // ...
  end
  
  // Function to receive the data from the model when it is sent
  function void sendDataFromUnit(int id, int data);
    $display("[SV TB] Received data from unit %0d: %0d", id, data);
  endfunction
  
endmodule