//This class is not stable yet and watching for issues. Copyright by Ye Htet Hein.

//ISSUES TO FIX
//divide
//decimal(.)
import 'package:calculator/config.dart';

class Math extends config {
  Math();

  String DynamicExpr(String expression, {String currentAnswer}) {
    String s = expression
        .replaceAll(addSign, '+')
        .replaceAll(minusSign, '-')
        .replaceAll(multiplySign, 'x')
        .replaceAll(divideSign, '/');

    if (s.length <= 0)
      return "0";
    else if (!s.contains('+') &&
        !s.contains('-') &&
        !s.contains('x') &&
        !s.contains('/')) {
      return s;
    } else if (s.endsWith('+') ||
        s.endsWith('-') ||
        s.endsWith('x') ||
        s.endsWith('/')) {
      return currentAnswer.toString();
    } else if ((!s.endsWith('+') ||
        !s.endsWith('-') ||
        !s.endsWith('x') ||
        !s.endsWith('/'))) {
      s = s
          .replaceAll('+', ',+,')
          .replaceAll('-', ',-,')
          .replaceAll('x', ',x,')
          .replaceAll('/', ',/,');

      List<String> str = s.split(',');

      //Order => *,/,+,-
      List<String> ans = _SecondStepOperation('x', str);
      ans = _SecondStepOperation('/', ans);
      ans = _SecondStepOperation('+', ans);
      ans = _SecondStepOperation('-', ans);

      String answer = _finalize(ans);
      return answer;
    }
  }

  List<String> _Splitter(String str) {
    List<String> resultStr;
    String s = str
        .replaceAll(addSign, '+')
        .replaceAll(minusSign, '-')
        .replaceAll(multiplySign, 'x')
        .replaceAll(divideSign, '/');

    if ((!s.endsWith('+') ||
        !s.endsWith('-') ||
        !s.endsWith('x') ||
        !s.endsWith('/'))) {
      s = s
          .replaceAll('+', ',+,')
          .replaceAll('-', ',-,')
          .replaceAll('x', ',x,')
          .replaceAll('/', ',/,');

      resultStr = s.split(',');
    }
    
    return resultStr;
  }

  String getLast(String str) {
    return _Splitter(str).last;
  }

  String perCent(String str) {
    List<String> array = _Splitter(str);
    array.last = (double.parse(array.last)/100).toString();

    return decodeResult(array.join());
  }

  String decodeResult(String str){
    str = str.replaceAll('+',addSign)
        .replaceAll('-',minusSign)
        .replaceAll('x',multiplySign)
        .replaceAll( '/',divideSign);
        return str;
  }

  List<String> _SecondStepOperation(String sign, List<String> str) {
    int i = 0;
    double ans = 0;
    double _plusAns = 0;
    double _minusAns = 0;
    double _plusCheckup = 0;

    if (str.first != '-' && str.first != '+') {
      _plusAns = double.parse(str.first);
      _plusCheckup = double.parse(str.first);
      str.insert(0, '+');
      i = i + 1;
    }

    if (str.contains(sign)) {
      while (i < str.length) {
        if (str[i] == sign) {
          if (str[i] == 'x') {
            ans = (double.parse(str[i - 1]) * double.parse(str[i + 1]));
            str.removeRange(i - 1, i + 2);
            str.insert(i - 1, ans.toString());
            i = i - 2;
          } else if (str[i] == '/') {
            ans = (double.parse(str[i - 1]) / double.parse(str[i + 1]));
            str.removeRange(i - 1, i + 2);

            str.insert(i - 1, ans.toString());
            i = i - 2;
          } else if (str[i] == '+') {
            _plusAns = _plusAns + double.parse(str[i + 1]);
            ans = _plusAns;
            str.remove(str[i]);
            i--;

            str.remove(str[i + 1]);
          } else if (str[i] == '-') {
            //Remember: Expr '-' and '-' must be plus
            _minusAns = _minusAns + double.parse(str[i + 1]);
            ans = _minusAns;
            str.remove(str[i]);
            i--;

            str.remove(str[i + 1]);
            // i--;

          } else {
            ans = 0;
          }
        }
        i++;
      }

      if (_plusAns != 0 && _plusAns != _plusCheckup) {
        str.insert(str.length, '+');
        str.insert(str.length, _plusAns.toString());
      }

      if (_minusAns != 0) {
        str.insert(str.length, '-');
        str.insert(str.length, _minusAns.toString());
      }

      return str;
    }
    return str;
  }

  double directAns(List<String> str) {
    return double.parse(str.join());
  }

  String _finalize(List<String> str, {noPlusSign: true}) {
    //Acceptable input example: [+, 8338, -, 22.833333333333332]

    double ans = 0;
    String sign;
    Map<String, dynamic> result;

    if (str.length == 4 &&
        (str[0] == '+' || str[0] == '-') &&
        (str[2] == '+' || str[2] == '-')) {
      if (str[0] == "+" && str[2] == "+") {
        ans = double.parse(str[1]) + double.parse(str[3]);
        sign = "+";
      } else if (str[0] == "+" && str[2] == "-") {
        ans = double.parse(str[1]) - double.parse(str[3]);

        if (double.parse(str[3]) > double.parse(str[1])) {
          sign = "-";
        } else {
          sign = "+";
        }
      } else if (str[0] == "-" && str[2] == "+") {
        ans = double.parse(str[1]) - double.parse(str[3]);

        if (double.parse(str[3]) > double.parse(str[1])) {
          sign = "+";
        } else {
          sign = "-";
        }
      } else if (str[0] == "-" && str[2] == "-") {
        ans = double.parse(str[1]) + double.parse(str[3]);
        sign = "-";
      }

      result = {"sign": sign, "value": ans.toString()};

      return result['value'];
    } else if (str.length == 2) {
      result = {"sign": str[0], "value": str[1]};
      if (noPlusSign == true) {
        if (result['sign'] == '+') {
          return result['value'];
        } else {
          return result['sign'] + result['value'].toString();
        }
      } else {
        return result['sign'] + result['value'].toString();
      }
    }
    return "0";
  }
}
