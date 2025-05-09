import 'package:flutter/material.dart';

class IButtonDialog extends StatelessWidget {
  final String organizerName;
  final String location;
  final String tournamentName;
  final String tournamentPrice;
  final String? coverPhoto;
  const IButtonDialog(
      {super.key,
      required this.organizerName,
      required this.location,
      required this.tournamentName,
      required this.tournamentPrice,
      this.coverPhoto,
      });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // coverPhoto != null
          //     ? SizedBox(
          //   height: 150,
          //   child: Stack(
          //     children: [
          //       ClipRRect(
          //         borderRadius: const BorderRadius.only(
          //             topLeft: Radius.circular(20),
          //             topRight: Radius.circular(20)),
          //         child: SizedBox(
          //           width: Get.width,
          //           height: 170,
          //           child: coverPhoto != null && coverPhoto!.isNotEmpty
          //               ? Image.network(
          //             toImageUrl(coverPhoto!),
          //             fit: BoxFit.cover,
          //             errorBuilder: (context, error, stackTrace) {
          //               return Image.asset(
          //                 'assets/images/logo.png',
          //                 fit: BoxFit.cover,
          //               );
          //             },
          //           )
          //               : Image.asset(
          //             'assets/images/logo.png',
          //             fit: BoxFit.cover,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // )
          //     : const SizedBox(),
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Center(
                  child: Text(
                    'Info',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xffbecbff),
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0x0fe9e7ef),
                            blurRadius: 20,
                            spreadRadius: 2,
                            offset: Offset(0, 70))
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(children: [
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          const Text('Tournament Name:',
                              style: TextStyle(fontSize: 14)),
                          const Spacer(),
                          Text(tournamentName,softWrap: true,maxLines:3),
                          const SizedBox(width: 10),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          const Text('Organizer Name:',
                              style: TextStyle(fontSize: 14)),
                          const Spacer(),
                          Text(organizerName),
                          const SizedBox(width: 10),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 10),
                          const Text('Location:',
                              maxLines: 4, style: TextStyle(fontSize: 14)),
                          const Spacer(),
                          SizedBox(
                              width: 180,
                              // height: 70,
                              child: Text(location,
                                  maxLines: 3,
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(fontSize: 13))),
                          const SizedBox(width: 10),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          const Text('Entry Fees:',
                              style: TextStyle(fontSize: 14)),
                          const Spacer(),
                          Text(tournamentPrice),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ]),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
