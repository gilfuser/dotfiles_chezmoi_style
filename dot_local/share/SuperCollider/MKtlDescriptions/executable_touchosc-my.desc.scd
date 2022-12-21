/****************************
unixCmd("ifconfig enp0s20f0u4")
/////// in SC:
// * check if anything is coming, and note the sending address

(
f = { |msg, time, addr|
if(msg[0] != '/status.reply') {
"time: % sender: %\nmessage: %\n".postf(time, addr, msg);
}
};
thisProcess.addOSCRecvFunc(f);
);
// stop posting.
thisProcess.removeOSCRecvFunc(f);

// make our tosc **************************************************************
~mktl = MKtl(\tosca, "touchosc-my");
o = OSCMon.new.enable.show;
// set the address to the one you see in the trace:
~mktl.device.updateSrcAddr("192.168.42.129",40488);
NetAddr.langPort;
// now trace the MKtl itself
~mktl.trace(true);
~mktl.device;
// and give it an action for all its elements
t.elAt.action = { |el|
"tOsc %: %\n".postf(el.name, el.value.round(0.001))
};
t.gui;
*******************************/
// adding spec for numbers. Here goes from 0 to 20000 because are the most extrem numbers I'm using, but it can be changed.
//

// Question: would be possible to make a spec for text? So it could be used for labeling

(
deviceName: "touchOSC",
protocol: \osc,
deviceType: \phoneApp,
elementTypes: [/*\accelerometer, */\fader, \button, \label],
status: (
	linux: "unknown after refactor",
	osx: "tested and working. 2016-04-10, adc.",
	win: "unknown after refactor"
),

idInfo: "touchOSC",
netAddrInfo: (srcPort: 9000, recvPort: 57120, ipAddress: "10.88.251.75"),

deviceInfo: (
	longName: "touchOSC"
),

// seem to be the max accel values on iphone
/*specs: (accx: [-3.0, 3.0, \lin]),


// how to have more than one collective in one description?
collectives: (
accel: (
oscPath: '/accxyz',
elements: [ [\accel, \x], [\accel, \y], [\accel, \z] ],
ioType: \in
)
),*/
elementsDesc: (
	elements: [
		(
			key: \1,
			shared: (page: 0),
			elements: [
				(
					key: \sl,
					shared: (ioType: \inout),
					elements: (
						8.collect {|i|
							(
								key: (i+1).asSymbol,
								oscPath: "/1/fader%".format(i+1).asSymbol,
								elementType: 'slider', spec: \unipolar,
								// style: (width: 5, height: 0.85, row: (i * 0.85), column: 4 )
							)
						}
					)
				),
				(
					key: \bt,
					shared: ( ioType: \inout, elementType: 'button', spec: 'but'),
					elements: [
						(
							key: \mtg,
							elements: 4.collect { |i|
								(
									key: (i+1).asSymbol,
									oscPath: "/1/multitoggle/%/1".format(4-i).asSymbol,
									// style: ( height: 0.75, row: 5.25 - (i*0.75), column: 0 )
								)
							}
						),
						(
							key: \tg,
							elements: 18.collect { |i|
								(
									key: (i+1).asSymbol,
									oscPath: "/1/toggle%".format(i+1).asSymbol,
									// style: (height: 0.75, row: i*0.75, column: 0 )
								)
							}
						),

					]
				),
				(
					key: \label,
					shared: ( ioType: \out ),
					elements: 26.collect { |i|
						(
							key: (i+1).asSymbol,
							oscPath: "/1/label%".format(i+1).asSymbol,
							elementType: 'label', spec: \unipolar,
							style:( height: 0.75, row: i*0.85, column: 3 )
						)
					}
				),
				MKtl.globalSpecs.printAll
				/*(
				key: \label,
				shared: ( elementType: 'multiPurpose', spec: 'cent1', ioType: 'out' ),
				elements: 6.collect { |i|
				(
				key: (i).asSymbol,
				oscPath: "/orbs/num%".format(i).asSymbol,
				style:( height: 0.75, row: i*0.85, column: 3 )
				)
				}
				),*/
			]
		),
		(
			key: \2,
			shared: (page: 1),
			elements: [
				(
					key: \sl,
					shared: (ioType: \inout),
					elements: (
						6.collect {|i|
							(
								key: (i+1).asSymbol,
								oscPath: "/2/fader%".format(i+1).asSymbol,
								elementType: 'slider', spec: \unipolar,
								// style: (width: 5, height: 0.85, row: (i * 0.85), column: 4 )
							)
						}
					)
				),
				(
					key: \bt,
					shared: ( ioType: \inout, elementType: 'button', spec: 'but'),
					elements: [
						(
							key: \tg,
							elements: 6.collect { |i|
								(
									key: (i+1).asSymbol,
									oscPath: "/2/toggle%".format(i+1).asSymbol,
									// style: (height: 0.75, row: i*0.75, column: 0 )
								)
							}
						),
						(
							key: \push,
							elements: 2.collect { |i|
								(
									key: (i+1).asSymbol,
									oscPath: "/2/push%".format(i+1).asSymbol,
									// style: (height: 0.75, row: i*0.75, column: 0 )
								)
							}
						),
					]
				),
				(
					key: \label,
					shared: ( ioType: \out ),
					elements: 19.collect { |i|
						(
							key: (i+1).asSymbol,
							oscPath: "/2/label%".format(i+1).asSymbol,
							elementType: 'multiPurpose', spec: 'numma',
							// style:( height: 0.75, row: i*0.85, column: 3 )
						)
					}
				),
			]
		)

		/*(
		key: \accel,
		shared: (elementType: 'accelAxis', ioType: \collectiveIn, \spec: 'accx' ),
		elements: [
		(key: \x, style:( row: 5.5, column: 4 )),
		(key: \y, style:( row: 5.5, column: 5 )),
		(key: \z, style:( row: 5.5, column: 6 ))
		]
		)*/
	]

)
);
