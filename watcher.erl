-module(watcher).
-compile(export_all).
-author("").

watcher(Sensors) ->
	receive
		{SensorID, Measurement} ->
			io:format("Sensor ~w got measurement ~w~n", [ID, Measurement]),
			watcher(Sensors);
		{'DOWN', _Ref, _Process, PID, Reason} ->
			{SensorID, _} = lists:keyfind(PID, 1, Sensors),
			io:fwrite("Sensor ~w crashed with reason: ~w~n", [SensorID, Reason]),
			{Pid, _Ref} -> spawn_monitor(sensor, sensor, [self(), SensorID]),
			UpdatedList = lists:keyreplace(PID, 1, Sensors, {Pid, SensorID}),
			io:fwrite("Watcher updated sensor list to: ~w", [UpdatedList]),
			watcher(Sensors)
	end.


