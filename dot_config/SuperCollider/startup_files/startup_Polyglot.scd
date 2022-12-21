q = q ? ();
"startup Polyglot".postln;

"\n**********  loading serverConfig:  **********".postln;

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
.numOutputBusChannels_(2);
ServerOptions.devices.collect{ |d|
    case
    { d == "ASIO : Focusrite USB ASIO" } { s.options.sampleRate_(48000).device_(d) }
    { d == "ASIO : ASIO4ALL v2" } { s.options.sampleRate_(48000).device_(d) }
    { d == "MME : Microphone (Realtek(R) Audio)" } { s.options.inDevice = d }
    { d == "MME : Speakers (Realtek(R) Audio)" } { s.options.outDevice = d };
    "".postln;
};

/*s.doWhenBooted({
    s.sync;
    FoxDot.start;
    0.2.wait;

    s.recChannels_(2).recHeaderFormat_("wav").recSampleFormat_("float"); // float to recover from clipping

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

    t = EspClock.new;
    0.1.wait;
    t.start;
    0.1.wait;
    TempoClock.default = t;
    t.tempo = 110/60/2;
    TempoClock.default = EspClock.new;
    Esp.clockMode = 2;
    // t = TempoClock.new.permanent_(true);
    Esp.person = "tuiuiu";

    "********** make ProxySpace p ***********".postln;
    p = ProxySpace.push;
    p.know = true;
    p.makeTempoClock(110/60/2);
    p.clock; // now the ProxySpace's clock is a TempoBusClock

    ProxySynthDef.sampleAccurate = true; // mais pesado porém mais preciso
    // ou assim. mais util se usar o mesmo clock para outras coisas além do PxSpace
    p.quant = 1.0;
    p.fadeTime = 0;
    p.reshaping = \elastic;
    p.play;
    s.sync;
    0.2.wait;
    p.pop;

    ~dirt.stop;
    ~dirt = SuperDirt(2, s); // two output channels
    ~dirt.loadSoundFiles;
    s.sync;
    ~dirt.start;

    s.sync;
    0.2.wait;
    q.pxMixer = ProxyMixer(p, 16); // espaço para 8 proxies
    0.2.wait;
    // q.pxMixer.parent.alwaysOnTop_(true);
    0.2.wait;
    if ( \ProxyMeter.asClass.notNil ) { ProxyMeter.addMixer(q.pxMixer) };
    1.wait;

    1.wait;
    History.clear.end;      // clear to start over
    History.start;          // starts recording, opens log file

    Pdefn(\scale, Scale.choose(7, 12)).source.name;
});*/
