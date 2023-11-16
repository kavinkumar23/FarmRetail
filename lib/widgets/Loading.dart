import 'package:flutter/material.dart';
import 'package:login_system/configurations/SmallText.dart';

class Loading extends StatefulWidget {
  final String message;
  const Loading({super.key, required this.message});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Colors.white,
              ),
              SizedBox(
                height: 20,
              ),
              SmallText(
                text: widget.message,
                color: Colors.white,
              )
            ],
          ),
        ));
  }
}
