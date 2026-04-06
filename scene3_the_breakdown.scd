(
s.waitForBoot({
	// --- SYNTHS ---
	SynthDef(\dataAlert, { |out=0, freq=600, amp=0.1, pan=0, rate=4|
		var sig = Saw.ar([freq, freq * 1.06]) * LFPulse.ar(rate).range(0.2, 1);
		var env = EnvGen.kr(Env.perc(0.01, 0.2), doneAction: 2);
		sig = BPF.ar(sig.sum, freq * 1.5, 0.2);
		Out.ar(out, Pan2.ar(sig * env * amp, pan));
	}).add;

	SynthDef(\packet, { |out=0, amp=0.05, pan=0|
		var sig = BPF.ar(WhiteNoise.ar, ExpRand(2000, 12000), 0.1);
		var env = EnvGen.kr(Env.perc(0.001, 0.01), doneAction: 2);
		Out.ar(out, Pan2.ar(sig * env * amp, pan));
	}).add;

	s.sync;

	// --- COMPOSITION --- Panic
	Pdef(\theBreakdown, 
		Ppar([
			// Accelerated Alert (Urgency speeds up)
			Pbind(
				\instrument, \dataAlert,
				\dur, Pseq([0.125, 0.125, 0.25], inf),
				\freq, Pseg(Pseq([400, 1200], inf), 8, \exp),
				\rate, Pseg(Pseq([4, 20], inf), 8, \lin),
				\amp, 0.15,
				\pan, Pwhite(-0.8, 0.8)
			),
			// Constant Glitch Burst (Packet Overload)
			Pbind(
				\instrument, \packet,
				\dur, Pwhite(0.05, 0.2),
				\amp, Pwhite(0.05, 0.15),
				\pan, Pwhite(-1, 1)
			)
		])
	).play(TempoClock(140/60));
});
)
