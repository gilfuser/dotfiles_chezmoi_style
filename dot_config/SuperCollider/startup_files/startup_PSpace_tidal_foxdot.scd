q = q ? ();
"startup Tidal & FoxDot".postln;
/*
Task {
Server.killAll;
0.2.wait
}.play(AppClock);
*/

"\n**********  loading serverConfig:  **********".postln;

// Server.supernova;
// Server.default = s = Server.local;
// more latency gives more accurate timing and quantizing. Less latency gives better instrument feeling with imediate response
s.latency = 0.24;
s.options
.numAudioBusChannels_(128 * 16)	 // for proxy usage: lots of ar bus space 1024
.memSize_(8192 * 32)		 // 512 MB This memory is used to allocate synths! 64 increase this if you get "alloc failed" messages
.maxNodes_(1024 * 32)		 // lots of synth nodes 16 increase this if you are getting drop outs and the message "too many nodes"
.maxSynthDefs_(1024 *2)
.numWireBufs_(64 * 32)			 // fat synthdefs need lots of interconnects
.numOutputBusChannels_(2)
.numBuffers_(1024 * 32) // increase this if you need to load more samples
// .device_("Fireface 400 (297)")	// device name
.numInputBusChannels_(2)
.numOutputBusChannels_(4)
.devices.collect{ |d|
    case
    { d == "ASIO : Focusrite USB ASIO" } { s.options.sampleRate_(48000).device_(d) }
    { d == "ASIO : ASIO4ALL v2" } { s.options.sampleRate_(48000).device_(d) }
    { d == "MME : Microphone (Realtek(R) Audio)" } { s.options.inDevice = d }
    { d == "MME : Speakers (Realtek(R) Audio)" } { s.options.outDevice = d };
    "".postln;
};
// .sampleRate_(4800)
// .blockSize_(64)					//  .kr bus rate, default is 64 samples - 32 samples makes the lowest latency
// .hardwareBufferSize_(128)		// take fastest power of two hardware allows

