import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final Color _defaultColor = Color(0xFF151616);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BodyPart? defendingBodyPart;
  BodyPart? attackingBodyPart;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFd5def0),
        body: Column(
          children: [
            const SizedBox(
              height: 35,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: Center(
                        child: Text(
                  'You',
                  style: TextStyle(color: _defaultColor),
                ))),
                const SizedBox(
                  width: 14,
                ),
                Expanded(
                    child: Center(
                        child: Text(
                  'Enemy',
                  style: TextStyle(color: _defaultColor),
                ))),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
            const SizedBox(
              height: 11,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: Column(
                  children: [
                    _LifeWidget(),
                    _LifeWidget(),
                    _LifeWidget(),
                    _LifeWidget(),
                    _LifeWidget(),
                  ],
                )),
                const SizedBox(
                  width: 14,
                ),
                Expanded(
                    child: Column(
                  children: [
                    _LifeWidget(),
                    _LifeWidget(),
                    _LifeWidget(),
                    _LifeWidget(),
                    _LifeWidget(),
                  ],
                )),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Defend'.toUpperCase(),
                        style: TextStyle(color: _defaultColor),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      _BodyPartButton(
                        bodyPart: BodyPart.head,
                        selected: defendingBodyPart == BodyPart.head,
                        bodyPartSetter: _selectDefendingBodyPart,
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      _BodyPartButton(
                        bodyPart: BodyPart.torso,
                        selected: defendingBodyPart == BodyPart.torso,
                        bodyPartSetter: _selectDefendingBodyPart,
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      _BodyPartButton(
                        bodyPart: BodyPart.legs,
                        selected: defendingBodyPart == BodyPart.legs,
                        bodyPartSetter: _selectDefendingBodyPart,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 14,
                ),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Attack'.toUpperCase(),
                        style: TextStyle(color: _defaultColor),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      _BodyPartButton(
                        bodyPart: BodyPart.head,
                        selected: attackingBodyPart == BodyPart.head,
                        bodyPartSetter: _selectAttackingBodyPart,
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      _BodyPartButton(
                        bodyPart: BodyPart.torso,
                        selected: attackingBodyPart == BodyPart.torso,
                        bodyPartSetter: _selectAttackingBodyPart,
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      _BodyPartButton(
                        bodyPart: BodyPart.legs,
                        selected: attackingBodyPart == BodyPart.legs,
                        bodyPartSetter: _selectAttackingBodyPart,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: _isGoEnabled ? processGo : null,
                    child: SizedBox(
                      height: 40,
                      child: ColoredBox(
                        color: _isGoEnabled ? Color(0xDD000000) : Color(0x61000000),
                        child: Center(
                          child: Text(
                            'Go'.toUpperCase(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
          ],
        ),
      ),
    );
  }

  bool get _isGoEnabled => defendingBodyPart != null && attackingBodyPart != null;

  void _selectDefendingBodyPart(final BodyPart value) {
    setState(() {
      defendingBodyPart = value;
    });
  }

  void _selectAttackingBodyPart(final BodyPart value) {
    setState(() {
      attackingBodyPart = value;
    });
  }

  void processGo() {
    setState(() {
      attackingBodyPart = null;
      defendingBodyPart = null;
    });
  }
}

class _LifeWidget extends StatelessWidget {
  const _LifeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '1',
      style: TextStyle(color: _defaultColor),
    );
  }
}

class _BodyPartButton extends StatelessWidget {
  final BodyPart bodyPart;
  final bool selected;
  final ValueSetter<BodyPart> bodyPartSetter;

  const _BodyPartButton({
    Key? key,
    required this.bodyPart,
    required this.selected,
    required this.bodyPartSetter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => bodyPartSetter(bodyPart),
      child: SizedBox(
        height: 40,
        child: ColoredBox(
          color: selected ? Color(0xFF1C79CE) : Color(0x61000000),
          child: Center(
            child: Text(
              bodyPart.name.toUpperCase(),
              style: TextStyle(color: selected ? Colors.white : Color(0xFF060D14)),
            ),
          ),
        ),
      ),
    );
  }
}

class BodyPart {
  final String name;

  const BodyPart._(this.name);

  static const head = BodyPart._('Head');
  static const torso = BodyPart._('Torso');
  static const legs = BodyPart._('Legs');

  @override
  String toString() {
    return 'BodyPart{name: $name}';
  }
}
