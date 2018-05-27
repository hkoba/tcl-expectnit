# expectnit - Objectized Expect state via snit

This is a proof of concept code to ease pain of
programming in Don Libes' [Expect](https://wiki.tcl.tk/201). 
As noted in **CAVEATS** section of official
[expect(1) man page](https://www.tcl.tk/man/expect5.31/expect.1.html),
Expect's state variables such as `expect_out` has different scope model
than normal [Tcl](http://www.tcl.tk/) variables.
Expect builtins (`expect`,...) treat these variables 
as local to procedure call. IMHO this is a most common pitfall
in Expect programming for new comers. And even after understanding it,
it is main source of annoyance for code refactoring in Expect.
Because you need to repeatedly list these vars via `[global]` in each
of your procedures which uses Expect builtins.

Fortunately, we have [snit](http://wiki.tcl.tk/3963?redir=5494).
With snit, all you need to is just declaring instance variables.
Then snit automatically insert `[variable]` scope declaration 
into all methods you defined in the snit::type. In other words,
you can just list `spawn_id`, `expect_out`... as instance variables
and you can use ordinally expect builtins safely in your methods, like following code:

```tcl
package require Expect
package require snit

snit::type E {
    variable spawn_id
    variable expect_out   -array []
    # ... and other expect variables and your vars.

    method spawn args { ::spawn {*}$args }
    method expect args { ::expect {*}$args }
    # ... and any other methods...
}
```

## demo

### ex1.tcl

This example assume your shell on remote host is Zsh.
It works as following:

* spawn given command.
* send prompt settings for Zsh.
* wait a prompt.
* send `pwd`
* read echoback of the above.
* read the result of `pwd` command.


```shell
expect -d -f ./ex/ex1.tcl ssh localhost
```
