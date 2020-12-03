
A few examples of how to output text data in real time, write data to disk in an ASCII format and display grahical and numerical data on screen to help you visualise large data arrays in the D3 Conway’s Life experiment.


Text Output Methods

Method 1.

The simplest method is to simply write numerical or string output to the Forth console using standard print operations such as "." .


Method 2.

Text_Output_Window_V1.f

This file creates a new window and then writes dummy numerical data to it in real time.  It can run in parallel with a graphics window.  


File IO

Test_File_IO_Tools.f

Some examples of how to create and write ASCII data to a file on disk, e.g to output statistical data.


Graphics output methods for SwifForth

Graphics_V6_Single_Scaled_BMP_Window.f

This shows a technique to create a new window and repetitively build a bitmap image file (.bmp) in memory and write this to the window in a single hardware accelerated process.  Some rather cyptic OS specific code is needed to create and talk to the window, but you should not need to understand or modify this to get the method working.  The Forth console remains available for simultaneous text output.  For this example the .bmp is updated with random brightness pixels as a stand in for the Conway’s Life simulation.  

Two slightly different methods are provided.  The first uses the Windows API function SetDIBitsToDevice and writes the .bmp to a window (scaled to the image size) with a single pixel representing a live or dead cell.  This is useful for visualising large arrays but the fine details can be hard to see without capturing an image and scaling it up in a separate graphics program.  The word go-copy at the end of the file runs an example of this technique.  

The 2nd method uses the Windows API call StretchDIBits which stretches the pixels of a .bmp image to fill the display window (by default 250x250 pixels or the image size, whichever is larger).  This method is useful for displaying smaller arrays and expanding individual cells so they are easier to visualise.  The word go-stretch at the end of the file runs an example of this technique.  


