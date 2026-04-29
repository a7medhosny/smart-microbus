enum TravelMode { driving, walking, cycling }

extension TravelModeExtension on TravelMode {
  String get value {
    switch (this) {
      case TravelMode.driving:
        return "Driving";
      case TravelMode.walking:
        return "Walking";
      case TravelMode.cycling:
        return "Cycling";
    }
  }
}
