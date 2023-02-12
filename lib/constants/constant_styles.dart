import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConstantStyles {
  static BoxShadow boxShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    spreadRadius: 2,
    blurRadius: 2,
    offset: const Offset(0, 3), // changes position of shadow
  );


  static Color white() => const Color(0xffFFFFFF);

  static Color gray1() => const Color(0xff292C33);

  static Color gray2() => const Color(0xff52545A);

  static Color gray3() => const Color(0xff7B7C81);

  static Color gray4() => const Color(0xffA3A5A7);

  static Color gray5() => const Color(0xffCCCDCE);

  static Color gray6() => const Color(0xffE1E1E2);

  static Color gray7() => const Color(0xffF2F2F2);

  static Color primary1() {
    return  const Color(0xff5CB750);
  }

  static  Color primary2() {
    return const Color(0xff30962A);
  }

  static  Color primary3() {
    return const Color(0xff74DE66);
  }

  static Color secondary1() {
    return const Color(0xffE94820);
  }

  static Color secondary2() {
    return const Color(0xffFB6B47);
  }

  static Color secondary4() => const Color(0xffFCEAE6);

  static Color warmGray1() {
    return const Color(0xff827B6E);
  }

  static Color warmGray2() {
    return const Color(0xffB9B4AC);
  }

  static  Color warmGray3() {
    return  const Color(0xffF1F0EE);
  }

  static Color textColor() => const Color(0xff000000);

  double getSize(double size) {
    return size;
  }

}
extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';


}
