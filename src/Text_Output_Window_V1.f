
{ ----------------- Text Output Window for Life Development ----------------- }
{                                                                             }
{  Creates a new window and writes a series of dummy variable values          }
{  to it in real time                                                         }
{                                                                             }
{                        Roland A Smith 09/10/2020                            }


10 constant L-Spaces    { Set value of number of leading Spaces for right jst.}

8  constant Char-Pixels { Amount / pixels per text char for right just. outpt.}

variable Test_Var_1     { Dummy variables for test purposes }
variable Test_Var_2
variable Test_Var_3  
variable Test_Var_4   
variable Test_Var_5
variable Test_Var_6
variable Test_Var_7


: Text-Out  ( hdc -- )     { Output formatted text - numbers right justified  }

 {  DUP Font-Handle @ SelectObject drop  \ set font type here }

   DUP ( hdc)  10  20 S" Iteration number       "        TextOut DROP  { Write titles to window }
   DUP ( hdc)  140 20 S"                 "               TextOut DROP
   DUP ( hdc)  L-Spaces iteration @ (.) 
               swap drop - Char-Pixels *
               100 + 20 iteration @ (.)                  TextOut DROP

   DUP ( hdc)  10  40 S" Total alive       "             TextOut DROP
   DUP ( hdc)  140 40 S"                 "               TextOut DROP
   DUP ( hdc)  L-Spaces total_alive @ (.)
               swap drop - Char-Pixels *
               100 + 40 total_alive @ (.)                TextOut DROP

   DUP ( hdc)  10  60 S" Total dead       "              TextOut DROP
   DUP ( hdc)  140 60 S"                 "               TextOut DROP
   DUP ( hdc)  L-Spaces total_dead @   (.)
               swap drop - Char-Pixels *
               100 + 60 total_dead @   (.)               TextOut DROP

   DUP ( hdc)  10  80 S" Born this generation       "    TextOut DROP
   DUP ( hdc)  140 80 S"                 "               TextOut DROP
   DUP ( hdc)  L-Spaces born @    (.)
               swap drop - Char-Pixels *
               100 + 80 born @    (.)                    TextOut DROP

   DUP ( hdc)  10 100 S" Died this generation       "    TextOut DROP
   DUP ( hdc)  140 100 S"                "               TextOut DROP
   DUP ( hdc)  L-Spaces died @ (.)
               swap drop - Char-Pixels *
               100 + 100 died @ (.)                      TextOut DROP

   DUP ( hdc)  10 120 S" Activity * 100000       "       TextOut DROP
   DUP ( hdc)  140 120 S"                "               TextOut DROP
   DUP ( hdc)  L-Spaces activity @ (.)
               swap drop - Char-Pixels *
               100 + 120 activity @ (.)                  TextOut DROP 

   DUP ( hdc)  10 140 S" Synchronicity       "       TextOut DROP
   DUP ( hdc)  140 140 S"                "               TextOut DROP
   DUP ( hdc)  L-Spaces synchronicity @ (.)
               swap drop - Char-Pixels *
               100 + 140 synchronicity @ (.)                  TextOut DROP 
   
   DROP
   ;



0 VALUE hAPP-Text                 { Handle for the Text Window                }


CREATE CLASSNAME ,Z" Text-Output" { Classname                                 }


[SWITCH MESSAGE-HANDLER DEFWINPROC ( -- res )
   ( no behavior yet)
SWITCH]


:NONAME ( -- res )
   MSG LOWORD MESSAGE-HANDLER ;  4 CB: APPLICATION-CALLBACK


:PRUNE   ?PRUNE -EXIT
   hAPP-Text IF hAPP-Text WM_CLOSE 0 0 SendMessage DROP THEN
   CLASSNAME HINST UnregisterClass DROP ;


{ --------------------------- Register the class ---------------------------- }


: REGISTER-CLASS ( -- )
   CLASSNAME APPLICATION-CALLBACK DefaultClass DROP ;


{ ------------------------ Create and show the window ----------------------- }

: CREATE-TEXT-WINDOW ( -- handle )
      0                                 \ extended style
      CLASSNAME                         \ window class name
      Z" Life Statistics"                    \ window caption
      WS_OVERLAPPEDWINDOW               \ window style
      40 40 250 220                     \ static initial position and size
      0                                 \ parent window handle
      0                                 \ window menu handle
      HINST                             \ program instance handle
      0                                 \ creation parameter
   CreateWindowEx ;


: START-TEXT-WINDOW ( -- flag )
   REGISTER-CLASS CREATE-TEXT-WINDOW DUP IF
      DUP SW_NORMAL ShowWindow DROP
      DUP UpdateWindow DROP
      TO hAPP-Text
   THEN ;


{ ---------------  Encapsulate the functionality of the program ------------- }


50 Constant Text-Update-Timer   { Sets Text windows update rate     }


: TEXT-CREATE ( -- res ) HWND 0 Text-Update-Timer 0 SetTimer DROP  0 ; 


: REFRESH ( -- )
   HWND 0 0 InvalidateRect DROP ;


: REPAINT ( -- res )
   HWND PAD BeginPaint ( hdc)
   HWND HERE GetClientRect DROP
   ( hdc)  Text-Out
   HWND PAD EndPaint DROP  0 ;


[+SWITCH MESSAGE-HANDLER ( -- res )
   WM_CREATE RUNS TEXT-CREATE
   WM_TIMER  RUNS REFRESH
   WM_PAINT  RUNS REPAINT
   WM_CLOSE  RUN: HWND DestroyWindow DROP 0 TO hAPP-Text  0 ;
   WM_DESTROY RUN: 0 'MAIN @ ?EXIT PostQuitMessage ;
SWITCH]


  START-TEXT-WINDOW