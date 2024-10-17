import 'package:flutter/material.dart';
import 'package:ur_habits/resources/colors.dart';

class HabitListTile extends StatefulWidget {
  const HabitListTile({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    required this.backgroundColor,
    required this.downColor,
    required this.height,
    this.onTap,
  });

  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final Color? backgroundColor;
  final Color downColor;
  final double height;
  final VoidCallback? onTap;

  @override
  State<HabitListTile> createState() => _HabitListTileState();
}

class _HabitListTileState extends State<HabitListTile> {
  Color? backgroundColor;

  @override
  void initState() {
    super.initState();
    backgroundColor = widget.backgroundColor;
  }

  /// タップキャンセル時に背景色をリセット
  void _handleTapCancel() {
    setState(() {
      backgroundColor = widget.backgroundColor;
    });
  }

  /// タップアップ時に背景色をリセット
  void _handleTapUp(TapUpDetails details) {
    setState(() {
      backgroundColor = widget.backgroundColor;
    });
  }

  /// タップダウン時の背景色を設定
  void _handleTapDown(TapDownDetails details) {
    setState(() {
      backgroundColor = widget.downColor;
    });
  }

  /// trailingウィジェットの表示
  Widget _buildTrailing() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: widget.trailing!,
    );
  }

  /// サブタイトルのウィジェットを構築
  Widget _buildSubtitle() {
    return Row(
      children: [
        widget.subtitle!,
      ],
    );
  }

  /// タイトルのウィジェットを構築
  Widget _buildTitle() {
    return Row(
      children: [
        widget.title!,
      ],
    );
  }

  /// タイトルとサブタイトルの表示部分を構築
  Widget _buildTitleSubtitleSection() {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.title != null) _buildTitle(),
                if (widget.subtitle != null) _buildSubtitle(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// leadingウィジェットの表示
  Widget _buildLeading() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: widget.leading!,
    );
  }

  /// ボックスの装飾を構築
  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: backgroundColor,
      border: const Border(
        bottom: BorderSide(
          width: 1.0,
          color: kLightGray3,
        ),
      ),
    );
  }

  /// タイル全体のコンテナを構築
  Widget _buildTileContainer() {
    return Container(
      height: widget.height,
      decoration: _buildBoxDecoration(),
      child: Row(
        children: [
          if (widget.leading != null) _buildLeading(),
          _buildTitleSubtitleSection(),
          if (widget.trailing != null) _buildTrailing(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTileContainer();
  }
}
