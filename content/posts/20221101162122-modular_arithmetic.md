+++
title = "Modular Arithmetic"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Math]({{< relref "20221101134840-math.md" >}})

> `100mod8 = r`: 8 is called the modulus, `r` be +ve no. Sometimes, we are only interested in what the remainder is when we divide A by B. For these cases there is an operator called the modulo operator (abbreviated as mod).

-   `100mod8` = `100%8` = `100/8 ka remainder` = `100 - (8*12)` = 4
-   `-100mod8` = `-100%8` = `8 - (100/8 ka remainder)` = `-100 - (8*(-13))` = 4


## What? {#what}

-   All integers can be expressed as 0, 1 or 2, or in modulo 3
    -   Expressing integers in terms of their remainder when divided by 3
-   Clock is modulo 12


## Modular exponentiation {#modular-exponentiation}

-   \\(A^B mod C = ( (A mod C)^B ) mod C\\)
-   \\(A^2 mod C = ( (A mod C) x (A mod C) ) mod C\\)
-   Often we want to calculate A^B mod C for large values of B.
-   Unfortunately, A^B becomes very large for even modest sized values for B.
