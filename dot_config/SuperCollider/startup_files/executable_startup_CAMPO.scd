"********** StartUp CAMPO ***********".postln;
q = q ? ();
s.latency = 0.24;
s.options
	.numAudioBusChannels_(1024)
	.zeroConf_(false)			// don't wait for zeroconf when booting server
	.memSize_(8192 * 32)		// memSize is in kB, so 8 * 32 = 256 MB for soundfiles, buffers

		// keep several combinations of audio devices + numChannels
    .hardwareBufferSize_(1024)
	.numInputBusChannels_(2)
	.numOutputBusChannels_(2);

    t = TempoClock.new.permanent_(true);
    t.tempo = 110/60/2;
    "********** make ProxySpace p ***********".postln;
    p = ProxySpace.push;
    // p.know = true;
    p.makeTempoClock(110/60/2);
    p.clock; // now the ProxySpace's clock is a TempoBusClock
    p.pop;
    /*
    //mais pesado, mas mais preciso
    ProxySynthDef.sampleAccurate = true;
    // ou assim. mais util se usar o mesmo clock para outras coisas além do ProxySpace
    p.quant = 4.0;
    p.fadeTime = 0;
    p.reshaping = \elastic;
    p.pop;
    s.boot
*/
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

    q.pxMixer = NdefMixer(s, 8); // espaço para 8 proxies
    0.2.wait;
    // q.pxMixer.parent.alwaysOnTop_(true);
    0.2.wait;
    if ( \ProxyMeter.asClass.notNil ) { ProxyMeter.addMixer(q.pxMixer) };

    1.wait;
    History.clear.end;      // clear to start over
    History.start;          // starts recording, opens log file
    /*
    s.boot
    s.quit
    HelpBrowser.instance
    Document.open( Platform.userHomeDir ++ "/SuperCollider/libs/_colecoes.scd" );
    s.sync;
    Ndef(\orb0).gui
    s.meter
    */

    "********** load SynthDefs ***********".postln;
    "~/SuperCollider/libs/_SynthLib.scd".standardizePath.load;

    "~/Trabalho/CAMPO/supercollider/0_loadGlobalUtils.scd".standardizePath.load;
    1.2.wait;
    "~/Trabalho/CAMPO/supercollider/superDirt_startup.scd".standardizePath.load;
    6.2.wait;
    "~/Trabalho/CAMPO/supercollider/FX/vstPlugin.scd".standardizePath.load;
    9.2.wait;
    "~/Trabalho/CAMPO/supercollider/FX/fxLib.scd".standardizePath.load;
    0.2.wait;
    "~/Trabalho/CAMPO/FXXX_orbs_simple.scd".standardizePath.load;
    0.2.wait;
    // "~/Trabalho/CAMPO/supercollider/FX/saturator.scd".standardizePath.load;
    0.2.wait;
    "~/Trabalho/CAMPO/supercollider/tidal_set_FX.scd".standardizePath.load;
    0.2.wait;
    "~/SuperCollider/libs/_fxLib.scd".standardizePath.load;
    0.2.wait;
    "~/Trabalho/CAMPO/supercollider/midiInstrument.scd".standardizePath.load;
    // 12.2.wait;
    // AppClock.play(~acid.editor);
    AppClock.play(Ndef(\orb0).gui);
    /*
    s.boot
    Document.open( Platform.userHomeDir ++ "/SuperCollider/libs/_SynthLib.scd" );
    */
    });
