
{ ----------------- Basic File I/O in SwiftForth - R A Smith 2020 ------------------- }


{ NOTES  Forth uses an integer number called a "file handle" to identify any file you }
{        create or open for file I/O operations.  Before we start to use a file, we   }
{        need to create a variable to hold the file handle so that we can referr to   }
{        it in later read and write operations.  File operations will genarally       }
{        return a true / false flag depending on whether the operation worked or not  }
{        hence all the "drop" commands in the section below.                          }
{                                                                                     }
{        File Paths - You need to use a complete path to the file when creating or    }
{        opening a file.  If you dont use  a path the file will be assumed to be in   }
{        SwiftForth\Bin directory.                                                    }
{                                                                                     }
{        Here we hard code a path to files in a directory C:\Temp                     }


variable test-file-id                             { Create Variable to hold file id handle }
variable board-file-id                            { Create variable to store file id }


: make-test-file                                  { Create a test file to read / write to  }
  s" .\Data\life_data.csv" r/w create-file drop  { Create the file                        } 
  test-file-id !                                  { Store file handle for later use        }
;

 
: open-test-file                                  { Open the file for read/write access    }
  s" .\Data\life_data.csv" r/w open-file drop    { Not needed if we have just created     }
  test-file-id !                                  { file.                                  }
;


: close-test-file                                 { Close the file pointed to by the file  }
  test-file-id @                                  { handle.                                }
  close-file drop
; 


: test-file-size                                  { Leave size of file on top of stack as  }
  test-file-id @                                  { a double prescision integer if the     }
  file-size drop                                  { file is open.                          }
;


: write-file-header 
  s"   Conway's Game of Life Data " test-file-id @ write-line drop                                                            { Writes single lines of text to a file }
  s"   Format: Iteration number, total number of living cells, total number of dead cells, cells born this generation, no of cells that died this generation, activity * 100000 " test-file-id @ write-line drop    { terminating each line with a LF/CR.   }
  s"                      " test-file-id @ write-line drop                                                                    { first.                                }
 ;


: write-file-data-1                                        { Write a series of integer numbers to a }
  1 (.) test-file-id @ write-line drop                     { file as ASCII characters.  We use the  }
  2 (.) test-file-id @ write-line drop                     { Forth command (.) to convert numbers   }
  3 (.) test-file-id @ write-line drop                     { on the stack into counted ASCII strings}
;


: write-file-data-2                                        { Write a series of integer numbers to a }               
  100 1 do                                                 { file as ASCII characters from inside a }
  i 20 * (.) test-file-id @ write-line drop                { looped structure.  File must be open   }
  loop                                                     { for R/W access first.                  }
  ;

: Write-file-data-3                                        { Write a series of pairs of integer     }
  20 1 do                                                  { numbers to an open file.               }
  i (.)     test-file-id @ write-file drop
  s"  "     test-file-id @ write-file drop
  i 2 * (.) test-file-id @ write-line drop
  loop
;

: Write-file-powers
  50 1 do
  i (.)         test-file-id @ write-file drop
  s" ,"         test-file-id @ write-file drop
  i i * (.)     test-file-id @ write-file drop
  s" ,"         test-file-id @ write-file drop
  i i i * * (.) test-file-id @ write-line drop
  loop
;

: Write_Sim_Data 
  iteration @   (.)   test-file-id @ write-file drop
  s" ,"               test-file-id @ write-file drop
  total_alive @ (.)   test-file-id @ write-file drop
  s" ,"               test-file-id @ write-file drop
  total_dead @   (.)  test-file-id @ write-file drop
  s" ,"               test-file-id @ write-file drop
  born @ (.)          test-file-id @ write-file drop
  s" ,"               test-file-id @ write-file drop
  died @  (.)         test-file-id @ write-file drop
  s" ,"               test-file-id @ write-file drop
  activity @  (.)     test-file-id @ write-line drop
;
  
: Write-blank-data                                         { Write an empty line to the file       }
  s"  " test-file-id @ write-line drop
;


: output_boardstate
   array_size 0 
   do 
        I array_x_dim mod 0= 
        if 
            test-file-id @ write-line drop
        then
            conway_array I + C@ 
            test-file-id @ write-file drop 
    loop
    CR  
;

{ --------------- Now lets put all of this together to create, write to and close a file ---------- }             



: Make_Sim_File
  make-test-file
  test-file-size cr cr ." File Start Size = " d.
  write-file-header
;

: End_Sim_File
  Write-blank-data
  test-file-size cr cr ." File End Size =   " d. cr cr
  close-test-file
  ." Ascii data file written to .\Data\life_data.csv " cr cr
;