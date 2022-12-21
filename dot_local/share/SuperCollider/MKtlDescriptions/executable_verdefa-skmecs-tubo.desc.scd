// // based on gyrosc desc

// TODO: ONE DESC FOR ALL INSTRUMENTS!!! (USING COLLECTIVES)
(
idInfo: "nodemcu+mpu6050",
netAddrInfo: (
	recvPort: NetAddr.langPort,
    srcPort: 52792,
	ipAddress: nil
),
deviceName: "tuboexpandido",
protocol: \osc,
deviceType: \microContoller,
elementTypes: [\imu, \accelerometer],
status: (
	linux: "tested and working. 2019-11-25, gf.",
	osx: "unknown",
	win: "unknown"),



specs: (
	gyroAxis: [-180, 180],
	accelAxis: [-16384, 16384],
),

deviceInfo: (
	vendorURI: "https://github.com/gilfuser/escuta-ativa",
	// manualURI: "",
	description: "instrument made with NodeMCU, MPU6050 and NeoPixel LED Ring",
	// features: [],
	// notes: "",
	longName: "Skmecs MultiTube"
),

collectives: (
	gyro: (
		oscPath: '/verdefa/gyro',
		elements: [[\gyro, \pitch], [\gyro, \roll], [\gyro, \yaw]],
		ioType: \in
	),
	accel: (
		oscPath: '/verdefa/accel',
		elements: [ [\accel, \x], [\accel, \y], [\accel, \z]],
		ioType: \in
	),
	// add similar entries for comp, matrix, rrate, quat, grav, mag, gps
),
	// replace wildcard later with nameTag as set in iphone used.
elementsDesc: (
	elements: [
		(
			key: \gyro,
			shared: (elementType: 'gyroAxis', ioType: \collectiveIn, \spec: 'gyroAxis' ),
			elements: [
				(key: \yaw, style: (row: 2, column: 0, height: 2)),
				(key: \pitch, style: (row: 2, column: 1, height: 2)),
				(key: \roll, style: (row: 2, column: 2, height: 2)),
			]
		),
		(
			key: \accel,
			shared: (elementType: 'accelAxis', ioType: \collectiveIn, \spec: 'accelAxis' ),
			elements: [
				(key: \x, style: (row: 0, column: 0, height: 2) ),
				(key: \y, style: (row: 0, column: 1, height: 2) ),
				(key: \z, style: (row: 0, column: 2, height: 2) )
			],
		),		// similar for comp, matrix, rrate, quat, grav, mag, gps

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
