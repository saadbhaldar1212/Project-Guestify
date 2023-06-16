library step_progress_indicator;

import 'dart:math';

import 'package:flutter/material.dart';

class CustomStepProgressIndicator extends StatelessWidget {
  final Widget Function(int, Color, double)? customStep;
  final Axis direction;
  final TextDirection progressDirection;

  final void Function() Function(int)? onTap;

  final int currentStep;
  final int totalSteps;
  final double padding;
  final double size;
  final double? selectedSize;
  final double? unselectedSize;
  final double Function(int, bool)? customSize;
  final Color Function(int)? customColor;
  final Color selectedColor;
  final Color unselectedColor;
  final double fallbackLength;
  final Radius? roundedEdges;
  final Gradient? gradientColor;
  final Gradient? selectedGradientColor;
  final Gradient? unselectedGradientColor;

  /// Apply [BlendMode] to [ShaderMask] when [gradientColor], [selectedGradientColor], or [unselectedGradientColor] defined
  final BlendMode? blendMode;

  /// Assign alignment [MainAxisAlignment] for indicator's container
  ///
  /// **NOTE**: if not provided it defaults to [MainAxisAlignment.center]
  final MainAxisAlignment mainAxisAlignment;

  /// Assign alignment [CrossAxisAlignment] for indicator's container
  ///
  /// **NOTE**: if not provided it defaults to [CrossAxisAlignment.center]
  final CrossAxisAlignment crossAxisAlignment;

  /// Assign alignment [MainAxisAlignment] for a single step
  ///
  /// **NOTE**: if not provided it defaults to [MainAxisAlignment.center]
  final MainAxisAlignment stepMainAxisAlignment;

  /// Assign alignment [CrossAxisAlignment] for a single step
  ///
  /// **NOTE**: if not provided it defaults to [CrossAxisAlignment.center]
  final CrossAxisAlignment stepCrossAxisAlignment;

