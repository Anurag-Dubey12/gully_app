import 'package:flutter/material.dart';
import 'package:gully_app/ui/theme/theme.dart';

class PrimaryButton extends StatefulWidget {
  final Function onTap;
  final String? title;
  final bool? isLoading;
  final bool? isDisabled;
  final double? fontSize;
  const PrimaryButton(
      {super.key,
      required this.onTap,
      this.title,
      this.isLoading,
      this.isDisabled,
      this.fontSize});

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    if (widget.isLoading ?? false) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppTheme.primaryColor,
        ),
      );
    } else {
      return InkWell(
        onTap: (widget.isDisabled ?? false) ? () {} : () => widget.onTap(),
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: (widget.isDisabled ?? false)
                ? Colors.grey.shade400
                : AppTheme.primaryColor,
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(100, 93, 93, 0.4),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.title ?? 'Continue',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: widget.fontSize),
            ),
          ),
        ),
      );
    }
  }
}
