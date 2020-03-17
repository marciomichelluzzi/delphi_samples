##TFunctionParser

* * * * * * * * * * * * * Parser of Functions Version 1.0 * * * * * * * * * *
* _________________________________________________________

Author: Carlos García Trujillo

_________________________________________________________

May 25 1999

Xalapa, Veracruz; Mexico.

Description:

---------------------------------------------------------

This is a non visual component that can evaluate mathematical functions
defined by the user on runtime.

It has as characteristic that can evaluate mathematical expressions as a
common calculator, and also supports user's variables, so you can define
functions of more than one variable without bigger problem.

The operators supported by this component are:

        +: Addition
        -: Subtraction
        *: Multiplication
        /: Division
        ^: Exponential (just supports positive numbers for the base)
        (: Parenthesis that opens up.
        ): Parenthesis that closes.
        MOD: Operator MOD. Alone for whole (If it is used with floating
          the value is rounded)
        ABS (Range: -1e4932 ..1e4932)
        ATAN (Range: -1e4932 ..1e4932)
        COS (Range: -1e18 ..1e18)
        EXP (Range: -11356 ..11356)
        LN (Range: 0 ..1e4932)
        ROUND (Range: -1e9 ..1e9)
        SIN (Range: -1e18 ..1e18)
        SQRT (Range: 0 ..1e4932)
        SQR (Range: -1e2446 ..1e2446)
        TRUNC (Range: -1e9 ..1e9)

##Use:

--------------------------------------------------------------------

Firstly, in the property Funcion, the string that it contains the function or
expression to evaluate should be assigned, later calls himself to the method
"Parse", if no error happens in the process of Parser, the value of the
evaluated function will be returned in the ParseValor property, and if an
error happens, the property "ParseError" returns a "True", and the event
"OnParserError" is fired, where one of those specific parameters shows the error
type that happened in the process of Parser...

To be able to respond to definitions of Variables inside the Expression or
function to evaluate, you can use the event "OnPideVariable" which is an event
that it is fired when the parser finds a variable and requests a numeric value
to substitute it, the opposing variable spends as the oneVariable parameter,
and the Value with which the variable should be substituted it is returned in
the Par�metro value, another parameter is also included for to determine that
it is not a permissible variable, returning in the parameter "Found" a
"False". The way that you define the code for this event will determine if the
parser will be CaseSensitive or CaseInsensitive.

: -)

The demo included is a clear example of the use of this component, evaluating
and plotting functions of 2 variables, and dislpaying a 3D graph.

## Installation:

---------------------------------------------------------

This component works for all the versions of Delphi, please communicate if you
have problems proving this component with some of these versions.

To install it follow these steps:

1. - in Delphi you go to the menu: "Component / Install Component" (this is in
Delphi 2 +, since the way of installing components is different in Delphi 1:
OPTIONS / INSTALL COMPONENTS") and then select the file "FuncionParser.pas"

2.- if you can't install the component individually, then you can install the
package "CGTPkg.dpk" opening the package and choosing "Install"

3.- the component will settle in the Tab of "CGT" like "FuncionParser ".


## License:
---------------------------------------------------------
  
This component is Freeware, and you are free of to redistribute it and to use
it in your applications, alone please mentions my name in the documentation of
your program, (if it is not a lot of nuisance), or send me a postcard of
gratefulness.


: -)
