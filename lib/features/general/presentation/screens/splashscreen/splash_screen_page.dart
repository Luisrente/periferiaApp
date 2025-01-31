import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:periferiamovies/core/app_route.dart';
import 'package:go_router/go_router.dart';
import 'package:periferiamovies/core/resources/styles.dart';
import 'package:periferiamovies/core/widgets/parent.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      context.goNamed(Routes.root.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      child: Stack(
      children: [
      //    Center(
      //         child: SvgPicture.asset(
      //         'assets/logo-sophos-B.svg',
      //         width: 150,
      //         height: 48,
      //         colorFilter:ColorFilter.mode(Theme.of(context).extension<LzyctColors>()!.icon!, BlendMode.srcIn)
      //       ),
      // )
      ],
     )
  );
  }
}
