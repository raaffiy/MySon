import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ortu/screens/start/components/AnimatedBtn.dart';
import 'package:ortu/screens/start/components/signin_form.dart';
import 'package:rive/rive.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  bool isSignInDialogShow = false;
  late RiveAnimationController _btnAnimationColtroller;
  @override
  void initState() {
    _btnAnimationColtroller = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width * 1.7,
            bottom: 200,
            left: 100,
            child: Image.asset("assets/Backgrounds/Spline.png"),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
            ),
          ),
          const RiveAnimation.asset("assets/RiveAssets/shapes.riv"),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: const SizedBox(),
            ),
          ),
          AnimatedPositioned(
            top: isSignInDialogShow ? -50 : 0,
            duration: const Duration(milliseconds: 260),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    const SizedBox(
                      child: Column(
                        children: [
                          Text(
                            "Welcome Teacher",
                            style: TextStyle(
                              fontSize: 57,
                              fontFamily: "Poppins",
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Anak-anak bangsa, kalian adalah harapan masa depan. Raihlah ilmu dan bentuk karakter kuat. Setiap langkah kalian menentukan kejayaan Indonesia. Kami, para guru, selalu mendukung kalian",
                          ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 3),
                    AnimatedBtn(
                      btnAnimationColtroller: _btnAnimationColtroller,
                      press: () {
                        _btnAnimationColtroller.isActive = true;
                        Future.delayed(
                          const Duration(milliseconds: 800),
                          () {
                            setState(() {
                              isSignInDialogShow = true;
                            });
                          },
                        );
                        customSigninDialog(
                          context,
                          onClose: (_) {
                            setState(() {
                              isSignInDialogShow = false;
                            });
                          },
                        );
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                        "Kalian masa depan bangsa, belajar dan berkarakterlah kuat. Kami, para guru, mendukung perjalanan kalian",
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Object?> customSigninDialog(BuildContext contex,
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
}
