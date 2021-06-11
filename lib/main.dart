import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_fight_club/fight_club_colors.dart';
import 'package:flutter_fight_club/fight_club_icons.dart';
import 'package:flutter_fight_club/fight_club_images.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.pressStart2pTextTheme(Theme.of(context).textTheme),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  static const maxLives = 5;

  BodyPart? defendingBodyPart;
  BodyPart? attackingBodyPart;

  BodyPart whatEnemyAttacks = BodyPart.random();
  BodyPart whatEnemyDefends = BodyPart.random();

  String? actionResult;

  int yourLives = maxLives;
  int enemysLives = maxLives;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            FightersInfo(
              maxLives: maxLives,
              yourLives: yourLives,
              enemyLives: enemysLives,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: ColoredBox(
                    color: FightClubColors.darkBG,
                    child: Center(
                      child: Text(
                        actionResult ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          height: 2,
                          color: FightClubColors.darkGreyText,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ControlsWidget(
              attackingBodyPart: attackingBodyPart,
              defendingBodyPart: defendingBodyPart,
              selectAttackingBodyPart: _selectAttackingBodyPart,
              selectDefendingBodyPart: _selectDefendingBodyPart,
            ),
            const SizedBox(
              height: 14,
            ),
            GoButton(
              text: _isGameOver ? 'Start new game' : 'Go',
              onTap: () {
                processGo();
              },
              color: _getGoButtonColor(),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  Color _getGoButtonColor() {
    return _isGoEnabled || _isGameOver ? FightClubColors.blackButton : FightClubColors.greyButton;
  }

  bool get _isGoEnabled => defendingBodyPart != null && attackingBodyPart != null;

  bool get _isGameOver => yourLives == 0 || enemysLives == 0;

  void _selectDefendingBodyPart(final BodyPart value) {
    if (_isGameOver) {
      return;
    }
    setState(() {
      defendingBodyPart = value;
    });
  }

  void _selectAttackingBodyPart(final BodyPart value) {
    if (_isGameOver) {
      return;
    }
    setState(() {
      attackingBodyPart = value;
    });
  }

  void processGo() {
    setState(() {
      if (_isGameOver) {
        enemysLives = maxLives;
        yourLives = maxLives;
        actionResult = null;
        return;
      }
      if (_isGoEnabled) {
        final bool enemyLoseLife = attackingBodyPart != whatEnemyDefends;
        final bool youLoseLife = defendingBodyPart != whatEnemyAttacks;

        if (enemyLoseLife) {
          enemysLives--;
        }

        if (youLoseLife) {
          yourLives--;
        }

        checkResult();

        attackingBodyPart = null;
        defendingBodyPart = null;
        whatEnemyAttacks = BodyPart.random();
        whatEnemyDefends = BodyPart.random();
      }
    });
  }

  void checkResult() {
    if (enemysLives == 0 && yourLives != 0) {
      actionResult = ActionResult.won.name;
      return;
    }
    if (enemysLives == 0 && yourLives == 0) {
      actionResult = ActionResult.draw.name;
      return;
    }
    if (enemysLives != 0 && yourLives == 0) {
      actionResult = ActionResult.lost.name;
      return;
    }

    final firstLine = attackingBodyPart == whatEnemyDefends
        ? ActionResult.youBlocked.name
        : '${ActionResult.youHit.name}${attackingBodyPart?.name.toLowerCase()}.';
    final secondLine = defendingBodyPart == whatEnemyAttacks
        ? ActionResult.enemyBlocked.name
        : '${ActionResult.enemyHit.name}${whatEnemyAttacks.name.toLowerCase()}.';
    actionResult = '$firstLine\n$secondLine';
  }
}

class FightersInfo extends StatelessWidget {
  final int maxLives;
  final int yourLives;
  final int enemyLives;

  const FightersInfo({
    Key? key,
    required this.maxLives,
    required this.yourLives,
    required this.enemyLives,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Stack(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ColoredBox(
                color: Colors.white,
              ),
            ),
            Expanded(
              child: ColoredBox(
                color: FightClubColors.darkBG,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 160,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              LivesWidget(
                overallLivesCount: maxLives,
                currentLivesCount: yourLives,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'You',
                    style: TextStyle(color: FightClubColors.darkGreyText),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Image.asset(
                    FightClubImages.youAvatar,
                    width: 92,
                    height: 92,
                  ),
                ],
              ),
              SizedBox(
                child: ColoredBox(
                  color: Colors.green,
                  child: SizedBox(
                    width: 44,
                    height: 44,
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Enemy',
                    style: TextStyle(color: FightClubColors.darkGreyText),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Image.asset(
                    FightClubImages.enemyAvatar,
                    width: 92,
                    height: 92,
                  ),
                ],
              ),
              LivesWidget(
                overallLivesCount: maxLives,
                currentLivesCount: enemyLives,
              ),
            ],
          ),
        ),
      ]),
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
          color: selected ? FightClubColors.blueButton : FightClubColors.greyButton,
          child: Center(
            child: Text(
              bodyPart.name.toUpperCase(),
              style: TextStyle(color: selected ? FightClubColors.whiteText : FightClubColors.darkGreyText),
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

  static const _values = [head, torso, legs];

  static BodyPart random() {
    return _values[Random().nextInt(_values.length)];
  }
}

class ActionResult {
  final String name;

  const ActionResult._(this.name);

  static const won = ActionResult._('You won');
  static const lost = ActionResult._('You lost');
  static const draw = ActionResult._('Draw');
  static const youBlocked = ActionResult._('Your attack was blocked.');
  static const youHit = ActionResult._("You hit enemy's ");
  static const enemyBlocked = ActionResult._("Enemy's attack was blocked.");
  static const enemyHit = ActionResult._('Enemy hit your ');

  @override
  String toString() {
    return 'ActionResult{name: $name}';
  }
}

class LivesWidget extends StatelessWidget {
  final int overallLivesCount;
  final int currentLivesCount;

  const LivesWidget({
    Key? key,
    required this.overallLivesCount,
    required this.currentLivesCount,
  })  : assert(overallLivesCount >= 1),
        assert(currentLivesCount >= 0),
        assert(currentLivesCount <= overallLivesCount),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        overallLivesCount,
        (index) {
          return Padding(
            padding: EdgeInsets.only(bottom: index < overallLivesCount - 1 ? 4 : 0),
            child: index < currentLivesCount
                ? Image.asset(
                    FightClubIcons.heartFull,
                    width: 18,
                    height: 18,
                  )
                : Image.asset(
                    FightClubIcons.heartEmpty,
                    width: 18,
                    height: 18,
                  ),
          );
        },
      ),
    );
  }
}

class ControlsWidget extends StatelessWidget {
  final BodyPart? defendingBodyPart;
  final ValueSetter<BodyPart> selectAttackingBodyPart;
  final BodyPart? attackingBodyPart;
  final ValueSetter<BodyPart> selectDefendingBodyPart;

  const ControlsWidget({
    Key? key,
    required this.defendingBodyPart,
    required this.selectAttackingBodyPart,
    required this.attackingBodyPart,
    required this.selectDefendingBodyPart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                'Defend'.toUpperCase(),
                style: TextStyle(color: FightClubColors.darkGreyText),
              ),
              const SizedBox(
                height: 13,
              ),
              _BodyPartButton(
                bodyPart: BodyPart.head,
                selected: defendingBodyPart == BodyPart.head,
                bodyPartSetter: selectDefendingBodyPart,
              ),
              const SizedBox(
                height: 14,
              ),
              _BodyPartButton(
                bodyPart: BodyPart.torso,
                selected: defendingBodyPart == BodyPart.torso,
                bodyPartSetter: selectDefendingBodyPart,
              ),
              const SizedBox(
                height: 14,
              ),
              _BodyPartButton(
                bodyPart: BodyPart.legs,
                selected: defendingBodyPart == BodyPart.legs,
                bodyPartSetter: selectDefendingBodyPart,
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
              Text(
                'Attack'.toUpperCase(),
                style: TextStyle(color: FightClubColors.darkGreyText),
              ),
              const SizedBox(
                height: 13,
              ),
              _BodyPartButton(
                bodyPart: BodyPart.head,
                selected: attackingBodyPart == BodyPart.head,
                bodyPartSetter: selectAttackingBodyPart,
              ),
              const SizedBox(
                height: 14,
              ),
              _BodyPartButton(
                bodyPart: BodyPart.torso,
                selected: attackingBodyPart == BodyPart.torso,
                bodyPartSetter: selectAttackingBodyPart,
              ),
              const SizedBox(
                height: 14,
              ),
              _BodyPartButton(
                bodyPart: BodyPart.legs,
                selected: attackingBodyPart == BodyPart.legs,
                bodyPartSetter: selectAttackingBodyPart,
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 16,
        ),
      ],
    );
  }
}

class GoButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;
  final String text;

  const GoButton({
    Key? key,
    required this.onTap,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 40,
          child: ColoredBox(
            color: color,
            child: Center(
              child: Text(
                text.toUpperCase(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: FightClubColors.whiteText,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
