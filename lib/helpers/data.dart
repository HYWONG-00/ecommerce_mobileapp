class Data {
  /// Singleton
  static final Data _instance = Data._internal();
  factory Data() => _instance;
  Data._internal();

  static const Duration duration = Duration(milliseconds: 480);

  static bool isList(data) {
    return data != null && data is Iterable && data.isNotEmpty;
  }

  static bool toBool(data, {bool preset = false}) {
    if (data == null) {
      return preset;
    } else {
      if (data is bool) return data;
      if (data is int) {
        if (data == 0) return false;
        if (data == 1) return true;
      }
      if (data is String) {
        int? integer = int.tryParse(data);
        if (integer == null) return preset;
        if (integer == 0) return false;
        if (integer == 1) return true;
      }
      return preset;
    }
  }

  static String toStr(data, {String preset = ""}) {
    if (data == null) {
      return preset;
    } else {
      if (data is String) {
        if (data.isEmpty) {
          return preset;
        } else {
          return data;
        }
      } else {
        return data.toString();
      }
    }
  }

  static String? nullStr(data, {String? preset}) {
    String value = toStr(data);
    if (value.isEmpty) {
      return preset;
    } else {
      return value;
    }
  }

  static List<String> toStrList(data, {List<String>? preset}) {
    List<String> list = preset ?? <String>[];
    if (isList(data)) {
      for (var v in data) {
        list.add(toStr(v));
      }
    }
    return list;
  }

  static int toInt(data, {int preset = 0}) {
    if (data == null) {
      return preset;
    } else {
      if (data is int) return data;
      if (data is double) return data.round();
      if (data is bool) return data ? 1 : 0;
      if (data is String) {
        int? integer = int.tryParse(data);
        if (integer == null) {
          double? float = double.tryParse(data);
          return float == null ? preset : float.round();
        } else {
          return integer;
        }
      }
      return preset;
    }
  }

  static int? absInt(data, {int? preset}) {
    int value = toInt(data);
    return value > 0 ? value : preset;
  }

  static List<int> toIntList(data, {List<int>? preset}) {
    List<int> list = preset ?? <int>[];
    if (isList(data)) {
      for (var v in data) {
        list.add(toInt(v));
      }
    }
    return list;
  }

  static double toDouble(data, {double preset = 0.0}) {
    if (data == null) {
      return preset;
    } else {
      if (data is double) return data;
      if (data is int) return data.toDouble();
      if (data is String) {
        double? float = double.tryParse(data);
        return float ?? preset;
      }
      return preset;
    }
  }

  static double? absDouble(data, {double? preset}) {
    double value = toDouble(data);
    return value > 0.0 ? value : preset;
  }

  static List<double> toDoubleList(data, {List<double>? preset}) {
    List<double> list = preset ?? <double>[];
    if (isList(data)) {
      for (var v in data) {
        list.add(toDouble(v));
      }
    }
    return list;
  }

  static Map<String, dynamic> toMap(data, {Map<String, dynamic>? preset}) {
    return data != null && data is Map<String, dynamic>
        ? data
        : preset ?? <String, dynamic>{};
  }

  static List<Map<String, dynamic>> toMapList(data,
      {List<Map<String, dynamic>>? preset}) {
    List<Map<String, dynamic>> list = preset ?? <Map<String, dynamic>>[];
    if (isList(data)) {
      for (var v in data) {
        if (v is Map<String, dynamic>) list.add(v);
      }
    }
    return list;
  }

  static int toEpochSeconds(DateTime? datetime) {
    return datetime == null ? 0 : datetime.millisecondsSinceEpoch ~/ 1000;
  }

  static DateTime? toDateTime(int seconds) {
    return seconds > 0
        ? DateTime.fromMillisecondsSinceEpoch(seconds * 1000)
        : null;
  }

  static String toDateTimeStr(int seconds,
      {bool date = false, bool time = false, bool military = false}) {
    final DateTime datetime = toDateTime(seconds) ?? DateTime.now();
    final List<String> _split = datetime.toString().split(" ");
    final String _date = _split[0];
    final String _time = Data.toTime(_split[1], military);
    if (date && time) {
      return _date + " " + _time;
    } else {
      return date ? _date : _time;
    }
  }

  static String toTime(String text, bool military) {
    final List<String> _split = text.split(":");
    final String _min = ":" + _split[1];
    if (military) {
      return _split[0] + _min;
    } else {
      final int _hour = Data.toInt(_split[0]);
      if (_hour >= 12) {
        return (_hour - (_hour == 12 ? 0 : 12)).toString() + _min + " PM";
      } else {
        return (_hour == 0 ? "12" : _split[0]) + _min + " AM";
      }
    }
  }
}