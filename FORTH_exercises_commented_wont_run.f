{words}
: Cube dup dup * * dup . ;    {prints (and adds to stack) cube of top number on stack}

{loops}
: test_loop_1 10 0 do I . loop ; {loop. loops from 0 to 10-1 stores number in I and prints I}
: test_loop_2 10 0 do I . 2 +loop ; {+loop. loops from 0 to 10-1 with step size 2 (can also do negative step size) stores number in I and prints I}
: test_loop_3 0 10 do I . -1 +loop ; {+loop. loops from 10 to 0 with step size -1 stores number in I and prints I}

: test_loop_4 0 begin wipe 1 + dup . again ; {begin again loop. loops instructions between begin and again statements. starts from 0 and adds 1 each iteration here clearing console between iterations (this is an infinite loop)}
: test_loop_5 0 begin wipe 1 + dup dup . 500 >= until ; {begin again loop. loops instructions between begin and until statements until condition is "True" i.e. equal to -1. Here 500 >= checks top value on stack against 500 and retuns -1 (True) if greater or equal to and 0 (False) if not}
{further testing showeed that until loop runs while top of stack is 0 and stops when top of stack is non-zero. i.e. in above example, while less < 500, 0 is returned for "false" so top of stack is set to 0 and loop keeps running. When value increments to 500, >= 500 returns -1 for "true" which causes top of stack to be nonzero, thus the loop ends}

{ex 10}
: clear_stack begin 0 wipe 1 + swap drop depth >= until ; {a function to clear the stack. Adds to top of stack as a counter, swaps top values, drops top value. Repeats until counter = stack length}
: clear_stack 0 begin drop depth 1 < until ; {more concise function. Note stack must not be empty. note: adds 0 to stack at start so it also works with empty stacks}

{ex 11}
: multiply_all_vals 10 0 do 10 0 do I . J . I J * . cr loop loop ;

{ex 12}
: even_squares 11 2 do I 2 * . I 2 * dup * . CR loop ; {prints even numbers from 4 to 20 and its square on each line}

{ex 13}
: mupltiple_5
 cr dup
 5 mod 0=
    if ." The number " . ." is divisible by 5"
    else ." The number " . ." is not divisible by 5"
 then cr ;

{ex 14}
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

{ex 15}
{does not work}
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

{doees work}
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


{ex 16}
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


{ex 17. This does not work for some reason. Does not let me make variables/constants inside word}
: make_small_array
create test_array 100 allocate drop
test_array 100 0 fill ;

: reset_array test_array 100 0 fill ;
: show_array 100 0 do test_array I + c@ . loop ;

{ex 18}
: array_@
test_array
rot rot swap {arranges stack so it is in form value test_array index2 index 1}
1 - swap 1 - 10 * + {works out index x,y i.e. 1,4 gives index 3 i.e. row 1 col 4 (arrays start at 0)}
+ c@ ; {reads value at index and puts on stack}

: array_! 10 * + small_array swap + C@ ; {cleaner method}

: array_! 
test_array
rot rot swap {arranges stack so it is in form value test_array index2 index 1}
1 - swap 1 - 10 * + {works out index x,y i.e. 1,4 gives index 3 i.e. row 1 col 4 (arrays start at 0)}
+ c! {inserts value at index}
show_array ;

: array_! 10 * + small_array swap + C! ; {cleaner method}

reset_array
show_array
23 1 5 array_!
1 5 array_@

reset_array
show_array