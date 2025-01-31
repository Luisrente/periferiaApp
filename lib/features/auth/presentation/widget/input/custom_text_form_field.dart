import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:periferiamovies/core/resources/styles.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final bool isSecureField;
  final bool autoCorrect;
  final String? hint;
  final EdgeInsets? contentPadding;
  final String? Function(String?)? validation;
  final double hintTextSize;
  final bool enable;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final Icon? prefixIcon;
  final FocusNode? curFocusNode;
  final FocusNode? nextFocusNode;
  final Function? onTap;
  final TextAlign? textAlign;
  final List<TextInputFormatter>? inputFormatter;
  final int? minLine;
  final int? maxLine;
  final bool isHintVisible;
  final String? prefixText;
  final String? hintText;
  final Iterable<String>? autofillHints;
  final String? semantic;

  const CustomTextFormField({
    Key? key,
    this.controller,
    this.isSecureField = false,
    this.autoCorrect = false,
    this.enable = true,
    this.hint,
    this.validation,
    this.onChanged,
    this.prefixIcon,
    this.contentPadding,
    this.textInputAction,
    this.hintTextSize = 14,
    this.onFieldSubmitted,
    this.textInputType,
    this.curFocusNode,
    this.nextFocusNode,
    this.onTap,
    this.textAlign,
    this.inputFormatter,
    this.minLine,
    this.maxLine,
    this.isHintVisible = true,
    this.prefixText,
    this.hintText,
    this.autofillHints,
    this.semantic,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // margin: EdgeInsets.symmetric(vertical: Dimens.space8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.isHintVisible,
            child: Text(
              widget.hint ?? "",
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).extension<LzyctColors>()!.background,
                height: 0.1,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Semantics(
              label: widget.semantic,
              child: TextFormField(
                key: widget.key,
                onChanged: widget.onChanged,
                controller: widget.controller,
                obscureText: widget.isSecureField && !_passwordVisible,
                enableSuggestions: !widget.isSecureField,
                autocorrect: widget.autoCorrect,
                validator: widget.validation,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                enabled: widget.enable,
                textInputAction: widget.textInputAction,
                onFieldSubmitted: (value) {
                  if (widget.onFieldSubmitted != null) {
                    widget.onFieldSubmitted!(value);
                  }
                  fieldFocusChange(
                    context,
                    widget.curFocusNode ?? FocusNode(),
                    widget.nextFocusNode,
                  );
                },
                keyboardType: widget.textInputType,
                decoration: InputDecoration(
                  filled: true,
                  hintText: widget.hint,
                  hintStyle: TextStyle(
                    fontSize: widget.hintTextSize,
                  ),
                  prefixIcon: widget.prefixIcon,
                  contentPadding: widget.contentPadding,
                  suffixIcon: widget.isSecureField
                      ? IconButton(
                          icon: Icon(
                            _passwordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.black87,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        )
                      : null,
                ),
                autofillHints: widget.autofillHints,
                focusNode: widget.curFocusNode,
                textAlign: widget.textAlign ?? TextAlign.start,
                minLines: widget.minLine ?? 1,
                maxLines: widget.maxLine ?? 10,
                inputFormatters: widget.inputFormatter,
                textAlignVertical: TextAlignVertical.center,
                style: Theme.of(context).textTheme.bodyMedium,
                cursorColor: Theme.of(context).extension<LzyctColors>()!.pink,
                onTap: widget.onTap as void Function()?,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void fieldFocusChange(
    BuildContext context,
    FocusNode currentFocus,
    FocusNode? nextFocus,
  ) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
