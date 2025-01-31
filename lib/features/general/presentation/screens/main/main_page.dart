import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:periferiamovies/features/general/presentation/blog/main/main_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.child});

  final Widget child;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    return WillPopScope(
      onWillPop: () async {
        return context.read<MainBlog>().onBackPressed(context, _scaffoldKey);
      },
      child: widget.child,
    );
  }


}
