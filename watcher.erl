-module(watcher).
-compile(export_all).
-author("").

watcher(Sensors) ->
	receive
		{SensorID, Measurement} ->
			io:format("Sensor ~w got measurement ~w~n", [SensorID, Measurement]),
			watcher(Sensors);
		{'DOWN', _Ref, process, PID, Reason} ->
			io:format("whatcher received error from pid ~w~n", [PID]),
			{SensorID, _} = lists:keyfind(PID, 2, Sensors),
			io:fwrite("Sensor ~w crashed with reason: ~w~n", [SensorID, Reason]),
			{NewPid, _} = spawn_monitor(sensor, sensor, [self(), SensorID]),
			UpdatedList = lists:keyreplace(PID, 2, Sensors, {SensorID, NewPid}),
			io:fwrite("Watcher updated sensor list to: ~w", [UpdatedList]),
			watcher(UpdatedList)
	end.

start_watcher(0, SensorID, Sensor_List) ->
	io:fwrite("Initial sensor list: ~w~n", [Sensor_List]),
	watcher(Sensor_List);

start_watcher(Num_Sensor, SensorID, Sensor_List) ->
	{Pid, _Ref} = spawn_monitor(sensor, sensor, [self(), SensorID]),
	start_watcher(Num_Sensor-1, SensorID+1, Sensor_List++[{SensorID, Pid}]).
	



