import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gully_app/config/preferences.dart';
import 'package:gully_app/data/controller/tournament_controller.dart';
import 'package:gully_app/ui/theme/theme.dart';
import 'package:gully_app/utils/date_time_helpers.dart';

import '../../screens/search_tournament_screen.dart';
import 'current_tournament_card.dart';
import 'future_tournament_card.dart';
import 'past_tournament_card.dart';

class TournamentList extends StatefulWidget {
  const TournamentList({
    super.key,
  });

  @override
  State<TournamentList> createState() => _TournamentListState();
}

class _TournamentListState extends State<TournamentList> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TournamentController>();
    return Container(
      width: Get.width,
      // height: Get.height * 0.54,
      margin: const EdgeInsets.only(top: 10),
      color: Colors.black26,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
              child: Material(
                borderRadius: BorderRadius.circular(28),
                child: InkWell(
                  borderRadius: BorderRadius.circular(28),
                  onTap: () {
                    final pref = Get.find<Preferences>();
                    // pref.setLanguageFalse();
                    Get.to(() => const SearchTournamentScreen());
                  },
                  child: Ink(
                    width: Get.width,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28)),
                    child: const Row(
                      children: [
                        SizedBox(width: 18),
                        Icon(
                          Icons.search,
                          color: AppTheme.secondaryYellowColor,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text('Search...')
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  heightFactor: 13,
                  child: CircularProgressIndicator(),
                );
              }
              if ((isDateTimeToday(controller.selectedDate.value) ||
                      controller.filter.value == 'current') &&
                  controller.filter.value != 'upcoming' &&
                  controller.filter.value != 'past') {
                log('Show Current Tournament Card');
                return const CurrentTournamentCard();
              } else if ((isDateTimeInPast(controller.selectedDate.value) ||
                      controller.filter.value == 'past') &&
                  controller.filter.value != 'upcoming') {
                log('Show Past Tournament Card');
                return const PastTournamentMatchCard();
              } else {
                log('Show Future Tournament Card');
                return const FutureTournamentCard();
              }
            }),
          ],
        ),
      ),
    );
  }
}
