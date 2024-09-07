import 'package:flutter/material.dart';
import 'package:op/screens/start/components/signinForm.dart';

Future<Object?> customSigninDialog(BuildContext context,
    {required ValueChanged onClose}) {
  return showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: "Sign In",
    context: context,
    transitionDuration: const Duration(milliseconds: 400),
    transitionBuilder: (_, animation, __, child) {
      Tween<Offset> tween;
      tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        ),
        child: child,
      );
    },
    pageBuilder: (context, _, __) => Center(
      child: Container(
        height: 475,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.94),
          borderRadius: const BorderRadius.all(
            Radius.circular(40),
          ),
        ),
        child: const Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 34,
                      fontFamily: "Poppins",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      "Hello Word Hello Word Hello Word Hello Word Hello Word Hello Word Hello Word",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SignInForm(),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  ).then(onClose);
}
