import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropDownWidget extends StatelessWidget {
  final Function onSelect;
  final String? selectedValue;
  final List<String> items;
  final String title;
  const DropDownWidget({
    super.key,
    required this.onSelect,
    this.selectedValue,
    required this.items,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        borderRadius: BorderRadius.circular(9),
        borderOnForeground: true,
        child: InkWell(
          borderRadius: BorderRadius.circular(9),
          onTap: () {
            Get.bottomSheet(BottomSheet(
                onClosing: () {},
                builder: (context) => Container(
                      height: Get.height * 0.3,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(9)),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title,
                                style: Get.textTheme.headlineMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: Radio(
                                      value: true,
                                      groupValue: selectedValue == items[index],
                                      onChanged: (e) => onSelect(items[index]),
                                    ),
                                    onTap: () {
                                      onSelect();
                                      Get.back();
                                    },
                                    title: Text(items[index]),
                                  );
                                }),
                          ],
                        ),
                      ),
                    )));
          },
          child: Ink(
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(selectedValue ?? '', style: Get.textTheme.labelLarge),
                  const Spacer(),
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.arrow_drop_down,
                        size: 28,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
