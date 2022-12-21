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
.numInputBusChannels_(1)
.numOutputBusChannels_(2)
.maxLogins_(8)
.bindAddress_('0.0.0.0');
// .sampleRate_(4800)
// .device = "ASIO : ASIO4ALL v2"; // set this to your hardware output channel size, if necessary
s.recChannels_(2);
"StartupFile example - this file have minimum config stuff.".postln;
if (\FZFSC.asClass.notNil) {
    Server.default.doWhenBooted {
        \SCNvim.asClass.updateStatusLine(1, \SCNvim.asClass.port);
    }
}
