(
s.waitForBoot({
	// --- SYNTHS ---
	SynthDef(\naggingPulse, { |out=0, freq=1200, amp=0.02, pan=0|
		var sig = SinOsc.ar(freq) * LFPulse.ar(8).range(0, 1);
		var env = EnvGen.kr(Env.perc(0.001, 0.05), doneAction: 2);
		Out.ar(out, Pan2.ar(sig * env * amp, pan));
	}).add;

	SynthDef(\heavyClock, { |out=0, freq=60, amp=0.2|
		var sig = SinOsc.ar(freq) * EnvGen.kr(Env.perc(0.01, 0.3), doneAction: 2);
		Out.ar(out, Pan2.ar(sig * amp, 0));
	}).add;

	s.sync;

	// --- COMPOSITION --- Irritation
	Pdef(\theBedroom, 
		Ppar([
			// The heavy, slow passage of time
			Pbind(
				\instrument, \heavyClock,
				\dur, 1,
				\amp, 0.15
			),
			// The "Nagging" high-frequency pulse
			Pbind(
				\instrument, \naggingPulse,
				\dur, Pseq([0.125, 0.125, 0.25, 0.5], inf),
				\freq, Pwhite(1200, 1500),
				\amp, 0.03,
				\pan, Pwhite(-0.2, 0.2)
			)
		])
	).play(TempoClock(80/60));
});
)
