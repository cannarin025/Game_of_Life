
: Cube dup dup * * dup . ;   



: test_loop_1 10 0 do I . loop ; 
: test_loop_2 10 0 do I . 2 +loop ; 
: test_loop_3 0 10 do I . -1 +loop ; 

: test_loop_4 0 begin wipe 1 + dup . again ; 
: test_loop_5 0 begin wipe 1 + dup dup . 500 >= until ; 



: clear_stack begin 0 wipe 1 + swap drop depth >= until ; 
: clear_stack 0 begin drop depth 1 < until ; 



: multiply_all_vals 10 0 do 10 0 do I . J . I J * . cr loop loop ;



: even_squares 11 2 do I 2 * . I 2 * dup * . CR loop ; 



 : mupltiple_5
 cr dup
 5 mod 0=
    if ." The number " . ." is divisible by 5"
    else ." The number " . ." is not divisible by 5"
 then cr ;



: test_case
CR
dup
case
    2 of ." Number 2 found " drop true endof
    5 of ." Number 5 found " drop true endof
    7 of ." Number 7 found " drop true endof
    drop DUP OF false ." no valid number found" ENDOF
endcase
CR ;



: All_ASCII
CR
0
128 0
do
    I
    swap
    1 + 
    10 <=
        if swap emit
        else drop 1 swap CR emit
    then
loop ;

: All_ASCII
CR
0
128 0
DO
    I
    EMIT
    I 10 MOD
    0 = IF CR THEN
LOOP ;



: num_word
CR
dup
case
    1 of ." one" drop endof
    2 of ." two " drop endof
    3 of ." three " drop endof
    4 of ." four" drop endof
    5 of ." five" drop endof
    6 of ." six" drop endof
    7 of ." seven" drop endof
    8 of ." eight" drop endof
    9 of ." nine" drop endof
    10 of ." ten" drop endof
    drop DUP OF ." number not in range 1-10" endof
endcase
CR ;



create small_array 100 allocate drop
: reset_small_array small_array 100 0 fill ;

: show_small_array 10 0 do CR I 10 * 10 0 do small_array J + + c@ . loop loop ;

: show_small_array 
100 0 do 
I 10 mod 0= 
if cr cr
then
small_array I + C@ 8 .R loop ;
reset_small_array


: array_@
small_array
rot rot swap
1 - swap 1 - 10 * + 
+ c@ ;

: array_@ 10 * + small_array swap + C@ ;

: array_! 
small_array
rot rot swap
1 - swap 1 - 10 * + 
+ c! ;

: array_! 10 * + small_array swap + C! ;

: linear_small_array 100 0 do I 1 + small_array I + c! loop ;

23 1 5 array_!
1 5 array_@
show_small_array
CR
linear_small_array
show_small_array