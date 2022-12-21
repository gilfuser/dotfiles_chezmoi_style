
(
idInfo: "xbox gamepad",
netAddrInfo:
(
	// recvPort: NetAddr.langPort,
    recvPort: 54321,
	// ipAddress: "127.0.0.1"
),
deviceName: "Xbox Gamepad",
protocol: \osc,
deviceType: \gamepad,
elementTypes: [\joystick, \button, \hat, \throttle, \rumble],
status:
(
	linux: "unknown",
	osx: "unknown",
	win: "unknown"
),

idInfo: "Xbox Gamepad",

deviceInfo:
(
	vendorURI: "http://www.thrustmaster.com/products/",
	// manualURI: "",
	description: "my gamepad it's not being found as a HID device, but as a LID. So, this is a workaround. See 'test code'",
	// features: [],
	// notes: "",
	// type: [],
	// hasScribble: false
	longName: "Xbox Gamepad"
),

specs: ( joy16b: [-32768, 32767], hat: [-1, 1, \lin, 1, 0] ),

elementsDesc: (
	shared: ('ioType': 'in'),
	elements: [
		(
			key: \bt,
            // oscPath: '/bt',
			shared: ( 'elementType': 'button', spec: \but ),
			elements: [
				// right side buttons
				(
					key: \rightb,
					elements: [
					(
						key: 'y', oscPath: '/y',
						'style': (row: 1.75, column: 5.5, height: 0.5)
					),
				(
					key: 'x', oscPath: '/x',
					'style': (row: 2.3, column: 4.7, height: 0.5)
				),
				(
					key: 'b', oscPath: '/b',
					'style': (row: 2.3, column: 6.3, height: 0.5)
				),
				(
					key: 'a', oscPath: '/a',
					'style': (row: 2.6, column: 5.5, height: 0.5)
				)]
				),
				// front bumpers
				(
					key: \frontb,
					elements: [
					(
					key: 'lb', oscPath: '/lb',
					'style': (row: 1, column: 0.5, height: 0.5)
				),
				(
					key: 'rb', oscPath: '/rb',
					'style': (row: 1, column: 5.5, height: 0.5)
				)]
				),
				// center btns
				(
					key: \centerb,
					elements:
					[
					(
					key: 'back', oscPath: '/back',
					'style': (row: 1, column: 2, height: 0.5)
				),
				(
					key: 'xbox', oscPath: '/guide',
					'style': (row: 1, column: 3, height: 0.5)
				),
				(
					key: 'start', oscPath: '/start',
					'style': (row: 1, column: 4, height: 0.5)
				)
					]
				),
				// thumb btns
				(
					key: \thumbb,
					elements:
					[
					(
					key: 'lt', oscPath: '/lt',
					'style': (row: 1.5, column: 1.4, height: 0.5)
				),
				(
					key: 'rt', oscPath: '/rt',
					'style': (row: 3, column: 4, height: 0.5)
				)]),
				// (key: '10', 'hidUsage': 10,
				//     'style': (row: 1.6, column: 3.5, height: 0.5)),
			]
		),
		(
			key: \joy,
			shared: ( 'elementType': 'thumbAxis', spec: \joy16b, mode: \center ),
			elements: [
						(
							key: \xl, oscPath: '/xl', /*'elementType': 'xFader',  spec: \cent1, */
							'style': (row: 2, column: 1, height: 2)
						),
						(
							key: \yl, oscPath: '/yl', /* spec: \cent1, */
							'style': (row: 2, column: 1.9, height: 2)
						),
						(
                            key: \xr, oscPath: '/xr', /*'elementType': 'xFader', spec: \cent1, */
							'style': (row: 3.5, column: 3.4, height: 2)
						),
						(
                            key: \yr, oscPath: '/yr', /*  'elementType': 'xFader', spec: \cent1, */
							'style': (row: 3.5, column: 4.5, height: 2)
						),
			]
		),
		(
			key: \hat,
			shared: ( 'elementType': 'thumbAxis', 'spec': \hat, 'mode': \center ),
			elements:
			[
				( key: \x, oscPath: '/dx', 'style': (row: 4, column: 1.5) ),
                ( key: \y, oscPath: '/dy', 'style': (row: 4, column: 2.5) )
			]
		),
		(
			key: \z,
			shared: ( elementType: 'springFader', spec: \cent255, mode: \minimum ),
			elements:
			[
				( key: \l, oscPath: '/zl', 'style': (row: 0, column: 0.5) ),
                ( key: \r, oscPath: '/zr', 'style': (row: 0, column: 5.5) )
			]
		),
		// no outputs for led or rumble
	]
),
testCode: {
	// ************* In gyrosc app: ************

	// * enter your wifi address, and SC port:
	NetAddr.langPort;

	// * set nametag to blank!
	// -> nametags require renaming the oscpaths
	// - example to be made.

	// * turn on the controls you want to use.
	// (only accel and gyro supported here so far)


	// * now in SC, check whether OSC messages arrive:
	OSCFunc.trace;
	OSCFunc.trace(false);

	// when you are sure you get proper osc data, make an MKtl:

	g = MKtl(\verdefa, "tubo*");
	g.gui;
	g.trace;
	// update with the address seen in OSCMon or OSCFunc.trace:
	g.device.updateSrcAddr("192.168.0.2", 51970);


	// or without a device, fake gyrosc sending from SC itself:
	OSCFunc.trace;

	n = NetAddr("192.168.178.51", 57120);
	n.sendMsg('/verdefa/gyro', 0.1, 0.2, 0.3);
	n.sendMsg('/gyrosc/button', 1, 2.rand, 0.3);

	Tdef(\gyrtest, {
		inf.do {
			// n.sendMsg('/gyrosc/gyro', 1.0.rand2, 1.0.rand2, 1.0.rand2);
			// n.sendMsg('/gyrosc/accel', 1.0.rand2, 1.0.rand2, 1.0.rand2);
			if (0.05.coin) { n.sendMsg('/gyrosc/button', 9.rand, 2.rand); };
			0.1.wait;
		};
	}).play;

	OSCFunc.trace(false);
	g.trace(false);

	// now see if MKtl listens:
	g.free;
	g = MKtl(\gyr, "gyrosc*");
	g.gui.parent.alwaysOnTop_(true);
	g.trace;
	// set to this computer's ip address and SC's langPort
	g.device.updateSrcAddr("192.168.178.51", 57120);

	g.trace(false);
}
)

