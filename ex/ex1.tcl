#!/usr/bin/tclsh
# -*- mode: tcl; tab-width: 4; coding: utf-8 -*-

# Run this like following:
# expect -d -f ./ex/ex1.tcl ssh localhost
#

source [file dirname [file dirname [info script]]]/expectnit.tcl

apply {{argList} {
    expectnit exp

    set varName expect_out

    exp spawn {*}$argList
    
    exp send "setopt no_zle no_prompt_cr; PROMPT='%# ' RPROMPT=''\n\n"
    # => "%\u001b[49m \u001b[K\u001b[67C \u001b[1m~\u001b[0m\u001b[49m\u001b[69D\u001b[?2004hs\u0008setopt no_zle no_prompt_cr; PROMPT='%# ' RPROMPT=''\u001b[?2004l\u001b[K\r\r\n% % "

    # ↑Match last "% % "
    exp expect -re {(% \r?\n?)+}

    parray [exp myvar $varName]

    exp send "pwd\n"
    exp expect -re {(\S+)\r?\n}; # read echoback.
    
    exp expect -re {(\S+)\r?\n}; # read pwd result.
    
    puts matched

    parray [exp myvar $varName]
    
    puts END
}} $::argv
