(
s.waitForBoot({
	// --- SYNTHS ---
	SynthDef(\dataTone, { |out=0, freq=440, amp=0.05, release=5.0|
		var sig = SinOsc.ar(freq);
		var env = EnvGen.kr(Env.perc(1.0, release), doneAction: 2); // Slow attack
		sig = FreeVerb.ar(sig, 0.8, 0.9, 0.1);
		Out.ar(out, Pan2.ar(sig * env * amp, 0));
	}).add;

	SynthDef(\malletRoll, { |out=0, amp=0.1, pan=0, sustain=10|
		var resonances = [452, 632, 843, 1032, 1422, 2321, 3543, 4921, 6211];
		var sig = Klank.ar(`[resonances, nil, [1, 1, 1, 1, 1, 0.5, 0.3, 0.2, 0.1]], PinkNoise.ar(0.01));
		var env = EnvGen.kr(Env.sine(sustain), doneAction: 2);
		sig = HPF.ar(sig, 200) * env * amp;
		sig = FreeVerb.ar(sig, 0.5, 0.9, 0.5);
		Out.ar(out, Pan2.ar(sig, pan));
	}).add;

	s.sync;

	// --- COMPOSITION --- Afterlife
	Pdef(\theElysianFields, 
		Ppar([
			// Overlapping Mallet Swells
			Pbind(
				\instrument, \malletRoll,
				\dur, 4,
				\sustain, 12,
				\amp, 0.08,
				\pan, Pwhite(-0.8, 0.8)
			),
			// Echoes of the "Data" Notes
			Pbind(
				\instrument, \dataTone,
				\dur, Pwhite(2.0, 5.0),
				\note, Pseq([0, 7, 12, 19, 24].scramble, inf),
				\octave, 6,
				\amp, 0.04
			)
		])
	).play(TempoClock(80/60));
});
)
