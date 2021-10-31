// To parse this JSON data, do
//
//     final predictionFileHistory = predictionFileHistoryFromMap(jsonString);

import 'dart:convert';

PredictionFileHistory predictionFileHistoryFromMap(String str) =>
    PredictionFileHistory.fromMap(json.decode(str));

String predictionFileHistoryToMap(PredictionFileHistory data) =>
    json.encode(data.toMap());

class PredictionFileHistory {
  PredictionFileHistory({
    required this.history,
  });

  List<History> history;

  factory PredictionFileHistory.fromMap(Map<String, dynamic> json) =>
      PredictionFileHistory(
        history:
            List<History>.from(json["history"].map((x) => History.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "history": List<dynamic>.from(history.map((x) => x.toMap())),
      };
}

class History {
  History({
    required this.fileId,
    this.selectedColumn,
    this.isClassification,
    this.isReady = false,
    required this.name,
  });

  String fileId;
  String? selectedColumn;
  bool? isClassification;
  bool isReady;
  String name;

  factory History.fromMap(Map<String, dynamic> json) => History(
        fileId: json["file id"],
        selectedColumn: json["selected column"],
        isClassification: json["is classification"],
        isReady: json["is ready"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "file id": fileId,
        "selected column": selectedColumn,
        "is classification": isClassification,
        "is ready": isReady,
        "name": name,
      };
}