  const CustomStepProgressIndicator({
    required this.totalSteps,
    this.customStep,
    this.onTap,
    this.customColor,
    this.customSize,
    this.selectedSize,
    this.unselectedSize,
    this.roundedEdges,
    this.gradientColor,
    this.selectedGradientColor,
    this.unselectedGradientColor,
    this.blendMode,
    this.direction = Axis.horizontal,
    this.progressDirection = TextDirection.ltr,
    this.size = 4.0,
    this.currentStep = 0,
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.grey,
    this.padding = 2.0,
    this.fallbackLength = 100.0,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.stepMainAxisAlignment = MainAxisAlignment.center,
    this.stepCrossAxisAlignment = CrossAxisAlignment.center,
    Key? key,
  })  : assert(totalSteps > 0,
            "Number of total steps (totalSteps) of the StepProgressIndicator must be greater than 0"),
        assert(currentStep >= 0,
            "Current step (currentStep) of the StepProgressIndicator must be greater than or equal to 0"),
        assert(padding >= 0.0,
            "Padding (padding) of the StepProgressIndicator must be greater or equal to 0"),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraits) => SizedBox(
        width: _sizeOrMaxLength(
          direction == Axis.horizontal,
          constraits.maxWidth,
        ),
        height: _sizeOrMaxLength(
          direction == Axis.vertical,
          constraits.maxHeight,
        ),
        child: LayoutBuilder(
          builder: (ctx, constraits) => _applyShaderMask(
            gradientColor,
            _applyWidgetDirection(
              (maxSize) => !_isOptimizable
                  ? _buildSteps(
                      _stepHeightOrWidthValue(maxSize),
                    )
                  : _buildOptimizedSteps(
                      _maxHeightOrWidthValue(maxSize),
                    ),
              constraits,
            ),
          ),
        ),
      ),
    );
  }

  bool get _isOnlyOneStep =>
      totalSteps == 1 || (currentStep == 0 && padding == 0);

  /// Apply a [Row] when the [direction] of the indicator is [Axis.horizontal],
  /// or a [Column] otherwise ([Axis.vertical])
  Widget _applyWidgetDirection(
      List<Widget> Function(double) children, BoxConstraints constraits) {
    if (direction == Axis.horizontal) {
      return Row(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
        children: children(constraits.maxWidth),
      );
    } else {
      return Column(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
        children: children(constraits.maxHeight),
      );
    }
  }

  /// If the gradient given is defined, then wrap the given [child] in a gradient [ShaderMask]
  Widget _applyShaderMask(Gradient? gradient, Widget child) {
    if (gradient != null) {
      return ShaderMask(
        shaderCallback: (rect) => gradient.createShader(rect),
        // Apply user defined blendMode if defined, default otherwise
        blendMode: blendMode != null ? blendMode! : BlendMode.modulate,
        child: child,
      );
    } else {
      return child;
    }
  }

  /// Compute the maximum possible size of the indicator between
  /// [size], [selectedSize], [unselectedSize], and [customSize]
  double get maxDefinedSize {
    // If customSize not defined, use size, selectedSize, unselectedSize
    if (customSize == null) {
      return max(size, max(selectedSize ?? 0, unselectedSize ?? 0));
    }

    // When customSize defined, compute max possible size
    double currentMaxSize = 0;

    for (int step = 0; step < totalSteps; ++step) {
      final customSizeValue = customSize!(step, _isSelectedColor(step));
      if (customSizeValue > currentMaxSize) {
        currentMaxSize = customSizeValue;
      }
    }

    return currentMaxSize;
  }

  /// As much space as possible when size not unbounded, otherwise use fallbackLength.
  /// If indicator is in the opposite direction, then use size
  double _sizeOrMaxLength(bool isCorrectDirection, double maxLength) =>
      isCorrectDirection
          // If space is not unbounded, then fill it with the indicator
          ? maxLength != double.infinity
              ? double.infinity
              : fallbackLength
          : maxDefinedSize;

  /// Draw just two containers in case no specific step setting is required
  /// i.e. it becomes a linear progress indicator with two steps: selected and unselected
  bool get _isOptimizable =>
      padding == 0 &&
      customColor == null &&
      customStep == null &&
      customSize == null &&
      onTap == null;

  /// Compute single step length, based on total length available
  double _stepHeightOrWidthValue(double maxSize) =>
      (_maxHeightOrWidthValue(maxSize) - (padding * 2 * totalSteps)) /
      totalSteps;

  /// Total length (horizontal or vertical) available for the indicator
  double _maxHeightOrWidthValue(double maxSize) =>
      maxSize != double.infinity ? maxSize : fallbackLength;

  /// Choose what [Color] to assign
  /// given current [step] index (zero-based)
  Color _chooseStepColor(int step, int stepIndex) {
    // Compute id given step is unselected or not
    final isUnselectedStepColor = progressDirection == TextDirection.ltr
        ? step > currentStep
        : step < totalSteps - currentStep;

    // Override all the other color options when gradient is defined
    if (gradientColor != null ||
        (isUnselectedStepColor && unselectedGradientColor != null) ||
        (!isUnselectedStepColor && selectedGradientColor != null)) {
      return Colors.white;
    }

    // Assign customColor if not null
    if (customColor != null) {
      return customColor!(stepIndex);
    }

    // Selected or Unselected color based on the progressDirection
    if (isUnselectedStepColor) {
      return unselectedColor;
    } else {
      return selectedColor;
    }
  }

  /// `true` if color of the step given index is [selectedColor]
  bool _isSelectedColor(int step) =>
      customColor == null &&
      !(progressDirection == TextDirection.ltr
          ? step > currentStep
          : step < totalSteps - currentStep);

  /// Build only two steps when the condition of [_isOptimizable] is verified
  List<Widget> _buildOptimizedSteps(double indicatorLength) {
    List<Widget> stepList = [];
    final isLtr = progressDirection == TextDirection.ltr;
    final isHorizontal = direction == Axis.horizontal;

    // Choose gradient based on direction defined
    final firstStepGradient =
        isLtr ? selectedGradientColor : unselectedGradientColor;
    final secondStepGradient =
        !isLtr ? selectedGradientColor : unselectedGradientColor;

    final firstStepLength = indicatorLength * (currentStep / totalSteps);
    final secondStepLength = indicatorLength - firstStepLength;

    // Add first step
    stepList.add(
      _applyShaderMask(
        firstStepGradient,
        _ProgressStep(
          direction: direction,
          padding: padding,
          color: firstStepGradient != null
              ? Colors.white
              : isLtr
                  ? selectedColor
                  : unselectedColor,
          width: isHorizontal
              ? isLtr
                  ? firstStepLength
                  : secondStepLength
              : isLtr
                  ? selectedSize ?? size
                  : unselectedSize ?? size,
          height: !isHorizontal
              ? isLtr
                  ? firstStepLength
                  : secondStepLength
              : isLtr
                  ? selectedSize ?? size
                  : unselectedSize ?? size,
          roundedEdges: roundedEdges,
          isOnlyOneStep: _isOnlyOneStep,
          isFirstStep: true,
          mainAxisAlignment: stepMainAxisAlignment,
          crossAxisAlignment: stepCrossAxisAlignment,
        ),
      ),
    );

    // Add second step
    stepList.add(
      _applyShaderMask(
        secondStepGradient,
        _ProgressStep(
          direction: direction,
          padding: padding,
          color: secondStepGradient != null
              ? Colors.white
              : !isLtr
                  ? selectedColor
                  : unselectedColor,
          width: isHorizontal
              ? isLtr
                  ? secondStepLength
                  : firstStepLength
              : !isLtr
                  ? selectedSize ?? size
                  : unselectedSize ?? size,
          height: !isHorizontal
              ? isLtr
                  ? secondStepLength
                  : firstStepLength
              : !isLtr
                  ? selectedSize ?? size
                  : unselectedSize ?? size,
          roundedEdges: roundedEdges,
          isOnlyOneStep: _isOnlyOneStep,
          isLastStep: true,
          mainAxisAlignment: stepMainAxisAlignment,
          crossAxisAlignment: stepCrossAxisAlignment,
        ),
      ),
    );

    return stepList;
  }

  /// Build the list of [_ProgressStep],
  /// based on number of [totalSteps]
  List<Widget> _buildSteps(double stepLength) {
    // Build list of selected and unselected steps
    List<Widget> selectedStepList = [];
    List<Widget> unselectedStepList = [];

    // Define directions parameters
    final isLtr = progressDirection == TextDirection.ltr;
    final isHorizontal = direction == Axis.horizontal;

    // From 0 to totalStep if TextDirection.ltr, from (totalSteps - 1) to 0 otherwise
    int step = isLtr ? 0 : totalSteps - 1;

    // Add steps to the list, based on the progressDirection attribute
    for (; isLtr ? step < totalSteps : step >= 0; isLtr ? ++step : --step) {
      // currentStep = 6, then 6 selected and 4 not selected
      final loopStep = isLtr ? step + 1 : totalSteps - step - 1;
      final isSelectedStepColor = _isSelectedColor(loopStep);

      // customColor if not null, otherwise selected or unselected color
      final stepColor = _chooseStepColor(loopStep, step);

      // If defined and applicable, apply customSize or
      // different sizes for selected and unselected
      final stepSize = customSize != null
          ? customSize!(step, isSelectedStepColor)
          : isSelectedStepColor
              ? selectedSize ?? size
              : unselectedSize ?? size;

      final progressStep = _ProgressStep(
        direction: direction,
        padding: padding,
        color: stepColor,
        width: isHorizontal ? stepLength : stepSize,
        height: !isHorizontal ? stepLength : stepSize,
        customStep:
            customStep != null ? customStep!(step, stepColor, stepSize) : null,
        onTap: onTap != null ? onTap!(step) : null,
        isFirstStep: step == 0,
        isLastStep: step == totalSteps - 1,
        roundedEdges: roundedEdges,
        isOnlyOneStep: _isOnlyOneStep,
        mainAxisAlignment: stepMainAxisAlignment,
        crossAxisAlignment: stepCrossAxisAlignment,
      );

      // Add to list of selected or unselected steps based on selection state
      if (isSelectedStepColor) {
        selectedStepList.add(progressStep);
      } else {
        unselectedStepList.add(progressStep);
      }
    }

    // Apply shader if gradient is not null and build a row or column based on the direction
    return [
      _applyShaderMask(
        isLtr ? selectedGradientColor : unselectedGradientColor,
        direction == Axis.horizontal
            ? Row(
                children: isLtr ? selectedStepList : unselectedStepList,
              )
            : Column(
                children: isLtr ? selectedStepList : unselectedStepList,
              ),
      ),
      _applyShaderMask(
        !isLtr ? selectedGradientColor : unselectedGradientColor,
        direction == Axis.horizontal
            ? Row(
                children: !isLtr ? selectedStepList : unselectedStepList,
              )
            : Column(
                children: !isLtr ? selectedStepList : unselectedStepList,
              ),
      ),
    ];
  }
}

