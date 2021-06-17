import 'package:flutter/material.dart';
import 'package:flutter_fight_club/pages/fight_page.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 24),
              child: Text(
                'Statistics',
                style: TextStyle(fontSize: 24, color: FightClubColors.darkGreyText),
              ),
            ),
            const Spacer(),
            FutureBuilder<Stats>(
              future: SharedPreferences.getInstance().then((value) {
                final won = value.getInt(pref_stats_won) ?? 0;
                final lost = value.getInt(pref_stats_lost) ?? 0;
                final draw = value.getInt(pref_stats_draw) ?? 0;
                return Stats(won: won, lost: lost, draw: draw);
              }),
              builder: (context, snapshot) {
                print(snapshot);
                if (!snapshot.hasData || snapshot.data == null) {
                  return const SizedBox.shrink();
                }
                return Column(
                  children: [
                    Text(
                      'Won: ${snapshot.data!.won}',
                      style: const TextStyle(fontSize: 16, height: 1.2),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Draw:  ${snapshot.data!.draw}',
                      style: const TextStyle(fontSize: 16, height: 1.2),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Lost: ${snapshot.data!.lost}',
                      style: const TextStyle(fontSize: 16, height: 1.2),
                    ),
                  ],
                );
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: SecondaryActionButton(
                  text: 'Back',
                  onTap: () {
                    Navigator.pop(context);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class Stats {
  final int won;
  final int lost;
  final int draw;

  Stats({
    required this.won,
    required this.lost,
    required this.draw,
  });
}
