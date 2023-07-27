import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart' as neu;
// import 'package:flutter_neumorphic/src/light_source.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _screenCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    //
    Widget btn(String label, {void Function()? onTap, neu.NeumorphicShape shape = neu.NeumorphicShape.concave, Color? color}) {
      double btnDepth = 3;

      return Expanded(
        child: GestureDetector(
          onTap: onTap ?? () => _screenCtrl.text += label,
          onTapDown: (_) => btnDepth = 1,
          onTapUp: (_) => btnDepth = 3,
          child: Padding(
            padding: const EdgeInsets.all(3.5),
            child: neu.Neumorphic(
              style: neu.NeumorphicStyle(
                shape: shape,
                boxShape: const neu.NeumorphicBoxShape.circle(),
                surfaceIntensity: .55,
                intensity: .75,
                color: color ?? Colors.grey[300] ?? Theme.of(context).secondaryHeaderColor, // ?? Colors.cyan,
                depth: btnDepth,
              ),
              child: Center(child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 19))),
            ),
          ),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
      home: Scaffold(
        backgroundColor: Colors.grey[300], // Theme.of(context).secondaryHeaderColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // screen
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: neu.Neumorphic(
                  style: neu.NeumorphicStyle(
                    border: const neu.NeumorphicBorder(color: Color(0x33000000), width: 0.2),
                    boxShape: neu.NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                    surfaceIntensity: .55,
                    intensity: .9,
                    // lightSource: LightSource.topRight,
                    depth: -2,
                    color: Colors.grey[300] ?? Theme.of(context).secondaryHeaderColor,
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(7),
                      child: EditableText(
                        textAlign: TextAlign.right,
                        controller: _screenCtrl, readOnly: true, textDirection: TextDirection.ltr, minLines: 1, maxLines: null,
                        // maxLines: 12,
                        focusNode: FocusNode(),
                        showCursor: true,
                        scribbleEnabled: false,
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: theme.iconTheme.color),
                        backgroundCursorColor: theme.iconTheme.color ?? Colors.deepPurple,
                        cursorColor: theme.iconTheme.color ?? Colors.deepPurple,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          btn(
                            'C',
                            onTap: () => _screenCtrl.text = _screenCtrl.text.substring(0, _screenCtrl.text.length - 1),
                            shape: neu.NeumorphicShape.convex,
                            color: Colors.cyan,
                          ),
                          btn('7'),
                          btn('4'),
                          btn('1'),
                          btn('0'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          btn('DEL', onTap: () => _screenCtrl.clear(), shape: neu.NeumorphicShape.convex, color: Colors.cyan),
                          btn('8'),
                          btn('5'),
                          btn('2'),
                          btn('.', onTap: () {
                            if (!_screenCtrl.text.contains('.')) _screenCtrl.text += '.';
                          }),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          btn('^', shape: neu.NeumorphicShape.convex, color: Colors.cyan),
                          btn('9'),
                          btn('6'),
                          btn('3'),
                          btn('%', onTap: () {}),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          btn('×', shape: neu.NeumorphicShape.convex, color: Colors.cyan),
                          btn('÷', shape: neu.NeumorphicShape.convex, color: Colors.cyan),
                          btn('-', shape: neu.NeumorphicShape.convex, color: Colors.cyan),
                          btn('+', shape: neu.NeumorphicShape.convex, color: Colors.cyan),
                          btn('=', onTap: () {}, shape: neu.NeumorphicShape.convex, color: Colors.deepOrange),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

String add(double a, double b) => '${a + b}';

// Function to perform subtraction
String subtract(double a, double b) => '${a - b}';

// Function to perform multiplication
String multiply(double a, double b) => '${a * b}';

// Function to perform division
String divide(double a, double b) {
  if (b == 0) return 'Error';

  return '${a / b}';
}
