import 'package:get/get.dart';
import 'package:gully_app/data/api/team_api.dart';
import 'package:gully_app/data/model/challenge_match.dart';
import 'package:gully_app/data/model/opponent_model.dart';
import 'package:gully_app/data/model/player_model.dart';
import 'package:gully_app/data/model/team_model.dart';
import 'package:gully_app/utils/app_logger.dart';
import 'package:gully_app/utils/utils.dart';

class TeamController extends GetxController with StateMixin {
  final TeamApi repo;
  TeamController({required this.repo}) {
    change(GetStatus.empty());
  }
  Future<bool> createTeam(
      {required String teamName, required String? teamLogo}) async {
    try {
      change(GetStatus.loading());
      final response = await repo.createTeam(
        teamName: teamName,
        teamLogo: teamLogo,
      );
      if (response.status == false) {
        errorSnackBar(response.message!);
        return false;
      }
      change(GetStatus.success(TeamModel.fromJson(response.data!)));

      return true;
    } catch (e) {
      change(GetStatus.error(e.toString()));
      rethrow;
    }
  }

  Future<bool> updateTeam({
    required String teamName,
    required String? teamLogo,
    required String teamId,
  }) async {
    try {
      change(GetStatus.loading());
      final response = await repo.updateTeam(
        teamName: teamName,
        teamLogo: teamLogo,
        teamId: teamId,
      );
      if (response.status == false) {
        errorSnackBar(response.message!);
        return false;
      }
      change(GetStatus.success(TeamModel.fromJson(response.data!)));

      return true;
    } catch (e) {
      change(GetStatus.error(e.toString()));
      rethrow;
    }
  }

  RxList<PlayerModel> players = <PlayerModel>[].obs;
  Future<List<PlayerModel>> getPlayers(String teamId) async {
    final response = await repo.getPlayers(teamId: teamId);
    if (response.status == false) {
      errorSnackBar(response.message!);
    }
    final playersList = (response.data!['teamData']['players'] as List)
        .map((e) => PlayerModel.fromJson(e))
        .toList();

    players.value = playersList;
    return playersList;
  }

  Future<bool> addPlayerToTeam({
    required String teamId,
    required String name,
    required String phone,
    required String role,
  }) async {
    final response = await repo.addPlayerToTeam(
      teamId: teamId,
      name: name,
      phone: phone,
      role: role,
    );
    if (response.status == false) {
      errorSnackBar(response.message!);
      return false;
    }
    getPlayers(teamId);
    return true;
  }

  Future<bool> removePlayerFromTeam({
    required String teamId,
    required String playerId,
  }) async {
    try {
      final response = await repo.removePlayerFromTeam(
        teamId: teamId,
        playerId: playerId,
      );
      logger.i("70");
      players.value.removeWhere((element) => element.id == playerId);
      players.refresh();

      if (response.status == false) {
        errorSnackBar(response.message!);
        return false;
      }
      return true;
    } catch (e) {
      logger.i(e);
      return false;
    }
  }

  Future<List<TeamModel>> getTeams() async {
    try {
      final response = await repo.getTeams();

      if (response.status == false) {
        logger.i('error');
        errorSnackBar(response.message!);
        return [];
      }
      final teams = response.data!['teams'] as List;
      final teamList = teams.map((e) => TeamModel.fromJson(e)).toList();

      return teamList;
    } catch (e) {
      logger.i(e.toString());
      rethrow;
    }
  }

  Future<List<OpponentModel>> getOpponents() async {
    try {
      final response = await repo.getOpponents();

      if (response.status == false) {
        logger.i('error');
        errorSnackBar(response.message!);
        return [];
      }

      final opponents = response.data!['data'] as List;
      final opponentList =
          opponents.map((e) => OpponentModel.fromJson(e)).toList();

      return opponentList;
    } catch (e) {
      logger.i(e.toString());
      rethrow;
    }
  }

  Future<List<TeamModel>> getOpponentTeamList(
      String teamId, String tournamentId) async {
    try {
      final response = await repo.getOpponentTeams(teamId, tournamentId);

      if (response.status == false) {
        logger.i('error');
        errorSnackBar(response.message!);
        return [];
      }
      final teams = response.data!['matches'] as List;
      logger.f(teams.runtimeType);
      final teamList =
          teams.map((e) => TeamModel.fromJson(e['opponent'])).toList();
      logger.f(teamList);
      return teamList;
    } catch (e) {
      logger.i(e.toString());
      rethrow;
    }
  }

  // getAllNearByTeam
  Future<List<TeamModel>> getAllNearByTeam() async {
    try {
      final response = await repo.getAllNearByTeam();

      if (response.status == false) {
        logger.i('error');
        errorSnackBar(response.message!);
        return [];
      }
      final teams = response.data!['teams'] as List;
      final teamList = teams.map((e) => TeamModel.fromJson(e)).toList();
      logger.f(teams.length);

      return teamList;
    } catch (e) {
      logger.i(e.toString());
      rethrow;
    }
  }

  //getChallengeMatch
  Future<List<ChallengeMatchModel>> getChallengeMatch() async {
    try {
      final response = await repo.getChallengeMatch();

      if (response.status == false) {
        logger.i('error');
        errorSnackBar(response.message!);
        return [];
      }
      final matches = response.data!['matches'] as List;
      final matchList =
          matches.map((e) => ChallengeMatchModel.fromJson(e)).toList();
      logger.f(matchList.length);

      return matchList;
    } catch (e) {
      logger.i(e.toString());
      rethrow;
    }
  }
}
