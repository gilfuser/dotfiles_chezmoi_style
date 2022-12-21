"********** StartUp Banda de Plantas ***********".postln;
q = q ? ();
s.latency = 0.24;
s.options
	.numAudioBusChannels_(1024)
	.zeroConf_(false)			// don't wait for zeroconf when booting server
	.memSize_(8192 * 32)		// memSize is in kB, so 8 * 32 = 256 MB for soundfiles, buffers

		// keep several combinations of audio devices + numChannels
	.hardwareBufferSize_(256)
	.numInputBusChannels_(0)
	.numOutputBusChannels_(4);

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
    p.quant = 4.0;
    p.fadeTime = 0;
    p.reshaping = \elastic;
    p.pop;

s.doWhenBooted({
    s.sync;
    // MIDIClient.init;
    s.recChannels_(2);			// record stereo out only
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
    s.sync;
    0.2.wait;

    q.ndefMixer = NdefMixer(s, 8); // espaço para 8 proxies
    0.2.wait;
    q.ndefMixer.parent.alwaysOnTop_(true);
    0.2.wait;
    if ( \ProxyMeter.asClass.notNil ) { ProxyMeter.addMixer(q.ndefMixer) };
        0.2.wait;
    q.pxMixer = ProxyMixer(p, 16); // espaço para 8 proxies
    0.2.wait;
    q.pxMixer.parent.alwaysOnTop_(true);
    0.2.wait;
    if ( \ProxyMeter.asClass.notNil ) { ProxyMeter.addMixer(q.pxMixer) };
    1.wait;
    History.clear.end;      // clear to start over
    History.start;          // starts recording, opens log file
    /*
    s.boot
    HelpBrowser.instance
    Document.open( Platform.userHomeDir ++ "/SuperCollider/libs/_colecoes.scd" );
    */

    s.sync;

    "********** load SynthDefs ***********".postln;
    "~/SuperCollider/libs/_SynthLib.scd".standardizePath.load;

    // "~/Trabalho//supercollider/0_loadGlobalUtils.scd".standardizePath.load;
    ( Platform.userHomeDir ++ "/SuperCollider/libs/_fxFunc.scd" ).load;
    1.2.wait;
    // 12.2.wait;
    // AppClock.play(~acid.editor);
    // AppClock.play(~acid.gui);
    /*
    s.boot
    Document.open( Platform.userHomeDir ++ "/SuperCollider/libs/_SynthLib.scd" );
    */
    });
