import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 42,
          ),
          Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              Expanded(child: Center(child: Text('You'))),
              const SizedBox(
                width: 14,
              ),
              Expanded(child: Center(child: Text('Enemy'))),
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
                    Text('Defence'.toUpperCase()),
                    const SizedBox(
                      height: 13,
                    ),
                    _BodyPartButton(
                      bodyPart: BodyPart.head,
                      selected: defendingBodyPart == BodyPart.head,
                      bodyPartSetter: _selectDefendingBodyPart,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    _BodyPartButton(
                      bodyPart: BodyPart.torse,
                      selected: defendingBodyPart == BodyPart.torse,
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
                    Text('Attack'.toUpperCase()),
                    const SizedBox(
                      height: 13,
                    ),
                    _BodyPartButton(
                      bodyPart: BodyPart.head,
                      selected: attackingBodyPart == BodyPart.head,
                      bodyPartSetter: _selectAttackingBodyPart,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    _BodyPartButton(
                      bodyPart: BodyPart.torse,
                      selected: attackingBodyPart == BodyPart.torse,
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
                  child: SizedBox(
                height: 40,
                child: ColoredBox(
                  color: Color.fromRGBO(0, 0, 0, 0.87),
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
              )),
              const SizedBox(
                width: 16,
              ),
            ],
          )
        ],
      ),
    );
  }

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
          color: selected ? Color(0xFF1C79CE) : Color(0xFFD6D6D6),
          child: Center(
            child: Text(bodyPart.name.toUpperCase()),
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
  static const torse = BodyPart._('Torse');

  @override
  String toString() {
    return 'BodyPart{name: $name}';
  }
}
