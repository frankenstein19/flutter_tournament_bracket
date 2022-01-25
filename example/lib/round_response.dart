// To parse this JSON data, do
//
//     final roundResponse = roundResponseFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

class RoundResponse {
  RoundResponse({
    this.teams,
  });

  final List<List<Team>>? teams;

  factory RoundResponse.fromRawJson(String str) => RoundResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RoundResponse.fromJson(Map<String, dynamic> json) => RoundResponse(
    teams: json["teams"] == null ? null : List<List<Team>>.from(json["teams"].map((x) => List<Team>.from(x.map((x) => Team.fromJson(x))))),
  );

  Map<String, dynamic> toJson() => {
    "teams": teams == null ? null : List<dynamic>.from(teams!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
  };
}

class Team {
  Team({
    this.id,
    this.name,
    this.matchId,
    this.score,
  });

  final int? id;
  final String? name;
  final int? matchId;
  final int? score;
  final GlobalKey key=GlobalKey();
  factory Team.fromRawJson(String str) => Team.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Team.fromJson(Map<String, dynamic> json) => Team(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    matchId: json["match_id"] == null ? null : json["match_id"],
    score: json["score"] == null ? null : json["score"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "match_id": matchId == null ? null : matchId,
    "score": score == null ? null : score,
  };
}
