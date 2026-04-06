(
s.waitForBoot({
	// --- SYNTHS ---
	SynthDef(\keyboardStab, { |out=0, amp=0.1, pan=0|
		var click = SinOsc.ar(ExpRand(4000, 7000)) * EnvGen.ar(Env.perc(0.001, 0.01));
		var clack = BPF.ar(WhiteNoise.ar, ExpRand(500, 1500), 0.5) * EnvGen.ar(Env.perc(0.001, 0.03));
		var sig = (click + clack) * EnvGen.kr(Env.perc(0.001, 0.08), doneAction: 2);
		Out.ar(out, Pan2.ar(sig * amp, pan));
	}).add;

	SynthDef(\packet, { |out=0, amp=0.05|
		var sig = BPF.ar(WhiteNoise.ar, ExpRand(2000, 8000), 0.2);
		var env = EnvGen.kr(Env.perc(0.001, 0.01), doneAction: 2);
		Out.ar(out, Pan2.ar(sig * env * amp, 0));
	}).add;

	s.sync;

	// --- COMPOSITION --- Hollow Conformity
	Pdef(\theParty, 
		Ppar([
			// Fragmented "Social Chatter"
			Pbind(
				\instrument, \keyboardStab,
				\dur, Pwhite(0.1, 0.4),
				\amp, Pwhite(0.05, 0.1),
				\pan, Pwhite(-0.9, 0.9)
			),
			// Occasional hollow glitches
			Pbind(
				\instrument, \packet,
				\dur, Pwhite(0.5, 2.0),
				\amp, 0.08
			)
		])
	).play(TempoClock(120/60));
});
)
