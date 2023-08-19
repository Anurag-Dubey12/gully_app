import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gully_app/src/ui/screens/contact_us_screen.dart';

import '../theme/theme.dart';
import '../widgets/arc_clipper.dart';

class SearchChallengeTeam extends StatelessWidget {
  const SearchChallengeTeam({super.key});

  @override
  Widget build(BuildContext context) {
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
                child: SizedBox(
              width: Get.width,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 0, top: 30),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: BackButton(
                          color: Colors.white,
                        )),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Challenge team',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height * 0.04),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: const Color.fromARGB(132, 61, 60, 58)
                                .withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 2,
                            offset: const Offset(0, 7))
                      ],
                    ),
                    height: 54,
                    width: Get.width / 1.2,
                    child: TextField(
                      onTap: () {},
                      decoration: InputDecoration(
                        isDense: true,

                        suffixIcon: const Icon(
                          CupertinoIcons.search,
                          color: AppTheme.secondaryYellowColor,
                          size: 28,
                        ),
                        labelText: 'Search..',
                        labelStyle: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        // isCollapsed: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      color: Color.fromARGB(96, 82, 80, 124),
                      child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: ListView.separated(
                            itemBuilder: (context, index) => _TeamCard(),
                            separatorBuilder: (context, index) => SizedBox(
                              height: 20,
                            ),
                            itemCount: 3,
                            shrinkWrap: true,
                          ))),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class _TeamCard extends StatelessWidget {
  const _TeamCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(children: [
          CircleAvatar(),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'CSK',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              const Text(
                '20th April 2021',
                style: TextStyle(
                    fontSize: 13, color: Color.fromARGB(255, 255, 154, 22)),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Chip(
                label: Text('Accept', style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.green,
                side: BorderSide.none,
              ),
              const SizedBox(width: 10),
              Chip(
                  label: Text('Decline', style: TextStyle(color: Colors.white)),
                  backgroundColor: Colors.red,
                  side: BorderSide.none),
            ],
          )
        ]),
      ),
    );
  }
}
