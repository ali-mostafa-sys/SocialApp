import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultTextForm({
  required TextEditingController controller,
  required TextInputType textInputType,
  required BuildContext context,
  required String labelText,
  required var validate,
  String hintText='',
  required TextStyle textStyle,
  Color borderColor = Colors.white,
  double radius = 25,
  var onTap,
  var suffixIcon,
  var preIcon,
  bool obSecure = false,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: textInputType,
      validator: validate,
      onTap: onTap,

      obscureText: obSecure,
      cursorColor: HexColor('ffcc00'),
      style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: BorderRadius.circular(radius)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: BorderRadius.circular(radius)),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: BorderRadius.circular(radius)),
        labelText: labelText,
        labelStyle: textStyle,
        suffixIcon: suffixIcon,
        prefixIcon: preIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );

void navigatorTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigatorReplace(context, widget) => Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => widget));

Widget defaultButton({
  required context,
  required var onPressed,
  double borderRadiusOfButton = 25,
  double internalPadding = 10,
  Color fitColor = Colors.deepOrange,
  required String text,
  Color textColor = Colors.white,
  double fontSize = 10,
}) =>
    Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadiusOfButton),
          border: Border.all(width: 0, color: Colors.white)),
      child: MaterialButton(
        padding: EdgeInsets.all(internalPadding),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadiusOfButton),
            borderSide: BorderSide(width: 0)),
        minWidth: MediaQuery.of(context).size.width,
        color: fitColor,
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: fontSize),
        ),
      ),
    );

Future defaultToast(
        {required String msg,
        ToastGravity toastGravity = ToastGravity.BOTTOM,
        required Color backgroundColor,
        required Color textColor,
        double textSize = 16}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: toastGravity,
        timeInSecForIosWeb: 5,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: textSize);

Widget defaultDivider(
        {required double width,
        required double height,
        required Color color,
        required double padding}) =>
    Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Container(
        width: width,
        height: height,
        color: color,
      ),
    );

PreferredSizeWidget? defaultAppBar(
        {required BuildContext context,
        Widget? title,
          Widget? leading,
        List<Widget>? actions}) =>
    AppBar(
      title: title,
      titleSpacing: 0,
      actions: actions,
      leading: leading
    );
