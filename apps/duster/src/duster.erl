-module(duster).
-export([start/0, start_link/0]).

-behaviour(gen_server).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([call/2, cast/2]).

start_link() ->
	gen_server:start_link(?MODULE, {}, []).

%% This is for testing only - so that it doesn't bring down
%% our unit test when we kill it
start() ->
	gen_server:start(?MODULE, {}, []).

%% Id -> Pid
-record(state, {blah}).

%% @private
init({}) ->
	{ok, #state{}}.

call(Pid, Msg) ->
	gen_server:call(Pid, {call, Msg}).	

cast(Pid, Msg) ->
	gen_server:cast(Pid, {cast, Msg}).

handle_call({call, Msg}, _From, State) ->
	io:format("Called with message: ~p~n", [Msg]),
	{reply, ok, State};


%% @private
handle_call(_Request, _From, State) ->
	{reply, {error, unknown_call}, State}.

handle_cast({cast, Msg}, State) ->
	io:format("Cast with message: ~p~n", [Msg]),
	{noreply, State};
%% @private
handle_cast(_Msg, State) ->
	{noreply, State}.

%% @private
handle_info(_Info, State) ->
	{noreply, State}.

%% @private
terminate(_Reason, _State) ->
	ok.

%% @private
code_change(_OldVsn, State, _Extra) ->
	{ok, State}.