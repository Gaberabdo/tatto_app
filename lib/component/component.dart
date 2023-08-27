
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:tattoapp/component/model.dart';

import '../features/authentication/widget_components/validator_components.dart';

class FiltersWidget extends StatefulWidget {
  const FiltersWidget({Key? key}) : super(key: key);

  @override
  _FiltersWidgetState createState() => _FiltersWidgetState();
}

class _FiltersWidgetState extends State<FiltersWidget> {
  late FiltersModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    // _model = createModel(context, () => FiltersModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      height: 120,
      decoration: BoxDecoration(
        color:Colors.green,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x33000000),
            offset: Offset(0, -2),
          )
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.asset(
                        'assets/images/sun.png',
                      ).image,
                    ),
                  ),
                ),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.asset(
                        'assets/images/invert_(1).png',
                      ).image,
                    ),
                  ),
                ),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.asset(
                        'assets/images/Saturation_(1).png',
                      ).image,
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.asset(
                        'assets/images/fluent_drop-28-regular.png',
                      ).image,
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.asset(
                        'assets/images/ph_scan-thin.png',
                      ).image,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFF222627),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Tattoos',
                        style:TextStyle(
                          fontFamily: 'Montserrat',
                          color: Color(0xFFB7B8BA),
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: VerticalDivider(
                          thickness: 1,
                          color: Color(0xFFDE2C2C),
                        ),
                      ),
                      Text(
                        'Filters',
                        style:TextStyle(
                          fontFamily: 'Readex Pro',
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void defaultToast({
  required BuildContext context,
  required String message,
  required Color iconColor,
  required IconData icon,
}) {
  MotionToast(
    description: Text(
      message,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16.0,
      ),
    ),
    primaryColor: const Color(0x00012ccf),
    animationDuration: const Duration(
      milliseconds: 500,
    ),
    toastDuration: const Duration(seconds: 5),
    displaySideBar: false,
    icon: icon,
    animationCurve: Curves.fastLinearToSlowEaseIn,
    secondaryColor: iconColor,
    enableAnimation: false,
    constraints: const BoxConstraints(),
    padding: const EdgeInsets.all(20.0),
  ).show(context);
}
class Buttonhelper extends StatelessWidget {
  Buttonhelper({this.onchange, this.title});
  String? title;
  VoidCallback? onchange;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 400,
      decoration: BoxDecoration(
          color: Colors.green.shade300,
          borderRadius: BorderRadius.circular(60)),
      child: MaterialButton(
          onPressed: onchange,
          child: Center(
            child: Text(title!,
                style: GoogleFonts.arya(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20)),
          )),
    );
  }
}

AppBar buildCustomAppBar({
  required String text,
  Function()? function,
  IconData? icon ,
  bool centerTitle = true,
  Color backgroundColor = Colors.black,
  Color foregroundColor = Colors.white,
  List<Widget>? action,
}) {
  return AppBar(
    backgroundColor: backgroundColor,
    foregroundColor: foregroundColor,
    elevation: 0,
    centerTitle: centerTitle,
    title: Text(
      text,
      style: textTheme(fontSize: 22, color: foregroundColor),
    ),
    actions: action,
  );
}


class RoutePage {
  void navigateAndRemove(context, widget) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
          (route) => false,
    );
  }

  void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}