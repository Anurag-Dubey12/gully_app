import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gully_app/data/model/player_ranking_model.dart';
import 'package:gully_app/utils/utils.dart';

import '../../data/controller/ranking_controller.dart';
import '../../utils/date_time_helpers.dart';
import '../theme/theme.dart';
import '../widgets/arc_clipper.dart';

class TopPerformersScreen extends StatefulWidget {
  const TopPerformersScreen({super.key});

  @override
  State<TopPerformersScreen> createState() => _TopPerformersScreenState();
}

class _TopPerformersScreenState extends State<TopPerformersScreen> {
  int _selectedTab = 0;
  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    final controller = Get.putOrFind(() => RankingController(Get.find()));
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('assets/images/sports_icon.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
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
                    height: Get.height,
                    width: Get.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          iconTheme: const IconThemeData(color: Colors.white),
                          title: const Text('Top Performers',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 27)),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _SelectBallTypeCard(
                                tab: 0,
                                selectedTab: _selectedTab,
                                text: 'Leather ball',
                                onTap: (st) {
                                  setState(() {
                                    // ignore: unnecessary_statements
                                    _selectedTab = 0;
                                  });
                                },
                              ),
                              const SizedBox(width: 10),
                              _SelectBallTypeCard(
                                tab: 1,
                                selectedTab: _selectedTab,
                                text: 'Tennis ball',
                                onTap: (st) {
                                  setState(() {
                                    _selectedTab = st;
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Daily top Perfomer',
                                style: Get.textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade800,
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          color: Colors.black26,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2021),
                                            lastDate: DateTime(2025))
                                        .then((value) {
                                      setState(() {
                                        selectedDate = value;
                                      });
                                    });
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(40)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(width: 10),
                                          Text(
                                              selectedDate == null
                                                  ? 'Today'
                                                  : formatDateTime(
                                                      'dd MMMM yyyy',
                                                      selectedDate!),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14)),
                                          const SizedBox(width: 10),
                                          const Icon(
                                            Icons.calendar_month,
                                            color:
                                                AppTheme.secondaryYellowColor,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: Container(
                            color: Colors.black26,
                            // height: Get.height * 0.6,
                            child: FutureBuilder<List<PlayerRankingModel>>(
                                future: controller.getTopPerformers(
                                    _selectedTab == 0 ? 'leather' : 'tennis',
                                    selectedDate ?? DateTime.now()
                                ),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const Center(child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(child: Text('Error: ${snapshot.error}'));
                                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                    return const Center(child: Text('No top performers found'));
                                  } else {
                                    return ListView.separated(
                                        padding: const EdgeInsets.all(20),
                                        itemCount: snapshot.data!.length,
                                        shrinkWrap: true,
                                        separatorBuilder: (c, i) => const SizedBox(height: 10),
                                        itemBuilder: (c, i) => _PlayerCard(player: snapshot.data![i])
                                    );
                                  }
                                }
                            ),
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          )),
    );
  }
}

class _PlayerCard extends StatelessWidget {
  final PlayerRankingModel player;
  const _PlayerCard({
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 29,
              backgroundImage:
                  NetworkImage(toImageUrl(player.profilePhoto ?? "")),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(player.playerName,
                    style: Get.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black)),
                // Text(
                //   'Since ${formatDateTime('dd.MM.yyyy', player.registeredAt)}',
                //   style:
                //       Get.textTheme.bodyMedium?.copyWith(color: Colors.black54),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _SelectBallTypeCard extends StatelessWidget {
  final int tab;
  final int selectedTab;
  final String text;
  final Function(int tab) onTap;

  const _SelectBallTypeCard({
    required this.onTap,
    required this.tab,
    required this.selectedTab,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
          onTap: () => onTap(tab),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: tab == selectedTab
                  ? AppTheme.secondaryYellowColor
                  : Colors.white,
              boxShadow: [
                BoxShadow(
                    color: AppTheme.secondaryYellowColor.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: const Offset(0, 7))
              ],
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(text,
                    style: Get.textTheme.bodyLarge?.copyWith(
                        color: selectedTab == tab ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ),
    );
  }
}
