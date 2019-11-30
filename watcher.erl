-module(watcher).
-compile(export_all).
-author("").

watcher(Sensors) ->
	receive
		{ID, Measurement} ->
			io:format("Sensor ~w got measurement ~w~n", [ID, Measurement]),
			watcher(Sensors);
		{}

