class Config {
  Logging logging;
  Air air;
  Soil soil;

  Config({required this.logging, required this.air, required this.soil});
}

class Logging {
  String id;
  bool active;
  String hubUrl;
  String restUrl;

  Logging({required this.id, required this.active, required this.hubUrl, required this.restUrl});
}

class Air {
  double minHumid;
  double maxHumid;
  double minTemp;
  double maxTemp;

  Air({required this.minHumid, required this.maxHumid, required this.minTemp, required this.maxTemp});
}

class Soil {
  double moist;
  double dry;

  Soil({required this.moist, required this.dry});
}
