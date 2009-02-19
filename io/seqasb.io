Regex

Sequence asB := method(
	if(self containsSeq("->"),
		return doString("block(#{self beforeSeq(\"->\")}, #{self afterSeq(\"->\")})" interpolate)
	)

	if(self containsSeq("_") and self matchesRegex("\\w+_\\w+") not,
		return doString("block(_, #{self})" interpolate)
	)

	if(self asMutable strip in(list("+", "-", "/", "%", "^", "&", "*", "**", "==", ">", "<", ">=", "<=", "..", "<<", ">>")),
		return doString("block(x, y, x #{self} y)" interpolate)
	)

	doString("block(_, _ #{self})" interpolate)
)
