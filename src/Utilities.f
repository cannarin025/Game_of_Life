{ -------------------------------Helpful Words------------------------------- }

: clear_stack 0 begin drop depth 1 < until ; 

: print_stack \ print the contents of the stack without disturbing it
depth 0=
if
." <top"
else
    0 depth 2 - do
    I pick .
-1 +loop
." <top "
then
cr
;