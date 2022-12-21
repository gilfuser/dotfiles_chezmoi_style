defer{ Server.killAll };
q = q ? ();

" >>>>>>>>>>>>> startup GERAL <<<<<<<<<<<<<".postln;
"\n**********  loading serverConfig:  **********".postln;
// more latency gives more accurate timing and quantizing. Less latency gives better instrument feeling with imediate response
s.latency = 0.02;
s.options
.numAudioBusChannels_(128 * 16)	 // for proxy usage: lots of ar bus space 1024
.zeroConf_(false)
.memSize_(8192 * 32)		 // 512 MB This memory is used to allocate synths! 64 increase this if you get "alloc failed" messages
.hardwareBufferSize_(256)
.maxNodes_(1024 * 32)		 // lots of synth nodes 16 increase this if you are getting drop outs and the message "too many nodes"
.maxSynthDefs_(1024 *2)
.numWireBufs_(64 * 32)			 // fat synthdefs need lots of interconnects
.numOutputBusChannels_(2)
.numBuffers_(1024 * 32) // increase this if you need to load more samples
// .device_("Fireface 400 (297)")	// device name
.numInputBusChannels_(2)
.numOutputBusChannels_(10);
// .sampleRate_(4800)
// .device = "ASIO : ASIO4ALL v2"; // set this to your hardware output channel size, if necessary
s.recChannels_(10);
// .blockSize_(64)					//  .kr bus rate, default is 64 samples
//  32 samples makes possible lower latency
// .hardwareBufferSize_(128)		// take fastest power of two hardware allows

q.startupConfig = ();
s.waitForBoot({
    s.sync;
    0.2.wait;
    "~/SuperCollider/interface/midiOut.scd".standardizePath.load;
    5.wait;
    t = TempoClock.default;
    q.mod = MFunc(); "q.mod = MFunc\n".postString;
    Pdefn(\scale, Scale.choose(7, 12)).source.name;

    // stereo insert FX
    SynthDef(\vst_fx, { |out| Out.ar( out, VSTPlugin.ar( \in.ar(0 ! 2), s.options.numOutputBusChannels ) ) }).add;
    // VST instrument (stereo)
    SynthDef(\vsti, { |out| Out.ar(out, VSTPlugin.ar(nil, 2)) }).add;
    // VSTPlugin.search(s, options: (timeout: 60 ) );
    s.sync;
    wait(1);
    "~/SuperCollider/interface/proxySpace_Stuff.scd".standardizePath.load;
    0.2.wait;
    "~/SuperCollider/interface/linkClock_Stuff.scd".standardizePath.load;
    0.1.wait;
    "~/SuperCollider/libs/_colecoes.scd".standardizePath.load;
    0.1.wait;
    "~/SuperCollider/libs/_SynthLib.scd".standardizePath.load;
    // TODO: distortion!
    0.1.wait;
    "~/SuperCollider/FX/_fxFunc.scd".standardizePath.load;
    // TODO: distortion!
    0.1.wait;
    "~/SuperCollider/FX/_fxLib.scd".standardizePath.load;
    0.2.wait;
    "~/SuperCollider/libs/_SampleLib_player-SynthDefs.scd".standardizePath.load;
    "~/SuperCollider/libs/_SampleLib_loadSamples.scd".standardizePath.load;
    wait(70);
    "~/SuperCollider/toca/swingfy.scd".standardizePath.load; // a
    0.2.wait;
    q.numOrbs = 4; // escolher quantas orbits serão usadas em Ndefs
    "~/SuperCollider/interface/superDirt_startup.scd".standardizePath.load;
    wait(0.2);
    "~/SuperCollider/instruments/mamMB33_MIDI.scd".standardizePath.load;
    s.sync;
    30.wait;
    "~/SuperCollider/instruments/tidalInstruments.scd".standardizePath.load;
    wait(0.2);
    "~/SuperCollider/FX/myTidalFx.scd".standardizePath.load;
    // TODO: já há como checar no Tidal? Mostra os parâmetros?
    0.2.wait;
    "~/SuperCollider/interface/tidal_set_FX.scd".standardizePath.load;
    // TODO: q.printTidalSetFx. Fazer equivalente no Tidal (como?)
    0.2.wait;
    "~/SuperCollider/FX/FXXX_orbs.scd".standardizePath.load;
    0.2.wait;
    "~/SuperCollider/FX/vstFX_orbs.scd".standardizePath.load;
    wait(10);
    0.2.wait;
    "~/SuperCollider/FX/mainFX.scd".standardizePath.load;
    s.sync;
    1.wait;
    "~/SuperCollider/FX/vstMainFX.scd".standardizePath.load;
    wait(0.2);
    "~/SuperCollider/interface/gui_Stuff.scd".standardizePath.load;
    wait(1.2);
    "~/SuperCollider/interface/modality-mpk.scd".standardizePath.load;
    // s.sync;
    wait(2.2);
    "~/SuperCollider/interface/Modality_MPKmini/keyboard_mpk.scd".standardizePath.load;

    /*
    "~/SuperCollider/interface/mainFX.scd".standardizePath.load;
    HelpBrowser.instance
    s.quit
    TODO Check livecodeThis/AlgoraveBR
    TODO: KtlLoop
    TODO: Influx
    TODO: KeyPlayer
    TODO: TouchOSC Modality
    TODO: GUI para escolher o que usar no momento
    (qual plataforma?, scide ou scnvim?, algum midi synth?, mpk mini? tOSC?, microcontrolador?, tidal?, samples?,fxFuncs?, fxLib?,  proxyChain?, keyPlayer?, proxyPreset?, proxySubMix?, mainFx?, influx?, ktlLoop? VSTs? )
    TODO: check Phrase
    */

});

// "~/SuperCollider/libs/_vstPlugins.scd".standardizePath.load;
// "~/SuperCollider/processes/vst_q-acid.scd".standardizePath.load; wait(12);
// "~/SuperCollider/processes/vsti_q-drum.scd".standardizePath.load;
// wait(10);
// "processes/tunel.scd".loadRelative;
// "~/SuperCollider/processes/dubba.scd".standardizePath.load;
// "FX/subMix.scd".loadRelative;
