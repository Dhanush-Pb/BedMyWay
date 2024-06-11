import 'package:bedmyway/repositories/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Mytimeline extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPrev;
  final Widget? child;

  const Mytimeline({
    Key? key,
    required this.isFirst,
    required this.isLast,
    required this.isPrev,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.23,
      width: MediaQuery.of(context).size.width,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: LineStyle(
          color:
              isLast ? Appcolor.red2 : const Color.fromARGB(255, 10, 110, 12),
        ),
        indicatorStyle: IndicatorStyle(
          width: 30,
          color: isPrev ? const Color.fromARGB(255, 1, 44, 80) : Appcolor.red,
          iconStyle: IconStyle(
            iconData: Icons.done,
            color: Colors.white,
          ),
        ),
        endChild: Container(
          margin: const EdgeInsets.only(left: 25, right: 25, top: 15),
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: isPrev
                ? Appcolor.green.withOpacity(0.4)
                : Appcolor.red.withOpacity(0.4),
            borderRadius: BorderRadius.circular(15),
          ),
          child: child,
        ),
      ),
    );
  }
}
