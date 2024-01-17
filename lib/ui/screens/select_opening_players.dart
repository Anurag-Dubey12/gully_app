import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gully_app/data/model/matchup_model.dart';
import 'package:gully_app/data/model/player_model.dart';
import 'package:gully_app/data/model/team_model.dart';
import 'package:gully_app/ui/screens/score_card_screen.dart';
import 'package:gully_app/ui/widgets/gradient_builder.dart';
import 'package:gully_app/ui/widgets/primary_button.dart';
import 'package:gully_app/utils/utils.dart';

import '../../data/controller/scoreboard_controller.dart';

class SelectOpeningPlayer extends StatefulWidget {
  final TeamModel battingTeam;
  final TeamModel bowlingTeam;
  final MatchupModel match;
  final String tossWonBy;
  final String electedTo;
  final int overs;

  const SelectOpeningPlayer(
      {super.key,
      required this.match,
      required this.battingTeam,
      required this.bowlingTeam,
      required this.tossWonBy,
      required this.electedTo,
      required this.overs});

  @override
  State<SelectOpeningPlayer> createState() => _SelectOpeningPlayerState();
}

class _SelectOpeningPlayerState extends State<SelectOpeningPlayer> {
  PlayerModel? striker;
  PlayerModel? nonStriker;
  PlayerModel? openingBowler;
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ScoreBoardController>();
    return GradientBuilder(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Select Opening Players',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 24)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Striker',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _DropDownWidget(
              title: 'Select  Striker',
              onSelect: (e) {
                setState(() {
                  if (e.id == nonStriker?.id) {
                    errorSnackBar('Striker and Non Striker cannot be same');
                    return;
                  }
                  striker = e;
                });
                Get.back();
              },
              selectedValue: striker?.name.toUpperCase(),
              items: widget.battingTeam.players!,
            ),
            const SizedBox(height: 20),
            const Text('Non-Striker',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            _DropDownWidget(
              title: 'Select Non Striker',
              onSelect: (e) {
                setState(() {
                  if (e.id == striker?.id) {
                    errorSnackBar('Striker and Non Striker cannot be same');
                    return;
                  }
                  nonStriker = e;
                });
                Get.back();
              },
              selectedValue: nonStriker?.name.toUpperCase(),
              items: widget.battingTeam.players!,
            ),
            const SizedBox(height: 20),
            const Text('Opening Bowler',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _DropDownWidget(
              title: 'Select Opening Bowler',
              onSelect: (e) {
                setState(() {
                  openingBowler = e;
                });
                Get.back();
              },
              selectedValue: openingBowler?.name.toUpperCase(),
              items: widget.bowlingTeam.players!,
            ),
            // container with white bg and border radius of 10 with two items in row having text and radio btn
            const SizedBox(height: 20),
            const Spacer(),
            PrimaryButton(
              onTap: () {
                if (striker == null || nonStriker == null) {
                  errorSnackBar('Please select both the opening batsmen');
                  return;
                }
                if (openingBowler == null) {
                  errorSnackBar('Please select opening bowler');
                  return;
                }
                controller.createScoreBoard(
                  team1: TeamModel.fromJson(widget.battingTeam.toJson()),
                  team2: TeamModel.fromJson(widget.bowlingTeam.toJson()),
                  matchId: widget.match.id,
                  tossWonBy: widget.tossWonBy,
                  electedTo: widget.electedTo,
                  overs: widget.overs,
                  strikerId: striker!.id,
                  nonStrikerId: nonStriker!.id,
                  openingBowler: openingBowler!.id,
                );
                Get.to(() => const ScoreCardScreen());
              },
              title: 'Start Match',
            )
          ],
        ),
      ),
    ));
  }
}

class _DropDownWidget extends StatelessWidget {
  final Function(PlayerModel player) onSelect;
  final String? selectedValue;
  final List<PlayerModel> items;
  final String title;
  const _DropDownWidget({
    required this.onSelect,
    this.selectedValue,
    required this.items,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        borderRadius: BorderRadius.circular(9),
        borderOnForeground: true,
        child: InkWell(
          borderRadius: BorderRadius.circular(9),
          onTap: () {
            Get.bottomSheet(BottomSheet(
                onClosing: () {},
                builder: (context) => Container(
                      // height: Get.height * 0.31,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(9)),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title,
                                style: Get.textTheme.headlineMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: items.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: Radio(
                                          value:
                                              items[index].name.toUpperCase(),
                                          groupValue: selectedValue,
                                          onChanged: (e) {
                                            onSelect(items[index]);
                                          }),
                                      title: Text(items[index].name),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    )));
          },
          child: Ink(
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(selectedValue ?? '', style: Get.textTheme.labelLarge),
                  const Spacer(),
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.arrow_drop_down,
                        size: 28,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
