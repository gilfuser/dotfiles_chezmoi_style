// contributed by gil fuser

/*
* todo:
* test on osx
* add gui layout

MKtl(\x, "*mpk*2").gui;
MKtl(\x).trace;
*/

(
deviceName: "MPKmini2",
protocol: 'midi',
deviceType: 'midiKeyboard',
elementTypes: [\knob, \key, \pad, \bend, \pianoKey],
status: (
	linux: "tested and working",
	osx: "unknown",
	win: "unknown"),

idInfo: "MPKmini2",

// hardwarePages: [1, 2, 3, 4],

deviceInfo: (
	vendorURI: 'http://www.akaipro.com/product/mpk-mini-mkii',
	manualURI: 'http://6be54c364949b623a3c0-4409a68c214f3a9eeca8d0265e9266c0.r0.cf2.rackcdn.com/988/documents/MPK%20mini%20-%20User%20Guide%20-%20v1.0.pdf',
	features: [\pianoKey, \pad, \knob, \bender],
	notes:
	"Uses default presets.\n"
	"Every key was mapped, with the exception of ```Prog Change```.\n"
	"Accidental ```Prog-Change``` activation on the device needs to be reverted by ```Bank A/B```.\n"
	"For more flexibility use the [MPK MiniMKII editor](http://www.akaipro.com/product/mpk-mini-mkii#downloads).",
	longName: "AKAI MPKmini mk2"
),
elementsDesc: (
	elements: [

		// ------- bend ------------
		( key: \bend,
			\midiChan: 0, \midiMsgType: \bend, \elementType: \bender, \spec: \midiBend
		),
		// ------ pad -------------
		(
			key: \pad,
			shared: ( groupType: \noteOnOff, \midiChan: 0, \spec: \midiVel, \type: \pad),
			elements: (0..15).collect { |i|
				(key: (i).asSymbol, \midiNum: i)
			}
		),
		// ------ pad into button -------------
		(
			key: \bt,
			shared: (\midiMsgType: \cc, \type: \button, \spec: \midiCC ),
			elements: [

				(
					shared: (\midiChan: 0),
					elements: (0..15).collect { |i|
						(key: (i).asSymbol, \midiNum: i)
					}
				),



			]
		),
		// ------ knob -------------
		(
			key: \kn,
			shared: ( midiMsgType: \cc, elementType: \knob, midiChan: 4, spec: \midiCC, ioType: \in),
			elements: (0..7).collect { |i, item|
				item = item + 1;
				(key: (i).asSymbol, \midiNum: i)
			}
		),
		// ------ piano key -------------
		(
			key: \key,
			shared: ( groupType: \noteOnOff, type: \pianoKey, \midiChan: 4, spec: \midiVel, ioType: \in),
			elements: (0..120).collect { |i|
				(key: (i).asSymbol, \midiNum: i)
			}
				/*elements: [
                    ( key: \on, midiMsgType: \noteOn ),
                    ( key: \off, midiMsgType: \noteOff )
                ]*/
		),
		/*(
                key: \pkey,
                type: 'pianoKey',
                midiMsgType: \noteOff,
                midiChan: 0,
                midiNum: 64, // note number
                spec: \midiVel,
                ioType: \in
            )*/
	]
)

);