/// Single step of the indicator
class _ProgressStep extends StatelessWidget {
  final Axis direction;
  final double width;
  final double height;
  final Color color;
  final double padding;
  final Widget? customStep;
  final void Function()? onTap;
  final bool isFirstStep;
  final bool isLastStep;
  final bool isOnlyOneStep;
  final Radius? roundedEdges;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const _ProgressStep({
    required this.direction,
    required this.color,
    required this.padding,
    required this.width,
    required this.height,
    required this.mainAxisAlignment,
    required this.crossAxisAlignment,
    this.customStep,
    this.onTap,
    this.isFirstStep = false,
    this.isLastStep = false,
    this.isOnlyOneStep = false,
    this.roundedEdges,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Assign given padding
    return Column(
      // Single step alignment
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: direction == Axis.horizontal ? padding : 0.0,
            vertical: direction == Axis.vertical ? padding : 0.0,
          ),
          // If first or last step and rounded edges enabled, apply
          // rounded edges using ClipRRect
          // Different corners based on first/last step and indicator's direction
          // - First step + horizontal: top-left, bottom-left
          // - First step + vertical: top-left, top-right
          // - Last step + horizontal: top-right, bottom-right
          // - Last step + vertical: bottom-left, bottom-right
          child: (isFirstStep || isLastStep || isOnlyOneStep) &&
                  roundedEdges != null
              ? ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: _radiusTopLeft ? roundedEdges! : Radius.zero,
                    bottomRight:
                        _radiusBottomRight ? roundedEdges! : Radius.zero,
                    bottomLeft: _radiusBottomLeft ? roundedEdges! : Radius.zero,
                    topRight: _radiusTopRight ? roundedEdges! : Radius.zero,
                  ),
                  child: _buildStep,
                )
              : _buildStep,
        ),
      ],
    );
  }

  /// Check if to apply rounded edges to top left border
  bool get _radiusTopLeft => (isFirstStep || isOnlyOneStep);

  /// Check if to apply rounded edges to bottom right border
  bool get _radiusBottomRight => (isLastStep || isOnlyOneStep);

  /// Check if to apply rounded edges to bottom left border
  bool get _radiusBottomLeft =>
      ((isFirstStep || isOnlyOneStep) && direction == Axis.horizontal) ||
      ((isLastStep || isOnlyOneStep) && direction == Axis.vertical);

  /// Check if to apply rounded edges to top right border
  bool get _radiusTopRight =>
      ((isFirstStep || isOnlyOneStep) && direction == Axis.vertical) ||
      ((isLastStep || isOnlyOneStep) && direction == Axis.horizontal);

  /// Build the actual single step [Widget]
  Widget get _buildStep => onTap != null && customStep == null
      ? Material(
          color: color,
          child: InkWell(
            onTap: onTap,
            // Container (simple rectangle) when no customStep defined
            // SizedBox containing the customStep otherwise
            child: _stepContainer(),
          ),
        )
      : onTap != null && customStep != null
          ? SizedBox(
              width: width,
              height: height,
              child: GestureDetector(
                onTap: onTap,
                child: customStep,
              ),
            )
          : _buildStepContainer;

  /// Build [_stepContainer] based on input parameters:
  /// - [Container] with background color when [customStep] is not defined
  /// - [SizedBox] with [customStep] when defined
  Widget get _buildStepContainer => customStep == null
      ? _stepContainer(color)
      : SizedBox(
          width: width,
          height: height,
          child: customStep,
        );

  /// Single step [Container]
  Widget _stepContainer([Color? color]) => Container(
        width: width,
        height: height,
        color: color,
      );
}
