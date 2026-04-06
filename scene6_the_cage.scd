(
s.waitForBoot({
	// --- SYNTHS ---
	SynthDef(\subBrain, { |out=0, freq=55, amp=0.4, release=4.0, cutoff=300, bits=4|
		var sig = Pulse.ar(freq, 0.5) + Saw.ar(freq * 1.01);
		var env = EnvGen.kr(Env.perc(0.02, release), doneAction: 2);
		sig = LPF.ar(sig, cutoff) * 2;
		sig = sig.round(0.5**bits).distort; 
		sig = FreeVerb.ar(sig, 0.4, 0.6, 0.2); // Darker reverb
		Out.ar(out, Pan2.ar(sig * env * amp, 0));
	}).add;

	SynthDef(\rumblyThud, { |out=0, amp=0.6|
		var sub = SinOsc.ar(40 * (1 + EnvGen.ar(Env.perc(0.001, 0.1))));
		var env = EnvGen.kr(Env.perc(0.01, 0.8), doneAction: 2);
		var sig = sub * env;
		Out.ar(out, Pan2.ar(sig.distort * amp, 0));
	}).add;

	SynthDef(\claustroDrone, { |out=0, freq=55, amp=0.1|
		var sig = VarSaw.ar(freq * [0.99, 1, 1.01], 0, 0.5);
		sig = BPF.ar(sig.sum, LFNoise1.kr(0.05).exprange(100, 500), 0.1);
		Out.ar(out, Pan2.ar(sig * amp, 0));
	}).add;

	s.sync;

	// --- COMPOSITION --- Oppression
	Pdef(\theCage, 
		Ppar([
			Pmono(\claustroDrone, \freq, 41.2, \amp, 0.2), // Low E hum
			// Very slow thud (The weight of the system)
			Pbind(
				\instrument, \rumblyThud,
				\dur, 10,
				\amp, 0.5
			),
			// Distant, heavy bass
			Pbind(
				\instrument, \subBrain,
				\dur, Pseq([6, 4], inf),
				\note, Pseq([-12, -17, -15], inf),
				\amp, 0.3,
				\release, 6.0
			)
		])
	).play(TempoClock(60/60)); // Slow heart rate
});
)
