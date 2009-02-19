## aop.io

### before and after

	b := Object clone do(
		aMethod := method(i,
			"original aMethod: #{i}" interpolate println
		)
		
		before("aMethod",
			block(i,
				"before aMethod: #{i}" interpolate println
			)
		)
		
		after("aMethod",
			block(i,
				"after aMethod: #{i}" interpolate println
			)
		)
	)
	
	b aMethod(42) # ==>
	before aMethod: 42
	original aMethod: 42
	after aMethod: 42

## compose.io

	a := block(x, x + 4)
	b := block(y, y / 2)

### compose

	a compose(b) call(4) # ==> 6
	b compose(a) call(4) # ==> 4

### *

	(a * b) call(4) println # ==> 6
	(b * a) call(4) println # ==> 4

## into.io

	list(1, 5, 2, 4, 3) max into(n, n * n) # ==> 25

## seqasb.io

	"x, y -> x + y" asB # ==>
	method(x, y, 
    x + y
	)
	
	"_ isOdd" asB # ==>
	method(_, 
    _ isOdd
	)
	
	"**" asB  # ==> 
	method(x, y, 
    x ** y
	)
	
	"** 2" asB # ==>
	method(_, 
    _ ** 2
	)

## tap.io

	list(1, 2, 3, 4, 5) tap(l, l pop println) append(6) # ==>
	5
	==> list(1, 2, 3, 4, 6)

## y.io

	factorial := y call(
		block(callback,
			block(arg,
				if(arg == 0, 1, arg * callback call(arg - 1))
  		)
  	)
	)

	factorial call(5)  # ==> 120
