-module(sensor).
-compile(export_all).
-author("").

sensor(Watcher, ID) ->
	%create a random measurement
	Measurement = rand:uniform(11),
	%sleep for a random amount of time
	Sleep_time = rand:uniform(10000),
	timer:sleep(Sleep_time),

	%check if measurement in rande, error if not
	%send measurement to watcher if in range
	if Measurement == 11 ->
		exit(anomalous_reading);
	true ->
		Watcher!{ID, Measurement}
	end,
	sensor(Watcher, ID).
