duster
======

_What happens when the process bites the dust._


This example shows that sending a message to a non-existent
Pid using gen_server only produces an error if a `gen_server:call`
function is used. When using `gen_server:cast` the message is simply
sent into nothingness.

That is why, if you want to make sure the message arrived at its destination,
always use `gen_server:call` and confirm the receipt with a simple
`gen_server:reply(From, ok)` in the handler. After which, you can
carry on your processing.
