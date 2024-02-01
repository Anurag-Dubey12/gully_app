import 'package:json_annotation/json_annotation.dart';

part 'tournament_model.g.dart';

@JsonSerializable(createToJson: false)
class TournamentModel {
  @JsonKey(name: '_id')
  final String id;
  final String tournamentName;
  final DateTime tournamentStartDateTime;
  final DateTime tournamentEndDateTime;
  final double fees;
  @JsonKey(defaultValue: 0, disallowNullValue: false)
  final int tournamentLimit;
  @JsonKey(defaultValue: 0)
  final int registeredTeamsCount;
  int pendingTeamsCount;
  @JsonKey(disallowNullValue: false)
  final String? phoneNumber;

  final int ballCharges;
  final int breakfastCharges;
  @JsonKey(fromJson: extractName)
  final String ballType;
  @JsonKey(fromJson: extractName)
  final String pitchType;
  final String stadiumAddress;
  @JsonKey(disallowNullValue: false)
  final String? disclaimer;
  @JsonKey(disallowNullValue: false)
  final String? rules;
  @JsonKey(fromJson: extractName)
  final String? tournamentPrize;
  final String? organizerName;

  TournamentModel(
      {required this.tournamentName,
      required this.id,
      required this.disclaimer,
      required this.rules,
      required this.tournamentPrize,
      required this.organizerName,
      required this.ballCharges,
      required this.pendingTeamsCount,
      required this.phoneNumber,
      required this.tournamentLimit,
      required this.registeredTeamsCount,
      required this.stadiumAddress,
      required this.tournamentStartDateTime,
      required this.tournamentEndDateTime,
      required this.pitchType,
      required this.breakfastCharges,
      required this.ballType,
      // required this.tournamentListType,
      required this.fees});
  factory TournamentModel.fromJson(Map<String, dynamic> json) =>
      _$TournamentModelFromJson(json);

  static TournamentListType tournamentListTypeFromJson(String value) {
    switch (value) {
      case 'upcoming':
        return TournamentListType.upcoming;
      case 'ongoing':
        return TournamentListType.ongoing;
      case 'completed':
        return TournamentListType.completed;
      default:
        return TournamentListType.upcoming;
    }
  }

  static String extractName(Map<String, dynamic> value) {
    return value['name'];
  }
}

enum TournamentListType { upcoming, ongoing, completed }