s.waitForBoot({
    s.sync;
    // MIDIClient.init;
    s.recChannels_(2).recHeaderFormat.recSampleFormat_("float"); // float to recover from clipping
    q.postServerOptions = {
        "********** Server info : **********".postln;
        "s.name: % \n"
        "s.address: % \n"
        "s.latency: % \n"
        .postf(s.name, s.addr, s.latency);
        "server options:".postln;
        s.options.dump;
        // "********************".postln;
        // "serverConfig loaded.".postln;
        // "********************".postln;
        // "MIDI client initiated.".postln;
        "********************".postln;
    };
    "********** make TempoClock t ***********".postln;
    t = TempoClock.new.permanent_(true);
    t.tempo = 110/60/2;
    "********** make ProxySpace p ***********".postln;
    p = ProxySpace.push;
    p.know = true;
    p.makeTempoClock(110/60/2);
    p.clock; // now the ProxySpace's clock is a TempoBusClock
    //mais pesado, mas mais preciso
    ProxySynthDef.sampleAccurate = true;
    // ou assim. mais util se usar o mesmo clock para outras coisas além do ProxySpace
    p.quant = 1.0;
    p.fadeTime = 0;
    p.reshaping = \elastic;
    p.play;
    s.sync;
    0.2.wait;

    {
        // FoxDot.stop;
        0.1.wait;
        Troop.start;
        FoxDot.start;
		~dirt.stop; // stop any old ones, avoid duplicate dirt (if it is nil, this won't do anything)
		~dirt = SuperDirt(2, s); // two output channels, increase if you want to pan across more channels
		~dirt.loadSoundFiles;   // load samples (path containing a wildcard can be passed in)
		// for example: ~dirt.loadSoundFiles("/Users/myUserName/Dirt/samples/*");
		// s.sync; // optionally: wait for samples to be read
		~dirt.start(57120, 0 ! 12);   // start listening on port 57120, create two busses each sending audio to channel 0

		// optional, needed for convenient access from sclang:
		(
			~d1 = ~dirt.orbits[0]; ~d2 = ~dirt.orbits[1]; ~d3 = ~dirt.orbits[2];
			~d4 = ~dirt.orbits[3]; ~d5 = ~dirt.orbits[4]; ~d6 = ~dirt.orbits[5];
			~d7 = ~dirt.orbits[6]; ~d8 = ~dirt.orbits[7]; ~d9 = ~dirt.orbits[8];
			~d10 = ~dirt.orbits[9]; ~d11 = ~dirt.orbits[10]; ~d12 = ~dirt.orbits[11];
		);

		// directly below here, in your own copy of this file, you could add further code that you want to call on startup
		// this makes sure the server and ~dirt are running
		// you can keep this separate and make it easier to switch between setups
		// by using "path/to/my/file.scd".load and if necessary commenting out different load statements
		// ...

	};



    /*
    ( Platform.userHomeDir ++ "/SuperCollider/libs/_colecoes.scd" ).load;
    Document.open( Platform.userHomeDir ++ "/SuperCollider/libs/_colecoes.scd" );
    */

    s.sync;

    "********** load SynthDefs ***********".postln;

    /*
    ( Platform.userHomeDir ++ "/SuperCollider/libs/_SynthLib.scd" ).load;
    Document.open( Platform.userHomeDir ++ "/SuperCollider/libs/_SynthLib.scd" );
    */

    "********** load fx Functions  ***********".postln;

    /*
    ( Platform.userHomeDir ++ "/SuperCollider/libs/_fxFunc.scd" ).load;
    Document.open( Platform.userHomeDir ++ "/SuperCollider/libs/_fxFunc.scd" );
    */

    "********** load fx Lib ProxyChain ***********".postln;

    /*
    ( Platform.userHomeDir ++ "/SuperCollider/libs/_fxLib.scd" ).load;
    Document.open( Platform.userHomeDir ++ "/SuperCollider/libs/_fxLib.scd" );
    */

    s.sync;
    0.2.wait;
    PdefnAllGui.new(36);
    0.2.wait;
    q.pxMixer = ProxyMixer(p, 16); // espaço para 8 proxies
    0.2.wait;
    q.pxMixer.parent.alwaysOnTop_(true);
    0.2.wait;
    if ( \ProxyMeter.asClass.notNil ) { ProxyMeter.addMixer(q.pxMixer) };
    1.wait;

    1.wait;
    History.clear.end;      // clear to start over
    History.start;          // starts recording, opens log file

    Pdefn(\scale, Scale.choose(7, 12)).source.name;

    // "********** load Sample Stuff ***********".postln;

    /*
    "~/SuperCollider/libs/_SampleLib.scd".standardizePath.load;
    Document.open( Platform.userHomeDir ++ "/SuperCollider/libs/_SampleLib.scd" );
    [ "/Samples/dirtedit", "/Samples/airstrip", "/Samples/invocation",  "/Samples/skmecs", "/Samples/tr808", "/Samples/brazilperc"].do{|pat| var samples = Platform.userHomeDir ++ pat; q.getSamples(samples); "".postln; };
    */

    // 0.5.wait;
    // q.printSamps;
    // 0.5.wait;
    // "~/SuperCollider/processes/swingfy.scd".standardizePath.load; // a
    // "~/SuperCollider/libs/FXXX_orbs.scd".standardizePath.load;
    // "~/SuperCollider/libs/_vstPlugins.scd".standardizePath.load;
    // "~/SuperCollider/processes/vst_q-acid.scd".standardizePath.load; wait(12);
    // "~/SuperCollider/processes/vsti_q-drum.scd".standardizePath.load;
    // wait(10);
    // "processes/tunel.scd".loadRelative;
    // "~/SuperCollider/processes/dubba.scd".standardizePath.load;
    // "FX/subMix.scd".loadRelative;
    // 1.wait;
    // q.mod = MFunc(); "q.mod = MFunc".postln;
            // "VST/fxs/verbs.scd".loadRelative;
    // 2.wait;
    // });


    /*
    TODO

    "********** load Sample Stuff ***********".postln;

    ( Platform.userHomeDir ++ "/SuperCollider/libs/_SampleLib.scd" ).load;

    ~dec ~pdec ~rel ~prel ~sus ~psus ~pfold ~pdist ~pan
    */

    //"/home/gilfuser/SuperCollider/algoraveSP/_0_StartUp.scd".load
});

// scnvim
/*if (\SCNvim.asClass.notNil) {
Server.default.doWhenBooted {
\SCNvim.asClass.updateStatusLine(1, 9670);
}
}*/
