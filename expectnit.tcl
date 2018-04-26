# -*- mode: tcl; tab-width: 4; coding: utf-8 -*-
#
# Capture and encapsulate expect_out and other reserved variables of expect.
# See also CAVEAT section of expect(1).
#

package require snit
package require Expect

snit::type expectnit {
    variable my_expect_out   -array []
    variable interact_out -array []

    variable spawn_id
    variable user_spawn_id
    variable error_spawn_id
    variable tty_spawn_id

    variable spawn_out -array []

    # variable stty_init []

    # variable timeout []
    # variable send_slow []
    # variable send_human []

    method myvar varName {myvar $varName}

    method spawn args { ::spawn {*}$args }

    method send args { ::exp_send {*}$args }

    method expect args {
        puts "====Expect START===>>>"
        upvar \#0 [myvar my_expect_out] expect_out
        
        if {[array exists expect_out]} {
            puts "parray before:"
            parray expect_out        
            puts "----"
        }

        ::expect {*}$args
        puts "parray after:"
        parray expect_out        

        set cmd [list namespace which expect_out]
        puts $cmd=[{*}$cmd]
        set cmd [list info locals expect_out]
        puts $cmd=[{*}$cmd]

        puts ">>>====Expect END==="
    }

    method interact args { ::interact {*}$args }
}

