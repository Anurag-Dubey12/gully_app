import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gully_app/data/controller/scoreboard_controller.dart';
import 'package:gully_app/ui/widgets/gradient_builder.dart';

import '../widgets/scorecard/batting_card.dart';
import '../widgets/scorecard/current_over_card.dart';
import '../widgets/scorecard/event_handler.dart';
import '../widgets/scorecard/top_scorecard.dart';

class ScoreCardScreen extends StatefulWidget {
  const ScoreCardScreen({super.key});

  @override
  State<ScoreCardScreen> createState() => _ScoreCardScreenState();
}

class _ScoreCardScreenState extends State<ScoreCardScreen> {
  @override
  void initState() {
    final controller = Get.find<ScoreBoardController>();
    controller.connectToSocket();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    final controller = Get.find<ScoreBoardController>();
    controller.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ScoreBoardController>();

    return Obx(() {
      if (controller.socket.value == null) {
        // controller.connectToSocket();
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }
      return GradientBuilder(
          child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: kDebugMode
            ? FloatingActionButton(
                onPressed: () {
                  // copy to clipboard

                  Clipboard.setData(ClipboardData(
                      text: jsonEncode(controller.scoreboard.value!.toJson())));
                },
                child: const Icon(Icons.copy),
              )
            : null,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
              '${controller.scoreboard.value?.team1.name} vs ${controller.scoreboard.value?.team2.name}',
              style: Get.textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              )),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            ScoreCard(),
            BattingStats(),
            CurrentOverStats(),
            Expanded(flex: 3, child: ScoreUpdater()),
          ]),
        ),
      ));
    });
  }
}
