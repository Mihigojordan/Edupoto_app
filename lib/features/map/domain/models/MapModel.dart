
class Mapmodel {
  final List<SimplifiedPrediction>? predictions;
  final String status;

  Mapmodel({
    this.predictions,
    required this.status,
  });

  factory Mapmodel.fromJson(Map<String, dynamic> json) =>
      Mapmodel(
        predictions: (json['predictions'] as List<dynamic>?)
            ?.map((e) => SimplifiedPrediction.fromJson(e as Map<String, dynamic>))
            .toList(),
        status: json['status'] as String,
      );
}

class SimplifiedPrediction {
  final String description;
  final String placeId;
  final String mainText;
  final String secondaryText;

  SimplifiedPrediction({
    required this.description,
    required this.placeId,
    required this.mainText,
    required this.secondaryText,
  });

  factory SimplifiedPrediction.fromJson(Map<String, dynamic> json) =>
      SimplifiedPrediction(
        description: json['description'] as String,
        placeId: json['place_id'] as String,
        mainText: json['structured_formatting']['main_text'] as String,
        secondaryText: json['structured_formatting']['secondary_text'] as String,
      );
}