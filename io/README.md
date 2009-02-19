# aop.io

## before and after

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
	
	b aMethod(42) # =>
	before aMethod: 42
	original aMethod: 42
	after aMethod: 42

# compose.io

	a := block(x, x + 4)
	b := block(y, y / 2)

## compose

	a compose(b) call(4) println # => 6
	b compose(a) call(4) println # => 4

## *	

	(a * b) call(4) println # => 6
	(b * a) call(4) println # => 4

# into.io

	list(1, 5, 2, 4, 3) max into(n, n * n) # => 25

