q = q ? ();

"startup skmecs".postln;
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
s.latency = 0.2;
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
.numOutputBusChannels_(4); // set this to your hardware output channel size, if necessary

// .blockSize_(64)					//  .kr bus rate, default is 64 samples
//  32 samples makes possible lower latency
// .hardwareBufferSize_(128)		// take fastest power of two hardware allows

s.waitForBoot({
    s.sync;
    Safety(s).disable;
    // MIDIClient.init;
    s
    .recChannels_(2);			// record stereo out only
    // .recSampleFormat_("float"); in float to recover from clipping
    s.sync;
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
    t = TempoClock(110/60/2).permanent_(true);
    t.tempo = 110/60;
    TempoClock.default = t;
    "********** make ProxySpace p ***********".postln;
    p = ProxySpace.push;
    p.makeTempoClock;
    p.clock.permanent_(true); // now the ProxySpace's clock is a TempoBusClock
    //mais pesado, mas mais preciso
    ProxySynthDef.sampleAccurate = true;
    // ou assim. mais util se usar o mesmo clock para outras coisas além do ProxySpace
    p.quant = 4.0;
    p.know = true;
    p.fadeTime = 0;
    p.reshaping = \elastic;
    p.pop;

    ( Platform.userHomeDir ++ "/SuperCollider/libs/_colecoes.scd" ).load;

    Document.open( Platform.userHomeDir ++ "/SuperCollider/libs/_colecoes.scd" );

    s.sync;

    "********** load SynthDefs ***********".postln;

    ( Platform.userHomeDir ++ "/SuperCollider/libs/_SynthLib.scd" ).load;

    "********** load fx Functions  ***********".postln;

    ( Platform.userHomeDir ++ "/SuperCollider/libs/_fxFunc.scd" ).load;

    "********** load fx Lib ProxyChain ***********".postln;

    ( Platform.userHomeDir ++ "/SuperCollider/libs/_fxLib.scd" ).load;

    "********** load vst base SynthDefs ***********".postln;

    "~/SuperCollider/libs/_vstPlugins.scd".standardizePath.load;


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
