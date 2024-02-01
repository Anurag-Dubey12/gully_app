import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gully_app/data/controller/tournament_controller.dart';
import 'package:gully_app/data/model/tournament_model.dart';
import 'package:gully_app/ui/screens/view_tournaments_screen.dart';

import '../theme/theme.dart';
import '../widgets/arc_clipper.dart';
import '../widgets/requests_bottom_sheet.dart';

class TournamentRequestScreen extends GetView<TournamentController> {
  const TournamentRequestScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage(
                'assets/images/sports_icon.png',
              ),
              fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Stack(children: [
              ClipPath(
                clipper: ArcClipper(),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const RadialGradient(
                      colors: [
                        Color(0xff368EBF),
                        AppTheme.primaryColor,
                      ],
                      center: Alignment(-0.4, -0.8),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: AppTheme.secondaryYellowColor.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 2,
                          offset: const Offset(0, 70))
                    ],
                  ),
                  width: double.infinity,
                ),
              ),
              Positioned(
                top: 0,
                child: SizedBox(
                  width: Get.width,
                  child: Column(
                    children: [
                      AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        title: Text('Select Tournament',
                            style: Get.textTheme.headlineMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        leading: const BackButton(
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.07,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: Get.height * 0.02),
                            Obx(() {
                              if (controller.organizerTournamentList.isEmpty) {
                                return const EmptyTournamentWidget();
                              }

                              return ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 18),
                                  shrinkWrap: true,
                                  itemCount:
                                      controller.organizerTournamentList.length,
                                  itemBuilder: (context, index) {
                                    return _Card(
                                      tournament: controller
                                          .organizerTournamentList[index],
                                    );
                                  });
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]),
          ),
        ));
  }
}

class _Card extends StatelessWidget {
  final TournamentModel tournament;

  const _Card({
    required this.tournament,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(BottomSheet(
          enableDrag: false,
          builder: (context) => RequestsBottomSheet(
            tournament: tournament,
          ),
          onClosing: () {},
        ));
      },
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  spreadRadius: 2,
                  offset: const Offset(0, 1))
            ],
            borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.05,
            vertical: Get.height * 0.02,
          ),
          child: Row(
            children: [
              const Spacer(),
              Text(
                tournament.tournamentName,
                style: Get.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600, fontSize: 19),
              ),
              const Spacer(),
              tournament.registeredTeamsCount == tournament.tournamentLimit
                  ? Chip(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.white)),
                      label: Text(
                        'FULL',
                        style: Get.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                    )
                  : Chip(
                      backgroundColor: AppTheme.secondaryYellowColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.white)),
                      label: Text(
                        '${tournament.pendingTeamsCount}/${tournament.tournamentLimit}',
                        style: Get.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
