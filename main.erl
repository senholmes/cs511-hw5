-module(main).
-compile(export_all).
-author("").


setup_loop(N, 1) ->
	spawn(watcher, _, [1, N]);
setup_loop(N, Num_watchers) ->
	Num_sensor = _,
	spawn(watcher, _, [Num_watchers-1, Num_sensor]),
	setup_loop(N-Num_sensor, Num_watchers-1).




start() ->
	{ok,[N]} = io:fread("enter  number  of sensors > ", "~d"),
	if N =< 1 ->
		io:fwrite("setup: range  must be at  least  2~n", []);
	true  ->
		Num_watchers = 1 + (N div 10),
		setup_loop(N, Num_watchers)
	end.