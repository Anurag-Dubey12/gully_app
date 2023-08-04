import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gully_app/src/ui/screens/team_request.dart';
import '../theme/theme.dart';
import '../widgets/arc_clipper.dart';

class ViewTeam extends StatefulWidget {
  const ViewTeam({super.key});

  @override
  State<ViewTeam> createState() => _ViewTeamState();
}

class _ViewTeamState extends State<ViewTeam> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                    width: Get.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 0, top: 30),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: BackButton(
                                color: Colors.white,
                              )),
                        ),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Column(
                                  children: [
                                    Text('Black Panther',
                                        style: Get.textTheme.headlineLarge
                                            ?.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                    Text('Hello Bhavesh, meet your teammates!',
                                        style: Get.textTheme.headlineLarge
                                            ?.copyWith(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300)),
                                  ],
                                ),
                              ),
                              SizedBox(height: Get.height * 0.04),
                              Center(
                                child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: AppTheme.primaryColor,
                                            width: 1)),
                                    child: const Padding(
                                      padding: EdgeInsets.all(3.0),
                                      child: Stack(
                                        children: [
                                          CircleAvatar(
                                            radius: 49,
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: CircleAvatar(
                                              radius: 10,
                                              backgroundColor:
                                                  AppTheme.secondaryYellowColor,
                                              child: Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                              SizedBox(height: Get.height * 0.02),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.separated(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    shrinkWrap: true,
                                    itemCount: 4,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 14),
                                    itemBuilder: (context, snapshot) {
                                      return InkWell(
                                        onTap: () {
                                          Get.to(() => const TeamRequest());
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 255, 255, 255),
                                              borderRadius:
                                                  BorderRadius.circular(19),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                    blurRadius: 20,
                                                    spreadRadius: 2,
                                                    offset: const Offset(0, 10))
                                              ]),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Row(children: [
                                              const CircleAvatar(),
                                              const Spacer(),
                                              Text(
                                                'Bob Odenkirk',
                                                style: Get.textTheme.titleMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w400),
                                              ),
                                              const Spacer(),
                                            ]),
                                          ),
                                        ),
                                      );
                                    }),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }
}
