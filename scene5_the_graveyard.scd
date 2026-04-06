(
s.waitForBoot({
	// --- SYNTHS ---
	SynthDef(\graveyardWind, { |out=0, amp=0.05|
		var sig = LPF.ar(WhiteNoise.ar, LFNoise1.kr(0.1).range(100, 600));
		sig = FreeVerb.ar(sig, 0.4, 0.8, 0.5);
		Out.ar(out, Pan2.ar(sig * amp, 0));
	}).add;

	SynthDef(\malletRoll, { |out=0, amp=0.1, pan=0, sustain=8|
		var resonances = [452, 632, 843, 1032, 1422];
		var sig = Klank.ar(`[resonances, nil, [1, 1, 1, 0.5, 0.3]], PinkNoise.ar(0.01));
		var env = EnvGen.kr(Env.sine(sustain), doneAction: 2);
		sig = HPF.ar(sig, 200) * env * amp;
		sig = FreeVerb.ar(sig, 0.6, 0.9, 0.2);
		Out.ar(out, Pan2.ar(sig, pan));
	}).add;

	s.sync;

	// --- COMPOSITION --- Surreal Guilt
	Pdef(\theGraveyard, 
		Ppar([
			Pmono(\graveyardWind, \amp, 0.08),
			// Distant, echoing mallet rolls
			Pbind(
				\instrument, \malletRoll,
				\dur, Pwhite(8.0, 15.0),
				\sustain, 10,
				\amp, 0.04,
				\pan, Pwhite(-0.7, 0.7)
			)
		])
	).play(TempoClock(60/60));
});
)
