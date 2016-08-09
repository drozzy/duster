-module(duster_kill_pid_test).

-include_lib("eunit/include/eunit.hrl").

cast_call_test_() ->
	[
		{
			"Should succeed when casting",
			{setup, fun start/0, fun stop/1, fun ensure_cast_succeeds/1}
		},
		{
			"Should fail when calling",
			{setup, fun start/0, fun stop/1, fun ensure_call_fails/1}
		}
	].
start() ->
	% Start the supervised process
	{ok, Duster} = duster:start(),
	% Kill it
	exit(Duster, {error, boom}),
	Duster.

stop(_) ->
	ok.

ensure_cast_succeeds(Pid) ->
	[
		?_assertEqual(ok, duster:cast(Pid, foo))
	].

ensure_call_fails(Pid) ->
	[
		?_assertExit({noproc, _}, duster:call(Pid, bar))
	].