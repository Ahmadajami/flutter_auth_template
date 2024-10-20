import 'package:flutter/material.dart';

class SettingTile extends StatelessWidget {
  const SettingTile({
    super.key,
    required this.prefixIcon,
    required this.title,
    required this.desc,
    required this.suffixOnPressed,
    required this.suffixIcon,
  });

  final IconData prefixIcon;
  final String title;
  final String desc;
  final void Function()? suffixOnPressed;
  final IconData suffixIcon;

  @override
  Widget build(BuildContext context) {

    final double width = MediaQuery.sizeOf(context).width;
    final double height = MediaQuery.sizeOf(context).height;
    return Container(
        padding: const EdgeInsets.all(8.0),
        height: height * 0.10,
        width: width,
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(prefixIcon),
            ),
            Expanded(
                flex: 2,
                child: Text.rich(
                  TextSpan(
                    text: title,
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(children: [
                        TextSpan(
                            text: " \n $desc",
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0,
                                fontWeight: FontWeight.normal))
                      ])
                    ],
                  ),
                )),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color:  Theme.of(context).primaryColor
              ),
              child: IconButton(
                  onPressed: suffixOnPressed,
                  icon: Icon(suffixIcon,color:Theme.of(context).iconTheme.color ,)),
            )
          ],
        ));
  }
}