import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/resources/colors.dart';

class AuthListTile extends StatefulWidget {
  const AuthListTile({
    super.key,
    required this.title,
    this.titileWidth,
    required this.mainItem,
    required this.itemHeight,
    required this.itemWidth,
    this.onTap,
    this.isFirst,
    this.isFinal,
    this.useArrow,
    this.mainAxisAlignment,
  });

  final Widget title;
  final double? titileWidth;
  final List<Widget>? mainItem;
  final double itemHeight;
  final double itemWidth;
  final VoidCallback? onTap;
  final bool? isFirst;
  final bool? isFinal;
  final bool? useArrow;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  State<AuthListTile> createState() => _AuthListTileState();
}

class _AuthListTileState extends State<AuthListTile> {
  Color? backgroundColor;

  Widget buildTitleBox() {
    return SizedBox(
      width: widget.titileWidth ?? 110,
      child: Padding(
          padding: const EdgeInsets.only(left: 8.0), child: widget.title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (t) {
        setState(() {
          if (widget.onTap != null) {
            backgroundColor = kLightGray4;
          }
        });
      },
      onTapUp: (t) {
        setState(() {
          backgroundColor = null;
        });
      },
      onTapCancel: () {
        setState(() {
          backgroundColor = null;
        });
      },
      onTap: widget.onTap,
      child: Container(
          height: widget.itemHeight,
          width: widget.itemWidth,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: widget.isFinal != null && widget.isFinal!
                ? null
                : const Border(
                    bottom: BorderSide(
                      width: 1.0,
                      color: kLightGray2,
                    ),
                  ),
            borderRadius: widget.isFirst != null && widget.isFirst!
                ? const BorderRadius.vertical(
                    top: Radius.circular(10),
                  )
                : widget.isFinal != null && widget.isFinal!
                    ? const BorderRadius.vertical(
                        bottom: Radius.circular(10),
                      )
                    : null,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildTitleBox(),
                if (widget.mainItem != null)
                  SizedBox(
                      width: widget.useArrow != null && widget.useArrow!
                          ? 20
                          : 10),
                Expanded(
                  child: Row(
                    mainAxisAlignment:
                        widget.mainAxisAlignment ?? MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.mainItem != null) ...widget.mainItem!,
                    ],
                  ),
                ),
                if (widget.useArrow != null && widget.useArrow!)
                  const SizedBox(
                    width: 20,
                    child: Icon(
                      HugeIcons.strokeRoundedArrowRight01,
                      color: kTextThirdBaseColor,
                    ),
                  ),
              ],
            ),
          )),
    );
  }
}
