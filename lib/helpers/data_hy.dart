import '../import.dart';
import 'package:intl/intl.dart';

class Data {
  /// Singleton
  static final Data _instance = Data._internal();
  factory Data() => _instance;
  Data._internal();

  static const Duration duration = Duration(milliseconds: 480);

  static bool isList(data) {
    return data != null && data is Iterable && data.isNotEmpty;
  }

  static bool toBool(dynamic data, {bool preset = false}) {
    if (data == null) {
      return preset;
    }

    if (data is bool) {
      return data;
    }

    if (data is int) {
      return data == 1;
    }

    if (data is String) {
      int? integer = int.tryParse(data);
      if (integer == 0) {
        return false;
      } else if (integer == 1) {
        return true;
      }
    }

    return preset;
  }

  static String toStr(dynamic data, {String preset = ""}) {
    if (data == null || (data is String && data.isEmpty)) {
      return preset;
    }
    return data.toString();
  }

  static String? nullStr(data, {String? preset}) {
    String value = toStr(data);
    if (value.isEmpty) {
      return preset;
    } else {
      return value;
    }
  }

  static List<String> toStrList(dynamic data, {List<String>? preset}) {
    List<String> list = preset ?? [];
    if (data is List) {
      list.addAll(data.map((v) => toStr(v)));
    }
    return list;
  }


  static int toInt(dynamic data, {int preset = 0}) {
    if (data == null) {
      return preset;
    } else if (data is int) {
      return data;
    } else if (data is double) {
      return data.round();
    } else if (data is bool) {
      return data ? 1 : 0;
    } else if (data is String) {
      int? integer = int.tryParse(data);
      if (integer != null) {
        return integer;
      } else {
        double? float = double.tryParse(data);
        return float == null ? preset : float.round();
      }
    }
    return preset;
  }


  static int? absInt(data, {int? preset}) {
    int value = toInt(data);
    return value > 0 ? value : preset;
  }

  static List<int> toIntList(dynamic data, {List<int>? preset}) {
    List<int> list = preset ?? [];
    if (data is List) {
      for (var v in data) {
        list.add(toInt(v));
      }
    }
    return list;
  }


  static double toDouble(dynamic data, {double preset = 0.0}) {
    if (data == null) {
      return preset;
    } else if (data is double) {
      return data;
    } else if (data is int) {
      return data.toDouble();
    } else if (data is String) {
      double? parsedValue = double.tryParse(data);
      return parsedValue ?? preset;
    } else {
      return preset;
    }
  }


  static double? absDouble(data, {double? preset}) {
    double value = toDouble(data);
    return value > 0.0 ? value : preset;
  }

  static List<double> toDoubleList(dynamic data, {List<double>? preset}) {
    List<double> list = preset ?? [];
    if (data is List) {
      for (var v in data) {
        list.add(toDouble(v));
      }
    }
    return list;
  }

  static Map<String, dynamic> toMap(dynamic data, {Map<String, dynamic>? preset}) {
    return data is Map<String, dynamic> ? data : preset ?? <String, dynamic>{};
  }


  static List<Map<String, dynamic>> toMapList(dynamic data,
      {List<Map<String, dynamic>>? preset}) {
    List<Map<String, dynamic>> list = preset ?? [];
    if (data is List) {
      for (var v in data) {
        if (v is Map<String, dynamic>) {
          list.add(v);
        }
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
    final String _date = DateFormat('yyyy-MM-dd').format(datetime);
    final String _time = Data.toTime(DateFormat('HH:mm:ss').format(datetime), military);

    if (date && time) {
      return '$_date $_time';
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