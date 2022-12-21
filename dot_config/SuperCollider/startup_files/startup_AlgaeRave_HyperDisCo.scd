q = q ?? ();
defer{ Server.killAll };
s.latency = 0.3;
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
.numInputBusChannels_(1)
.numOutputBusChannels_(64)
.maxLogins_(8)
.bindAddress_('0.0.0.0');
// .sampleRate_(4800)
// .device = "ASIO : ASIO4ALL v2"; // set this to your hardware output channel size, if necessary
s.recChannels_(2);

// HyperDisCo stuff
/// ENTER YOUR Preferred nametag/ID:
q.myID = 'skmecs';
/// a personal password for yourself - don't use an important one!
q.mypassword = 'hyperdisco';

// next, we tell the setup where the HyperDisco folder is,
/// e.g., on macOS, you may want to put it here:
q.hyperfolder = "~/.local/share/SuperCollider/downloaded-quarks/HyperDisCo/examples/hyperfolder/".standardizePath;

///////////// Maybe personalize these too //////////////
// this is the server adress which connects the group:
// "gencomp..." is the UdK Berlin server, which is fine to use for tests.
// use your own server if you have one!
q.myoscserver = "gencomp.medienhaus.udk-berlin.de";

/// change group name and password for your group:
// this is the default group for hyperdisco tests:
q.mygroup = 'hyperdisco';
q.mygroupPassword = 'hyperdisco';

///////////////// END of PERSONALIZATION !////////////////////

//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////

//////////////// DONT CHANGE ANYTHING BELOW HERE!!! //////////
if (q.myID == '???') {
	"*** please enter your nametag in your startup file!"
	"\n... stopping here.".postln;
	this.halt;
};

"***  q.myID = %; // <- My valid nameID \n\n".postf(q.myID);

if (File.exists(q.hyperfolder).not) {
	"cannot find q.hyperfolder at % - "
	"\n please move it there!".postf(q.hyperfolder);
	this.halt;
};
// found it:
"***  q.hyperfolder = %; ".postf(q.hyperfolder);

if ((Quarks.installed.any { |quark| quark.name == "HyperDisCo" })) {
	// just continue
	(q.hyperfolder +/+ "setup_files/00_loadMe.scd").loadPaths;
} {
	// if missing, add quark folder, and recompile by Hand:
	Quarks.fetchDirectory;
	Quarks.install("HyperDisCo");
	Quarks.install("StartupFile");
	LanguageConfig.store;
	"*** Please recompile now! with:".postln;
	"thisProcess.recompile;".postln;
};
// end of HyperDisCo stuff

s.waitForBoot({
// asdasdas
    t = TempoClock.default;
    // q.mod = MFunc(); "q.mod = MFunc\n".postString;
    Pdefn(\scale, Scale.choose(7, 12)).source.name;
    Troop.start;
    wait(0.2);
    // ProxySpace stuff
    p = ProxySpace.push.clock_(t).quant_(1).fadeTime_(16).reshaping_(\elastic);
    ProxySynthDef.sampleAccurate = true;
    wait(0.2);
    p.know = true;
    wait(0.2);
    ( Platform.userHomeDir ++ "/SuperCollider/interface/click_in_sync.scd" ).load;
    wait(0.2);
    // ( Platform.userHomeDir ++ "/SuperCollider/libs/_SynthLib.scd" ).load;
    wait(0.2);
    ( Platform.userHomeDir ++ "/SuperCollider/FX/_fxFunc.scd" ).load;
    wait(0.2);
    ( Platform.userHomeDir ++ "/SuperCollider/FX/_fxLib.scd" ).load;
    wait(0.2);
    ( Platform.userHomeDir ++ "/SuperCollider/algoRaveBR2022/FX/mainCompressor_vst.scd" ).load;
    wait(5.2);
    ( Platform.userHomeDir ++ "/SuperCollider/algoRaveBR2022/toca/swingfy.scd" ).load;
    wait(0.2);
    ( Platform.userHomeDir ++ "/SuperCollider/algoRaveBR2022/interface/gui_Stuff.scd" ).load;
    wait(0.2);
    // "FX/mainFX.scd".loadRelative; // explode se a NDef abaixo estiver ligada
    // wait(0.2);
    // Ndef(\allOrbs).gui;
    /*(
     Ndef(\allOrbs, {
            var in = [InFeedback.ar([2,4,6,8],1),InFeedback.ar([3,5,7,9],1)];
            OffsetOut.ar(0, in)
        }).play;
    );
    */
    wait(0.2);
    ( Platform.userHomeDir ++ "/SuperCollider/algoRaveBR2022/FX/mainFX.scd" ).load;
    wait(0.2);
});


// scnvim
if (\SCNvim.asClass.notNil) {
    Server.default.doWhenBooted {
        \SCNvim.asClass.updateStatusLine(1, \SCNvim.asClass.port);
    }
}
