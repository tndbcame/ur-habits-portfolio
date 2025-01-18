import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/data.dart';
import 'package:ur_habits/views/components/button/color_changing_box_button.dart';

class CustomTenkey extends StatelessWidget {
  const CustomTenkey(
      {super.key, required this.onTenkeyPressed, this.useDecimal = true});

  final Function(TenkeyNumber) onTenkeyPressed;
  final bool useDecimal;

  Widget _buildButton(
    BuildContext context,
    TenkeyNumber value, {
    String? label,
    IconData? icon,
    bool isClear = false,
    bool hasLeftBorder = false,
    bool hasRightBorder = false,
    bool hasBottomBorder = false,
    bool isBorderRadiusTopLeft = false,
    bool isBorderRadiusTopRight = false,
    bool isBorderRadiusBottomLeft = false,
    bool isBorderRadiusBottomRight = false,
  }) {
    return ColorChangingBoxButton(
      height: isClear ? 180 : 60,
      normalColor: kTextBaseColor,
      normalTextColor: Theme.of(context).primaryColor,
      pressedColor: kLightGray5,
      pressedTextColor: Theme.of(context).primaryColor,
      onTap: () {
        if (value == TenkeyNumber.decimal && !useDecimal) {
          return;
        }
        onTenkeyPressed(value);
      },
      borderColor: Theme.of(context).primaryColor,
      hasLeftBorder: hasLeftBorder,
      hasRightBorder: hasRightBorder,
      hasBottomBorder: hasBottomBorder,
      borderRadius: BorderRadius.only(
        topLeft:
            isBorderRadiusTopLeft ? const Radius.circular(10) : Radius.zero,
        topRight:
            isBorderRadiusTopRight ? const Radius.circular(10) : Radius.zero,
        bottomLeft:
            isBorderRadiusBottomLeft ? const Radius.circular(10) : Radius.zero,
        bottomRight:
            isBorderRadiusBottomRight ? const Radius.circular(10) : Radius.zero,
      ),
      labelText: label,
      leftIcon: icon,
      leftIconSize: 32,
      textSize: 32,
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    Expanded(
                      child: _buildButton(
                          context,
                          label: '1',
                          TenkeyNumber.one,
                          isBorderRadiusTopLeft: true),
                    ),
                    Expanded(
                      child:
                          _buildButton(context, label: '2', TenkeyNumber.two),
                    ),
                    Expanded(
                      child:
                          _buildButton(context, label: '3', TenkeyNumber.three),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: _buildButton(
                    context,
                    icon: HugeIcons.strokeRoundedEraser01,
                    TenkeyNumber.delete,
                    hasLeftBorder: true,
                    isBorderRadiusTopRight: true,
                    hasBottomBorder: true),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: _buildButton(
                              context, label: '4', TenkeyNumber.four),
                        ),
                        Expanded(
                          child: _buildButton(
                              context, label: '5', TenkeyNumber.five),
                        ),
                        Expanded(
                          child: _buildButton(
                              context, label: '6', TenkeyNumber.six),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: _buildButton(
                              context, label: '7', TenkeyNumber.seven),
                        ),
                        Expanded(
                          child: _buildButton(
                              context, label: '8', TenkeyNumber.eight),
                        ),
                        Expanded(
                          child: _buildButton(
                              context, label: '9', TenkeyNumber.nine),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: _buildButton(
                              context,
                              label: '00',
                              TenkeyNumber.zeroDouble,
                              isBorderRadiusBottomLeft: true),
                        ),
                        Expanded(
                          child: _buildButton(
                              context, label: '0', TenkeyNumber.zero),
                        ),
                        Expanded(
                          child: useDecimal
                              ? _buildButton(
                                  context, label: '.', TenkeyNumber.decimal)
                              : Container(
                                  height: 60,
                                  color: kTextBaseColor,
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: _buildButton(
                    context,
                    label: 'C',
                    TenkeyNumber.clear,
                    isClear: true,
                    hasLeftBorder: true,
                    isBorderRadiusBottomRight: true),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
