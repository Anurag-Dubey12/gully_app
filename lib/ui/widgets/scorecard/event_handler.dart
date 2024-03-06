import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gully_app/utils/utils.dart';

import '../../../data/controller/scoreboard_controller.dart';
import '../../theme/theme.dart';
import '../primary_button.dart';
import 'event_cards.dart';
import 'scorecard_dialogs.dart';

class ScoreUpdater extends GetView<ScoreBoardController> {
  const ScoreUpdater({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const UpdateEvent(),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              crossAxisSpacing: 10,
                              childAspectRatio: 3,
                              mainAxisSpacing: 10),
                      children: [
                        SizedBox(
                          height: 10,
                          child: PrimaryButton(
                            onTap: () {
                              controller.undoLastEvent();
                            },
                            title: 'Undo',
                            fontSize: 12 * Get.textScaleFactor,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          child: PrimaryButton(
                            onTap: () {
                              Get.bottomSheet(
                                const PartnershipDialog(),
                              );
                            },
                            title: 'Partnership',
                            fontSize: 12 * Get.textScaleFactor,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                          child: PrimaryButton(
                            onTap: () {
                              Get.bottomSheet(const ExtrasDialog());
                            },
                            title: 'Extras',
                            fontSize: 12 * Get.textScaleFactor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Container(
                      // height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          runAlignment: WrapAlignment.spaceEvenly,
                          children: [
                            NumberCard(
                              text: '0',
                              onTap: () {
                                if (controller.events.contains(EventType.bye) ||
                                    controller.events
                                        .contains(EventType.legByes)) {
                                  errorSnackBar(
                                      'You can not add a dot ball and a bye or leg bye');
                                  return;
                                }

                                controller.addEvent(EventType.dotBall);
                              },
                            ),
                            NumberCard(
                              text: '1',
                              onTap: () {
                                controller.addEvent(EventType.one);
                              },
                            ),
                            NumberCard(
                              text: '2',
                              onTap: () {
                                controller.addEvent(EventType.two);
                              },
                            ),
                            NumberCard(
                              text: '3',
                              onTap: () {
                                controller.addEvent(EventType.three);
                              },
                            ),
                            NumberCard(
                              text: '4',
                              onTap: () {
                                if (controller.events.contains(EventType.bye) ||
                                    controller.events
                                        .contains(EventType.legByes)) {
                                  errorSnackBar(
                                      'You can not add a four and a bye or leg bye');
                                  return;
                                }
                                if (controller.events
                                    .contains(EventType.wide)) {
                                  errorSnackBar(
                                      'You can not add a four and a wide ball');
                                  return;
                                }
                                if (controller.events
                                    .contains(EventType.wicket)) {
                                  errorSnackBar(
                                      'You can not add a four and a wicket');
                                  return;
                                }
                                controller.addEvent(EventType.four);
                              },
                            ),
                            NumberCard(
                              text: '5',
                              onTap: () {},
                            ),
                            NumberCard(
                              text: '6',
                              onTap: () {
                                if (controller.events.contains(EventType.bye) ||
                                    controller.events
                                        .contains(EventType.legByes)) {
                                  errorSnackBar(
                                      'You can not add a six and a bye or leg bye');
                                  return;
                                }
                                if (controller.events
                                    .contains(EventType.wide)) {
                                  errorSnackBar(
                                      'You can not add a six and a wide ball');
                                  return;
                                }
                                if (controller.events
                                    .contains(EventType.wicket)) {
                                  errorSnackBar(
                                      'You can not add a six and a wicket');
                                  return;
                                }

                                controller.addEvent(EventType.six);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() => controller.scoreboard.value!.currentInnings == 1
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                  width: Get.width,
                                  height: 40,
                                  child: TextButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  AppTheme.primaryColor),
                                          padding: MaterialStateProperty.all(
                                              const EdgeInsets.all(7))),
                                      onPressed: () {
                                        Get.bottomSheet(
                                            const EndOfIningsDialog(),
                                            isScrollControlled: true,
                                            ignoreSafeArea: true);
                                      },
                                      child: const Text('Start 2nd Innings',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500)))),
                            ),
                          )
                        : const SizedBox())
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
