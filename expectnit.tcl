# -*- mode: tcl; tab-width: 4; coding: utf-8 -*-
#
# Capture and encapsulate expect_out and other reserved variables of expect.
# See also CAVEAT section of expect(1).
#

package require snit
package require Expect

snit::type expectnit {
    option -debug 0
    
    variable expect_out   -array []
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
        $self dputs "====Expect START===>>>"
        
        ::expect {*}$args

        $self dputs ">>>====Expect END==="
    }

    method interact args { ::interact {*}$args }
    
    method dputs args {
        if {!$options(-debug)} return
        puts $args
    }
}

