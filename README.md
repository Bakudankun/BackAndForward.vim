# BackAndForward.vim

This is a simple plugin to add `:Back` and `:Forward` commands that do `<C-O>`
and `<C-I>` but in file units, like going back and forward in web browsers.
Also, `<A-Left>` and `<A-Right>` are mapped to go back and forward by default.

It is recommended to `:set jumpoptions+=stack` to make the jump list more
predictable.
