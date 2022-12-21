
/*
desc file for Thrustmater ferrari gamepad.

Notes:

* rumble is only on a single motor, no left and right ( see test below)

// test for rumble outputs
f.elAt( \rumble, \l ).value_(1);
f.elAt( \rumble, \l ).value_(0.5);
f.elAt( \rumble, \l ).value_(0);

f.elAt( \rumble, \r ).value_(1);
f.elAt( \rumble, \r ).value_(0.5);
f.elAt( \rumble, \r ).value_(0);

// - both rumble outs address the same motor,
// - seems that hidUSage 187 is irrelevant - arbitrary change to 123 does the same thing.
*/

(
idInfo: "nodemcu+mpu6050",
netAddrInfo:
(
	// recvPort: NetAddr.langPort,
    recvPort: 54321,
	// ipAddress: "127.0.0.1"
),
deviceName: "Thrustmaster GPX Controller",
protocol: \osc,
deviceType: \gamepad,
elementTypes: [\joystick, \button, \hat, \throttle, \rumble],
status:
(
	linux: "unknown",
	osx: "unknown",
	win: "unknown"
),

idInfo: "Run'N' Drive_Thrustmaster",

deviceInfo:
(
	vendorURI: "http://www.thrustmaster.com/products/",
	// manualURI: "",
	description: "my gamepad it's not being found as a HID device, but as a LID. So, this is a workaround. See 'test code'",
	// features: [],
	// notes: "",
	// type: [],
	// hasScribble: false
	longName: "Skmecs Gamepad"
),

specs: ( joy16bits: [-32768, 32767], hat: [-1, 1, \lin, 1, 0] ),
//
// collectives: (
//     joy: (
//         oscPath: '/gp/joy',
//         elements: [[\joy, \l], [\gyro, \roll], [\gyro, \yaw]],
//         ioType: \in
//     ),
//     hat: (
//         oscPath: '/verdefa/accel',
//         elements: [ [\accel, \x], [\accel, \y], [\accel, \z]],
//         ioType: \in
//     ),
//     // add similar entries for comp, matrix, rrate, quat, grav, mag, gps
// ),
// replace wildcard later with nameTag as set in iphone used.
// elementsDesc: (
//     elements: [
//         (
//             key: \gyro,
//             shared: (elementType: 'gyroAxis', ioType: \collectiveIn, \spec: 'gyroAxis' ),
//             elements: [
//                 (key: \yaw, style: (row: 2, column: 0, height: 2)),
//                 (key: \pitch, style: (row: 2, column: 1, height: 2)),
//                 (key: \roll, style: (row: 2, column: 2, height: 2)),
//             ]
//         ),
//         (
//             key: \accel,
//             shared: (elementType: 'accelAxis', ioType: \collectiveIn, \spec: 'accelAxis' ),
//             elements: [
//                 (key: \x, style: (row: 0, column: 0, height: 2) ),
//                 (key: \y, style: (row: 0, column: 1, height: 2) ),
//                 (key: \z, style: (row: 0, column: 2, height: 2) )
//             ],
//         ),		// similar for comp, matrix, rrate, quat, grav, mag, gps
//
//     ]
// ),
elementsDesc: (
	shared: ('ioType': 'in'),
	elements: [
		(
			key: \bt,
            // oscPath: '/bt',
			shared: (
				// 'hidUsagePage': 9,
				'elementType': 'button', spec: \but ),
			elements: [
				// right side buttons
				( key: 'a', oscPath: '/bt/a',
					'style': (row: 1.8, column: 4.4, height: 0.5) ),
				( key: 'b', oscPath: '/bt/b',
					'style': (row: 1.0, column: 5.2, height: 0.5) ),
				( key: 'x', oscPath: '/bt/x',
					'style': (row: 2.6, column: 5.2, height: 0.5) ),
				( key: 'y', oscPath: '/bt/y',
					'style': (row: 1.8, column: 6.0, height: 0.5) ),

				// front bumpers
				(key: 'frontl', oscPath: '/bt/frontl',
					'style': (row: 0.5, column: 1, height: 0.5)),
				(key: 'frontr', oscPath: '/bt/frontr',
					'style': (row: 0.0, column: 1, height: 0.5)),
				// center btns
				(key: 'back', oscPath: '/bt/back',
					'style': (row: 0.5, column: 5, height: 0.5)),
				(key: 'start', oscPath: '/bt/start',
					'style': (row: 0.0, column: 5, height: 0.5)),
				(key: 'xbox', oscPath: '/bt/xbox',
					'style': (row: 1.6, column: 2.5, height: 0.5)),
				// (key: '10', 'hidUsage': 10,
				//     'style': (row: 1.6, column: 3.5, height: 0.5)),
			]
		),


/*
oscPath: '/joy/l/y',
oscPath: '/trigger/l',
oscPath: '/joy/r/x',
oscPath: '/joy/r/y',
oscPath: '/trigger/r',
oscPath: '/hat/x',
oscPath: '/hat/y',
*/

		(
			key: \joy,
			shared: ( 'elementType': 'joyAxis', spec: \joy16bits, mode: \center ),
			elements: [
				(
					key: \l,
					elements: [
						(key: \x, oscPath: '/joy/l/x', 'elementType': 'joyAxis', /* spec: \cent1, */
							'style': (row: 3.5, column: 1, height: 2)
						),
						(key: \y, oscPath: '/joy/l/y', 'elementType': 'joyAxis', /* spec: \cent1, */
							'style': (row: 3.5, column: 1.9, height: 2)
						),
					]
				),
				(
					key: \r,
					elements: [
						(
                            key: \x, oscPath: '/joy/r/x', 'elementType': 'joyAxis', /* spec: \cent1, */
							'style': (row: 3.5, column: 3, height: 2)
						),
						(
                            key: \y, oscPath: '/joy/r/y', 'elementType': 'joyAxis', /* spec: \cent1, */
							'style': (row: 3.5, column: 3.9, height: 2)
						),
					]
				)
			]
		),
		(
			key: \hat,
			shared: ( 'elementType': 'button', 'spec': \hat, 'mode': \center ),
			elements:
			[
				( key: \l, oscPath: '/hat/l', 'elementType': 'button', 'style': (row: 3.2, column: 1.5) ),
                ( key: \r, oscPath: '/hat/r', 'elementType': 'button', 'style': (row: 3.2, column: 2.5) )
			]
		)
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

