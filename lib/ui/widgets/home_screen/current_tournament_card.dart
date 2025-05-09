import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gully_app/data/controller/tournament_controller.dart';
import 'package:gully_app/data/model/matchup_model.dart';
import 'package:gully_app/ui/widgets/home_screen/no_tournament_card.dart';

import '../../../data/model/scoreboard_model.dart';
import '../../../utils/FallbackImageProvider.dart';
import '../../../utils/image_picker_helper.dart';
import '../../../utils/utils.dart';
import '../dialogs/current_score_dialog.dart';
import 'i_button_dialog.dart';

class CurrentTournamentCard extends GetView<TournamentController> {
  const CurrentTournamentCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: Get.height * 0.5,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Obx(() {
          if (controller.tournamentList.isEmpty) {
            return const NoTournamentCard();
          }
          if(controller.matches.isEmpty){
            return const NoTournamentCard();
          }
          else {
            return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.matches.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 10, top: 10),
                itemBuilder: (context, snapshot) {
                  return _Card(
                    tournament: controller.matches[snapshot],
                  );
                });
          }
        }),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final MatchupModel tournament;
  const _Card({
    required this.tournament,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TournamentController>();
    final tournamentdata = controller.tournamentList
        .firstWhere((t) => t.id == tournament.tournamentId);
    ScoreboardModel? scoreboard = tournament.scoreBoard == null
        ? null
        : ScoreboardModel.fromJson(tournament.scoreBoard!);
    return Padding(
      key: super.key,
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                spreadRadius: 2,
                offset: const Offset(0, 1)
            )
          ],
        ),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      imageViewer(context, tournamentdata.coverPhoto,true);
                    },
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: tournamentdata.coverPhoto != null && tournamentdata.coverPhoto!.isNotEmpty
                          ? FallbackImageProvider(
                          toImageUrl(tournamentdata.coverPhoto!),
                          'assets/images/logo.png'
                      ) as ImageProvider
                          : const AssetImage('assets/images/logo.png'),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              tournament.tournamentName ?? 'Unknown Tournament',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            IconButton(
                              onPressed: () {
                                Get.bottomSheet(
                                  IButtonDialog(
                                    organizerName: tournamentdata.organizerName!,
                                    location: tournamentdata.stadiumAddress,
                                    tournamentName: tournamentdata.tournamentName,
                                    tournamentPrice: tournamentdata.fees.toString(),
                                    coverPhoto: tournamentdata.coverPhoto,
                                  ),
                                  backgroundColor: Colors.white,
                                );
                              },
                              icon: const Icon(Icons.info_outline_rounded, size: 18),
                              color: Colors.grey,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      _TeamScore(
                        color: Colors.red,
                        teamName: tournament.team1.name,
                        score: _getScore(scoreboard?.firstInnings),
                      ),
                      const SizedBox(height: 4),
                      _TeamScore(
                        teamName: tournament.team2.name,
                        score: _getScore(scoreboard?.secondInnings),
                        color: Colors.green.shade600,
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: 30,
                          width: 100,
                          child: ElevatedButton(
                              onPressed: () {
                                Get.bottomSheet(
                                  BottomSheet(
                                    enableDrag: false,
                                    builder: (context) => ScoreBottomDialog(
                                      match: tournament,
                                    ),
                                    onClosing: () {},
                                  ),
                                  isScrollControlled: true,
                                );
                              },
                              style: ButtonStyle(
                                padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 8)),
                              ),
                              child: Text('View Score',
                                  style: Get.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white
                                  )
                              )
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            ),
            const Positioned(
              top: 8,
              right: 8,
              child: BlinkingLiveText(),
            ),
          ],
        ),
      ),
    );
  }

  String _getScore(dynamic innings) {
    if (innings == null) return 'YTB';
    int? totalScore = innings.totalScore;
    int? totalWickets = innings.totalWickets;
    if (totalScore == null || totalWickets == null) return 'N/A';
    return '$totalScore/$totalWickets';
  }
}

class BlinkingLiveText extends StatefulWidget {
  const BlinkingLiveText({super.key});

  @override
  _BlinkingLiveTextState createState() => _BlinkingLiveTextState();
}

class _BlinkingLiveTextState extends State<BlinkingLiveText> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Text(
          "Live",
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class _TeamScore extends StatelessWidget {
  final String teamName;
  final String score;
  final Color color;

  const _TeamScore({
    required this.teamName,
    required this.score,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 3),
          Expanded(
            child: Text(
              teamName,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13
              ),
            ),
          ),
          Text(
            score,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13
            ),
          ),
        ],
      ),
    );
  }
}