-module(main).
-compile(export_all).
-author("").


setup_loop(N, 1) ->
	spawn(watcher, start_watcher, [N, 1, []]);
setup_loop(N, Num_watchers) ->
	spawn(watcher, start_watcher, [10, N-9, []]),
	setup_loop(N-10, Num_watchers-1).

start() ->
	{ok,[N]} = io:fread("enter  number  of sensors > ", "~d"),
	if N =< 1 ->
		io:fwrite("setup: range  must be at  least  2~n", []);
	true  ->
		Num_watchers = 1 + (N div 10),
		setup_loop(N, Num_watchers)
	end.