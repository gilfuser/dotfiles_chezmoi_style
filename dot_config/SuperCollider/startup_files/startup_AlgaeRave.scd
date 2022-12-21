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
