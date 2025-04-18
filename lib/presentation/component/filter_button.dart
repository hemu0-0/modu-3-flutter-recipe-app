import 'package:flutter/material.dart';

import '../../ui/color_styles.dart';
import '../../ui/text_styles.dart';

class FilterButton extends StatefulWidget {
  final List<String> text;
  final ValueChanged<List<String>>? onSelected;

  const FilterButton({super.key, required this.text, this.onSelected});

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  late List<bool> isSelectedList;

  @override
  void initState() {
    super.initState();
    isSelectedList = List.filled(widget.text.length, false);
  }

  void toggleSelect(int index) {
    setState(() {
      isSelectedList[index] = !isSelectedList[index];
    });

    if (widget.onSelected != null) {
      final selectedTexts = <String>[];
      for (int i = 0; i < widget.text.length; i++) {
        if (isSelectedList[i]) selectedTexts.add(widget.text[i]);
      }
      widget.onSelected!(selectedTexts);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 2,
      runSpacing: 6,
      children:
          List.generate(widget.text.length, (index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () => toggleSelect(index),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorStyles.primary100, width: 1),
                    color:
                        isSelectedList[index]
                            ? ColorStyles.primary100
                            : ColorStyles.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    widget.text[index],
                    style: TextStyles.smallerRegular.copyWith(
                      color:
                          isSelectedList[index]
                              ? ColorStyles.white
                              : ColorStyles.primary80,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }
}
