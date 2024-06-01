import 'package:bedmyway/controller/bloc/auth_bloc.dart';
import 'package:bedmyway/controller/fetchbloc/bloc/hoteldata_bloc.dart';
import 'package:bedmyway/repositories/components/bottm_page.dart';
import 'package:bedmyway/repositories/custom/page_transition.dart';

import 'package:bedmyway/view/on_&_splash/on_bordin1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    BlocProvider.of<HoteldataBloc>(context).add(FetchdataEvent());
    eventinzilizing();
    const Onboarding1();
    super.initState();
    // Call goto function on init
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.of(context)
                .pushReplacement(FadePageRoute(page: const NavigationMenu()));
          } else if (state is UnAuthenticated) {
            Navigator.of(context)
                .pushReplacement(FadePageRoute(page: const Onboarding1()));
          }
        },
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/Screenshot 2024-05-06 212614.png',
                      scale: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            Lottie.asset(
              'assets/lootie/Animation - 1715057009485.json',
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  void eventinzilizing() {
    context.read<AuthBloc>().add(checkloginevern());
  }
}
