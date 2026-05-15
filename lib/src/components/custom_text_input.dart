// Thomas e Sophia DEVB
/// Custom Text Input Field
/// Campo de input com bordas suaves e Ã­cones personalizados

import 'package:flutter/material.dart';
import '../design_system/colors.dart';
import '../design_system/spacing.dart';

class CustomTextInput extends StatefulWidget {
  final String label;
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int maxLines;
  final bool isEnabled;

  const CustomTextInput({
    required this.label,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
    this.isEnabled = true,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() => _isFocused = _focusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: isDark ? AppColors.textDark : AppColors.textLight,
              ),
        ),
        const SizedBox(height: AppSpacing.sm),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: _isFocused && widget.isEnabled
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText && !_showPassword,
            enabled: widget.isEnabled,
            maxLines: widget.obscureText ? 1 : widget.maxLines,
            validator: widget.validator,
            onChanged: widget.onChanged,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
              filled: true,
              fillColor: isDark
                  ? (widget.isEnabled
                      ? const Color(0xFF2A2A2A)
                      : const Color(0xFF1A1A1A))
                  : (widget.isEnabled ? const Color(0xFFFAFBFC) : const Color(0xFFF5F5F5)),
              hintText: widget.hintText,
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDark
                        ? AppColors.textDarkSecondary
                        : AppColors.textLightSecondary,
                  ),
              prefixIcon: widget.prefixIcon != null
                  ? Icon(
                      widget.prefixIcon,
                      color: _isFocused
                          ? AppColors.primary
                          : (isDark
                              ? AppColors.textDarkSecondary
                              : AppColors.textLightSecondary),
                    )
                  : null,
              suffixIcon: widget.suffixIcon != null || widget.obscureText
                  ? InkWell(
                      onTap: widget.obscureText
                          ? () => setState(() => _showPassword = !_showPassword)
                          : null,
                      child: Icon(
                        widget.obscureText
                            ? (_showPassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined)
                            : widget.suffixIcon,
                        color: _isFocused
                            ? AppColors.primary
                            : (isDark
                                ? AppColors.textDarkSecondary
                                : AppColors.textLightSecondary),
                      ),
                    )
                  : null,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.lg,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: AppColors.error,
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: AppColors.error,
                  width: 2,
                ),
              ),
              errorStyle: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: AppColors.error),
            ),
          ),
        ),
      ],
    );
  }
}

