import 'package:flutter/material.dart';
import 'package:hb_common/app/hb_color.dart';

class AppColor {
  static init() {
    HbColor.setup(
      // 主体色
      mainDarkColor: const Color(0xFF0C3294),
      mainLightColor: const Color(0xFF0C3294),
      // 背景色
      bgWhite: const Color(0xffFFFFFF),
      bgBlack: const Color(0xff1F1F1F),
      bgGrey: const Color(0xffF3F3F3), // 未激活背景色
      bgGreyLight: const Color(0xffF7F7F7),
      bgGreyDark: const Color(0xffECECEC),
      bgSuccessLight: const Color.fromRGBO(98, 201, 27, 0.15), // 涨，成功
      bgErrorLight: const Color.fromRGBO(254, 81, 82, 0.15), // 涨，成功
      bgWarnLight: const Color.fromRGBO(255, 162, 13, 0.15), // 涨，成功
      // 文字色
      textBlack: Colors.black,
      textWhite: Colors.white,
      textGrey: const Color(0xFF8F8F8F),
      textGreyLight: const Color(0xFF959595),
      textGreyDark: const Color(0xFF444745),
      textError: const Color(0xffFE5152),
      textSuccess: const Color(0xff62C91B), // 涨，成功
      textWarn: const Color(0xffFFA20D), // 警告，提示
      // 边框颜色
      lineGrey: const Color(0xffF1F1F1),
      // 遮罩层颜色
      shadowBlack: const Color.fromRGBO(0, 0, 0, 0.15),
    );
  }
}
