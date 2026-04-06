(
s.waitForBoot({
	// --- SYNTHS ---

	// 1. Digital "Data" Synth
	SynthDef(\dataTone, { |out=0, freq=440, modFreq=100, index=5, amp=0.05, pan=0, release=0.2|
		var mod = SinOsc.ar(modFreq, 0, modFreq * index);
		var sig = SinOsc.ar(freq + mod);
		var env = EnvGen.kr(Env.perc(0.001, release), doneAction: 2);
		sig = HPF.ar(sig, 200);
		Out.ar(out, Pan2.ar(sig * env * amp, pan));
	}).add;

	// 2. Glitch "Packet" Synth
	SynthDef(\packet, { |out=0, amp=0.05, pan=0|
		var sig = BPF.ar(WhiteNoise.ar, ExpRand(2000, 12000), 0.1);
		var env = EnvGen.kr(Env.perc(0.001, 0.01), doneAction: 2);
		Out.ar(out, Pan2.ar(sig * env * amp, pan));
	}).add;

	// 3. Deep "Sub-Brain" Bass Synth (Bit-Crunch)
	SynthDef(\subBrain, { |out=0, freq=55, amp=0.4, pan=0, release=0.8, cutoff=300, bits=6|
		var sig = Pulse.ar(freq, 0.5) + Saw.ar(freq * 1.01);
		var env = EnvGen.kr(Env.perc(0.02, release), doneAction: 2);
		sig = LPF.ar(sig, cutoff.lag(1));
		sig = (sig * 2).distort; 
		sig = sig.round(0.5**bits); 
		sig = FreeVerb.ar(sig, 0.3, 0.4, 0.9);
		sig = LeakDC.ar(sig);
		Out.ar(out, Pan2.ar(sig * env * amp, pan));
	}).add;

	// 4. Claustrophobic Morphing Drone
	SynthDef(\claustroDrone, { |out=0, freq=110, amp=0.1, pan=0, gate=1|
		var sig, morph, resonance, env;
		env = EnvGen.kr(Env.asr(2, 1, 2), gate, doneAction: 2);
		morph = LFNoise1.kr(0.1).range(0.2, 0.8);
		sig = VarSaw.ar(freq.lag(2) * [0.99, 1, 1.01], 0, morph);
		resonance = BPF.ar(sig, LFNoise1.kr(0.06).exprange(400, 2000), 0.5);
		sig = (sig * 0.4) + (resonance * 0.6);
		sig = LPF.ar(sig, 1800);
		sig = LeakDC.ar(sig);
		Out.ar(out, Pan2.ar(sig * amp * env, pan));
	}).add;

	// 5. Mechanical "Typewriter" Stab
	SynthDef(\keyboardStab, { |out=0, amp=0.1, pan=0, release=0.05|
		var click, clack, sig, env;
		env = EnvGen.kr(Env.perc(0.001, release), doneAction: 2);
		click = SinOsc.ar(ExpRand(6000, 9000)) * EnvGen.ar(Env.perc(0.001, 0.01));
		clack = BPF.ar(WhiteNoise.ar, ExpRand(1000, 3000), 0.3) * EnvGen.ar(Env.perc(0.001, 0.03));
		sig = (click + clack) * 2;
		sig = sig + CombN.ar(sig, 0.2, 0.15, 0.6);
		Out.ar(out, Pan2.ar(sig * env * amp, pan));
	}).add;

	// 6. Sub-Rumbly Measure "Thud"
	SynthDef(\rumblyThud, { |out=0, amp=0.2, pan=0|
		var sub, noise, sig, env, pEnv;
		env = EnvGen.kr(Env.perc(0.01, 0.4), doneAction: 2);
		pEnv = EnvGen.ar(Env.perc(0.001, 0.1));
		sub = SinOsc.ar(45 * (1 + (pEnv * 2)));
		noise = LPF.ar(WhiteNoise.ar, 100) * 0.2;
		sig = (sub + noise) * env;
		sig = (sig * 2.5).distort; 
		Out.ar(out, Pan2.ar(sig * amp, pan));
	}).add;

	// 7. Urgency "Data Alert" Synth
	SynthDef(\dataAlert, { |out=0, freq=600, amp=0.1, pan=0, rate=4, release=0.1|
		var sig, env, mod;
		env = EnvGen.kr(Env.perc(0.01, release), doneAction: 2);
		mod = LFPulse.ar(rate).range(0.2, 1);
		sig = Saw.ar([freq, freq * 1.06]) * mod;
		sig = BPF.ar(sig, freq * 1.5, 0.2);
		sig = (sig * 3).distort * 0.4;
		Out.ar(out, Pan2.ar(sig.sum * env * amp, pan));
	}).add;

	// 8. Metallic "Mallet Roll" Swell
	SynthDef(\malletRoll, { |out=0, amp=0.1, pan=0, sustain=2|
		var sig, env, resonances;
		env = EnvGen.kr(Env.sine(sustain), doneAction: 2);
		resonances = [
			452, 632, 843, 1032, 1422, 2321, 3543, 4921, 6211
		];
		sig = Klank.ar(`[resonances, nil, [1, 1, 1, 1, 1, 0.5, 0.3, 0.2, 0.1]], PinkNoise.ar(0.01));
		sig = HPF.ar(sig, 2000); 
		sig = sig * env * amp;
		Out.ar(out, Pan2.ar(sig, pan));
	}).add;

	s.sync;

	// --- COMPOSITION ---
	Pdef(\computerBrain, 
		Pfindur(64 * 5,
			Ppar([
				// Mallet Rolls (Longer Swells)
				Pbind(
					\instrument, \malletRoll,
					\dur, 8,
					\sustain, 6, // Increased length
					\amp, 0.05,
					\pan, Pwhite(-0.7, 0.7)
				),

				// Data Alert (Urgency)
				Pbind(
					\instrument, \dataAlert,
					\dur, Pseq([0.25, 0.25, 0.5], inf),
					\freq, Pstep(Pseq([600, 850, 450, 700], inf), 16 * 5),
					\rate, Pseg(Pseq([2, 12], inf), 16 * 5, \exp),
					\amp, Pif(Pwhite(0, 1) > 0.6, 0.25, 0), 
					\pan, Pwhite(-0.5, 0.5)
				),

				// Measure Anchor (The Thud)
				Pbind(
					\instrument, \rumblyThud,
					\dur, 5, 
					\amp, 0.6,
					\pan, 0
				),

				// Drone
				Pmono(\claustroDrone,
					\dur, 16 * 5, 
					\freq, Pseq([110, 103, 116, 82], inf),
					\amp, 0.28,
					\pan, Pwhite(-0.2, 0.2)
				),

				// Typewriter Action
				Pbind(
					\instrument, \keyboardStab,
					\dur, Pseq([
						Pn(0.125, 4), 
						Pwhite(0.5, 2.0, 1), 
						Pn(0.25, 2), 
						Pwhite(1.0, 4.0, 1) 
					], inf),
					\amp, Pwhite(0.05, 0.12),
					\pan, Pwhite(-0.9, 0.9)
				),

				// Pulse Clock (Bumped 10%)
				Pbind(
					\instrument, \dataTone,
					\dur, 1,
					\freq, Pseq([880, 440, 440, 440, 440], inf),
					\amp, Pstep(Pseq([0.055, 0.033, 0.066, 0.033], inf), 16 * 5),
					\release, 0.1
				),
				
				// Processing Logic (Bumped 10%)
				Pbind(
					\instrument, \dataTone,
					\dur, Pseq([0.75, 0.75, 0.5], inf),
					\note, Pseq([0, 7, 12, 19, 24].scramble, inf),
					\ctranspose, Pstep(Pseq([0, -2, 3, -12], inf), 16 * 5),
					\amp, Pwhite(0.033, 0.077),
					\pan, Pwhite(-0.8, 0.8)
				),
				
				// Heavy Bass (Remove last note every 5th iteration)
				Pbind(
					\instrument, \subBrain,
					\dur, Pseq([4, 2, 3], inf), 
					\note, Pseq([
						Pseq([-12, -7, -5], 4),   // 1, 2, 3, 4
						Pseq([-12, -10, \rest], 1), // 5 (Short)
						Pseq([-12, -10, -8], 3), // 6, 7, 8
						Pseq([-12, -7, -5], 1),  // 9
						Pseq([-12, -7, \rest], 1), // 10 (Short)
						Pseq([-12, -7, -5], 2),  // 11, 12
						Pseq([-12, -10, -8], 2), // 13, 14
						Pseq([-12, -10, \rest], 1), // 15 (Short)
						Pseq([-12, -10, -8], 1)  // 16
					], inf),
					\ctranspose, Pstep(Pseq([0, -5, 2, -2], inf), 16 * 5),
					\cutoff, Pwhite(250, 700),
					\bits, Pwhite(4, 10), 
					\amp, 0.3,
					\release, 4.0
				),
				
				// Packet Glitches
				Pbind(
					\instrument, \packet,
					\dur, Pwhite(0.1, 0.5),
					\amp, Pif(Pwhite(0, 1) > 0.8, 0.1, 0),
					\pan, Pwhite(-1, 1)
				)
			])
		)
	).play(TempoClock(125/60));
});
)
