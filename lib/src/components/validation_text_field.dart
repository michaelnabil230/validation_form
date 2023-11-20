import 'dart:async';

import 'package:flutter/material.dart';
import 'package:validation_form/validation_form.dart';

class ValidationTextField extends StatefulWidget {
  final FieldCubit cubit;

  final Widget Function(
    BuildContext context,
    TextEditingController controller,
    FieldState state,
  ) field;

  const ValidationTextField({
    super.key,
    required this.cubit,
    required this.field,
  });

  @override
  State<ValidationTextField> createState() => _ValidationTextFieldState();
}

class _ValidationTextFieldState extends State<ValidationTextField> {
  late TextEditingController _controller;

  late StreamSubscription _subscription;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.cubit.state.initialValue)
      ..addListener(() => widget.cubit.setValue(_controller.text));
    _subscription = widget.cubit.stream.listen(_cubitListener);
    super.initState();
  }

  void _cubitListener(FieldState state) {
    if (state.status.isInitial) {
      _controller.text = state.value;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FieldCubit, FieldState>(
      bloc: widget.cubit,
      builder: (context, state) => widget.field(context, _controller, state),
    );
  }
}