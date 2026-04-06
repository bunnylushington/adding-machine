(
s.waitForBoot({
	// --- SYNTHS ---
	SynthDef(\dataTone, { |out=0, freq=440, amp=0.05, release=0.1|
		var sig = SinOsc.ar(freq);
		var env = EnvGen.kr(Env.perc(0.001, release), doneAction: 2);
		Out.ar(out, Pan2.ar(sig * env * amp, 0));
	}).add;

	SynthDef(\keyboardStab, { |out=0, amp=0.1, pan=0|
		var click = SinOsc.ar(ExpRand(6000, 9000)) * EnvGen.ar(Env.perc(0.001, 0.01));
		var clack = BPF.ar(WhiteNoise.ar, ExpRand(1000, 3000), 0.3) * EnvGen.ar(Env.perc(0.001, 0.03));
		var sig = (click + clack) * EnvGen.kr(Env.perc(0.001, 0.05), doneAction: 2);
		Out.ar(out, Pan2.ar(sig * amp, pan));
	}).add;

	SynthDef(\fluorescentHum, { |out=0, amp=0.03|
		var sig = LFTri.ar(60 * [1, 2, 4, 13.5]) * [1, 0.5, 0.25, 0.1];
		sig = BPF.ar(sig.sum, LFNoise1.kr(0.2).range(3000, 4000), 0.1);
		Out.ar(out, Pan2.ar(sig * amp, 0));
	}).add;

	s.sync;

	// --- COMPOSITION --- Monotony
	Pdef(\theLedger, 
		Ppar([
			Pmono(\fluorescentHum, \amp, 0.04),
			// Constant 5/4 Clock
			Pbind(
				\instrument, \dataTone,
				\dur, 1,
				\freq, Pseq([880, 440, 440, 440, 440], inf),
				\amp, 0.03
			),
			// Continuous Typing
			Pbind(
				\instrument, \keyboardStab,
				\dur, Pseq([0.25, 0.25, 0.5, 0.25, 0.75], inf),
				\amp, Pwhite(0.02, 0.06),
				\pan, Pwhite(-0.5, 0.5)
			)
		])
	).play(TempoClock(100/60));
});
)
