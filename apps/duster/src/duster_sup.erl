-module(duster_sup).
-export([start_link/0]).

-behaviour(supervisor).
-export([init/1]).
-export([new/0]).
-define(SERVER, ?MODULE).

start_link() ->
	supervisor:start_link({local, ?SERVER}, ?MODULE, {}).

new() ->
	Child1 =
		{duster,
			{duster, start_link, []},
			permanent, 5000, worker,
			[duster]},

	supervisor:start_child(?SERVER, Child1).

%% @private
init({}) ->
	
	RestartStrategy = {one_for_one, 5, 10},
	{ok, {RestartStrategy, []}}.