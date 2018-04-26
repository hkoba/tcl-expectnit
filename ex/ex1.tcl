#!/usr/bin/tclsh
# -*- mode: tcl; tab-width: 4; coding: utf-8 -*-

source [file dirname [file dirname [info script]]]/expectnit.tcl

apply {{argList} {
    expectnit exp

    exp spawn {*}$argList
    
    trace add variable [exp myvar expect_out] write \
        [list apply [list args {
            puts write:$args
        }]]

    exp expect "%"
    
    parray [exp myvar my_expect_out]

    exp send "pwd\n"
    
    exp expect -re {(\S+)}
    
    puts matched

    parray [exp myvar my_expect_out]
    
    puts END
}} $::argv
