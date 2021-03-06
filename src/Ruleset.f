{ -------------------------------Life ruleset-------------------------------- }
clear_stack

{ Number of neighbors for survival}


{ --------------------------------Vary S here-------------------------------- }
2 3          
{ ----------------------------------------------------------------------------}


depth constant S_length
create S_array S_length allot

: fill_S_array 
    0 
    S_length 0=
    if
    else
        begin 
            dup rot rot 
            S_array +
            c!
            1 +
            dup
            S_length >=
        until
    then
    drop
;

: get_all_S
    0
    S_length 0=
    if
    else
        begin
            dup
            S_array + c@
            swap
            1 +
            dup
            S_length >= 
        until
    then
    drop
;

fill_S_array


{ Number of neighbors for birth}


{ --------------------------------Vary B here-------------------------------- }
3
{ ----------------------------------------------------------------------------}

depth constant B_length
create B_array B_length allot

: fill_B_array 
    0
    B_length 0=
    if
    else
        begin 
            dup rot rot 
            B_array +
            c!
            1 +
            dup
            B_length >=
        until
    then
    drop
;

: get_all_B
    0
    B_length 0=
    if
    else
        begin
            dup
            B_array + c@
            swap
            1 +
            dup
            B_length >= 
        until
    then
    drop
;

fill_B_array

variable check_depth

: check_in_S \ example: 5 check_in_s returns -1 for true if S contains 5
    S_length 1 + check_depth !
    get_all_S
    S_length 0=
    if
        drop
        0
    else
        check_depth @ 1 - pick 
        - 0=

        check_depth @ 2 - 0=
        if
            swap drop \ drops number being checked. will return whatever result of above logical operation was if depth of stack is 2 (i.e. only 1 element in list)
        else
            begin
                swap
                check_depth @ 1 - pick 
                - 0=
                or
                check_depth @ 1 - check_depth !
                check_depth @ 2 - 0= 
            until
            swap drop
        then
    then
;

: check_in_B \ example: 5 check_in_B returns -1 for true if B contains 5
    B_length 1 + check_depth !
    get_all_B
    B_length 0=
    if
        drop
        0
    else
        check_depth @ 1 - pick 
        - 0=
        
        check_depth @ 2 - 0=
        if
            swap drop \ drops number being checked. will return whatever result of above logical operation was if depth of stack is 2 (i.e. only 1 element in list)
        else
            begin
                swap
                check_depth @ 1 - pick 
                - 0=
                or
                check_depth @ 1 - check_depth !
                check_depth @ 2 - 0= 
            until
            swap drop
        then
    then
;

\ : check_in_B \ example: 5 check_in_B returns -1 for true if B contains 5
\     get_all_B
\     B_length 0=
\     if
\         drop
\         0
\     else
\         depth 1 - pick 
\         - 0=

\         depth 2 - 0=
\         if
\             swap drop \ drops number being checked. will return whatever result of above logical operation was if depth of stack is 2 (i.e. only 1 element in list)
\         else
\             begin
\                 swap
\                 depth 1 - pick 
\                 - 0=
\                 or
\                 depth 2 - 0= 
\             until
\             swap drop
\         then
\     then
\ ;

\ : check_commented \ example: 5 check_in_s returns -1 for true if S contains 5
\     get_all_S
\     print-stack cr
\     S_length
\     print-stack cr
\     dup . ." start length of s" cr
\     0=
\     if
\         drop
\         0
\         ." no elements in S" cr
\     else
\         ." starting normal algorithm"
\         print-stack cr
\         depth 1 - pick 
\         - 0=
\         print-stack cr
\         depth 2 - 0=
\         if
\             swap drop \ drops number being checked. will return whatever result of above logical operation was if depth of stack is 2 (i.e. only 1 element in list)
\             ." Only 1 element in S" cr
\         else
\             begin
\                 ." Usual algorithm" cr
\                 print-stack cr
\                 swap
\                 depth 1 - pick 
\                 - 0=
\                 or
\                 depth 2 - 0= 
\                 print-stack cr
\             until
\             ." finished"
\             swap drop
\         then
\     then
\ ;
