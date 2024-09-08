import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ortu/screens/start/components/AnimatedBtn.dart';
import 'package:ortu/screens/start/components/signin_dialog.dart';
import 'package:rive/rive.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  bool isSignInDialogShow = false;
  late RiveAnimationController _btnAnimationColtroller;
  late Future<void> _loadAssetsFuture;

  @override
  void initState() {
    super.initState();
    _btnAnimationColtroller = OneShotAnimation("active", autoplay: false);
    _loadAssetsFuture = _loadAssets();
  }

  Future<void> _loadAssets() async {
    // Pre-cache images and other assets here
    await precacheImage(
      const AssetImage("assets/Backgrounds/Spline.png"),
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _loadAssetsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return Stack(
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
                                "Welcome Family",
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
                            Future.delayed(
                              const Duration(milliseconds: 1000),
                              () {
                                customSigninDialog(
                                  context,
                                  onClose: (_) {
                                    setState(() {
                                      isSignInDialogShow = false;
                                    });
                                  },
                                );
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
          );
        },
      ),
    );
  }
}
