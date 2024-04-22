

import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';


const kSpacingUnit = 10.0;

// Colors
const kTextColor = Color(0xFF151C2A);
const kTextSecondaryColor = Color(0xFF7E8EAA);
const kPrimaryColor = Color(0xFF5D92EB);
const kGreenColor = Color(0xFF30C96B);
const kRedColor = Color(0xFFEE6B8D);
const kPurpleColor = Color(0xFFC482F9);
const kBackgroundColor = Color(0xFFFBF8FF);
const kLineColor = Color(0xFFEAEEF4);
const kShadowColor1 = Color.fromRGBO(149, 190, 207, 0.50);
const kShadowColor2 = Color(0xFFCFECF8);
const kShadowColor3 = Color.fromRGBO(0, 0, 0, 0.10);
const kShadowColor4 = Color.fromRGBO(207, 236, 248, 0.50);
const kShadowColor5 = Color.fromRGBO(238, 226, 255, 0.70);


final TextStyle kHeadingTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(24),
  color: kTextColor,
  fontWeight: FontWeight.w600,
);

final kSubheaderTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(20),
  color: kTextColor,
  fontWeight: FontWeight.w600,
);

final kTitleTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(16),
  color: kTextColor,
);

final kBodyTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(13),
  color: kTextSecondaryColor,
);

final kCaptionTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(10),
  color: kTextSecondaryColor,
);

final kNumberTitleTextStyle = TextStyle(
  fontFamily: 'TTNorms',
  fontSize: ScreenUtil().setSp(22),
  fontWeight: FontWeight.w500,
  color: kTextColor,
);