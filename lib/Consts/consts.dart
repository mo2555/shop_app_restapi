import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
        fontFamily: 'Loly'),
    iconTheme: IconThemeData(
      color: Colors.black,
      size: 30,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    elevation: 0,
    titleSpacing: 20,
  ),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      elevation: 20,
      unselectedItemColor: Colors.grey),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontFamily: 'Loly',
    ),
    bodyText2: TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontFamily: 'Loly',
    ),
  ),
  buttonColor: Colors.blue,
);
ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.blue,
  appBarTheme: AppBarTheme(
    backgroundColor: HexColor('333739'),
    titleTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
        fontFamily: 'Loly'),
    iconTheme: const IconThemeData(
      color: Colors.white,
      size: 30,
    ),
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ),
    elevation: 0,
    titleSpacing: 20,
  ),
  scaffoldBackgroundColor: HexColor('333739'),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor('333739'),
    selectedItemColor: Colors.white,
    elevation: 20,
    unselectedItemColor: Colors.grey,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
        color: Colors.grey,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        fontFamily: 'Loly'),
    bodyText2: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontFamily: 'Loly',
    ),
  ),
  buttonColor: Colors.grey,
);

navigatorAndReplace(context, screen) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

navigatorTo(context, screen) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

Widget defaultFormField({
  TextEditingController? controller,
  required TextInputType type,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChanged,
  GestureTapCallback? onTap,
  bool isPassword = false,
  required FormFieldValidator<String>? validate,
  required Widget label,
  required Widget prefix,
  Widget? suffix,
  Function? suffixPressed,
  TextStyle? textStyle,
}) {
  return TextFormField(
    style: textStyle,
    controller: controller,
    keyboardType: type,
    obscureText: isPassword,
    onFieldSubmitted: onSubmit,
    onTap: onTap,
    onChanged: onChanged,
    validator: validate,
    decoration: InputDecoration(
      label: label,
      prefixIcon: prefix,
      suffix: suffix,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}

TextButton textButton(fun, text, context) => TextButton(
      onPressed: fun,
      child: Text(
        '$text',
        style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(
              color: Colors.black,
              fontSize: 18,
            ),
      ),
    );

messageToast({required String msg, required Color color}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) {
    print(match.group(0));
  });
}

String? token;

Widget fadeInImage({
  required String networkImagePath,
  required double width,
  required double height,
  required BoxFit fit,
}) =>
    FadeInImage(
      width: width,
      height: height,
      fit: fit,
      placeholder: const AssetImage(
        'assets/images/placeholder.png',
      ),
      image: NetworkImage(networkImagePath),
      imageErrorBuilder: (BuildContext context,
          Object error,
          StackTrace? stackTrace,) {
        print(error.toString());
        return Image.asset(
        'assets/images/placeholder.png',
          width: width,
          height: height,
          fit: fit,
      );
      },
    );
