import 'package:flutter/material.dart';

class SettingTileWidget extends StatelessWidget {
  final Widget? trailingWidget;
  final String text;
  final IconData iconPath;
  const SettingTileWidget({
    super.key,
    required this.text,
    required this.iconPath,
    this.trailingWidget,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 2.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    iconPath,size: 29,
                    color: Theme.of(context).iconTheme.color,
                  )),
              const SizedBox(
                width: 20,
              ),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),
              ),
            ],
          ),
          if (trailingWidget != null) trailingWidget!
        ],
      ),
    );
  }
}
