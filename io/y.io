# This is direct port of ruby Y combinator implementation from http://www.eecs.harvard.edu/~cduan/technical/ruby/ycombinator.shtml

# More info:
# http://en.wikipedia.org/wiki/Y_Combinator
# http://www.eecs.harvard.edu/~cduan/technical/ruby/ycombinator.shtml
# http://weblog.raganwald.com/2007/02/but-y-would-i-want-to-do-thing-like.html

y := block(generator,
	block(x,
		block(
			generator call(x call(x)) performOn(call target, call sender, call message)
		)
	) call(
		block(x,
			block(
				generator call(x call(x)) performOn(call target, call sender, call message)
			)
		)
	)
)
