import 'package:gully_app/data/controller/scoreboard_controller.dart';
import 'package:gully_app/data/model/overs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bowling_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BowlingModel {
  Map<String, OverModel> overs = {
    "0.0": OverModel(
        over: 0, ball: 0, run: 0, wickets: 0, extra: 0, total: 0, events: [])
  };
  int runs = 0;
  int wickets = 0;
  double economy = 0;
  int currentOver = 0;
  int currentBall = 0;
  int maidens = 0;
  int fours = 0;
  int sixes = 0;
  int wides = 0;
  int noBalls = 0;

  BowlingModel(
      {required this.runs,
      required this.wickets,
      required this.economy,
      required this.maidens,
      required this.fours,
      required this.sixes,
      required this.wides,
      required this.noBalls});

  factory BowlingModel.fromJson(Map<String, dynamic> json) =>
      _$BowlingModelFromJson(json);
  Map<String, dynamic> toJson() => _$BowlingModelToJson(this);

  void addRuns(int run, {List<EventType>? events}) {
    events ??= [];
    if (!events.contains(EventType.wide) &&
        !events.contains(EventType.noBall)) {
      currentBall = currentBall + 1;
    }
    runs = runs + run;
    for (var element in events) {
      switch (element) {
        case EventType.four:
          fours = fours + 1;
          break;
        case EventType.six:
          sixes = sixes + 1;
          break;
        case EventType.wide:
          wides = wides + 1;
          runs = runs + 1;
          break;
        case EventType.noBall:
          noBalls = noBalls + 1;
          break;
        case EventType.wicket:
          wickets = wickets + 1;

          break;
        default:
          break;
      }
    }
    overs["$currentOver.$currentBall"] = OverModel(
        over: currentOver,
        ball: currentBall,
        run: 0,
        wickets: 0,
        extra: 0,
        total: 0,
        events: []);
    if (currentBall == 6) {
      currentBall = 0;
      currentOver += 1;
    }
  }
}
