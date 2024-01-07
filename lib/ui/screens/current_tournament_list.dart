import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gully_app/data/controller/tournament_controller.dart';
import 'package:gully_app/data/model/tournament_model.dart';

import '../theme/theme.dart';
import '../widgets/arc_clipper.dart';

class CurrentTournamentListScreen extends GetView<TournamentController> {
  final Widget redirectScreen;
  const CurrentTournamentListScreen({super.key, required this.redirectScreen});

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
                        title: Text('Current Tournament',
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
                            FutureBuilder<List<TournamentModel>>(
                                future: controller.getOrganizerTournamentList(),
                                builder: (context, snapshot) {
                                  return ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(height: 18),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        return _Card(
                                          tournament: snapshot.data![index],
                                          redirectScreen: redirectScreen,
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
  final Widget redirectScreen;
  const _Card({required this.tournament, required this.redirectScreen});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => redirectScreen);
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
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey[200],
              ),
              const Spacer(),
              Text(
                tournament.tournamentName,
                style: Get.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600, fontSize: 19),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
