import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoundedButton extends StatelessWidget {
  final String? text;
  final Function()? press;
  final Color? color, textColor;

  const RoundedButton(
      {Key? key, this.text, this.press, this.color, this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.75,
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(83.0),
              side: const BorderSide(color: Colors.white),
            ),
          ),
        ),
        onPressed: press,
        child: Text(
          text!,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final Widget? title;
  final Function()? leadingAction;

  const CustomAppBar({Key? key, this.title, this.leadingAction})
      : preferredSize = const Size.fromHeight(50),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      elevation: 0.0,
      toolbarHeight: 50,
      title: Container(
        padding: EdgeInsets.zero,
        child: title,
      ),
      leading: Transform.translate(
        // offset: const Offset(0, -20),
        offset: const Offset(0, 0),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.black,
          ),
          onPressed: leadingAction,
        ),
      ),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.only(
          //   bottomLeft: Radius.circular(20),
          //   bottomRight: Radius.circular(20),
          // ),
          // gradient: LinearGradient(
          //     colors: [Colors.red, Colors.pink],
          //     begin: Alignment.bottomCenter,
          //     end: Alignment.topCenter),
        ),
      ),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }
}
