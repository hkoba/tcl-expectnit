#!/usr/bin/tclsh
# -*- mode: tcl; tab-width: 4; coding: utf-8 -*-

source [file dirname [file dirname [info script]]]/expectnit.tcl

apply {{argList} {
    expectnit exp

    set varName expect_out

    exp spawn {*}$argList
    
    trace add variable [exp myvar $varName] write \
        [list apply [list args {
            puts write:$args
        }]]

    exp send "setopt no_zle no_prompt_cr; PROMPT='%# ' RPROMPT=''\n\n"

    exp expect "% "
    
    parray [exp myvar $varName]

    exp send "pwd\n"
    
    exp expect -re {(\S+)}
    
    puts matched

    parray [exp myvar $varName]
    
    puts END
}} $::argv
