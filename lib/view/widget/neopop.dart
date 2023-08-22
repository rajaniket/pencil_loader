import 'package:flutter/material.dart';

class NeoPopWidget extends StatefulWidget {
  const NeoPopWidget({
    super.key,
    this.child,
    this.onTap,
    this.shadowColor = Colors.black,
    this.shadowOffset = const Offset(5, 5),
    this.boderRadius = 10,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    this.animate = true,
    this.backgroundColor = Colors.white,
    this.width = double.infinity,
    required this.height,
  });
  final Widget? child;
  final Function? onTap;
  final Color shadowColor;
  final Color backgroundColor;
  final Offset shadowOffset;
  final double boderRadius;
  final EdgeInsetsGeometry? padding;
  final double width;
  final double height;
  final bool animate;

  @override
  State<NeoPopWidget> createState() => _NeoPopWidgetState();
}

class _NeoPopWidgetState extends State<NeoPopWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _animation = Tween<Offset>(begin: const Offset(0, 0), end: const Offset(5, 5)).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.animate) {
          _controller.forward().then((value) => _controller.reverse());
        }
        if (widget.onTap != null) widget.onTap!();
      },
      child: Stack(
        children: [
          Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(widget.boderRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  offset: widget.shadowOffset,
                ),
              ],
            ),
          ),
          AnimatedBuilder(
              animation: _animation,
              builder: (context, _) {
                return Transform.translate(
                  offset: _animation.value,
                  child: Container(
                    width: widget.width,
                    height: widget.height,
                    padding: widget.padding,
                    decoration: BoxDecoration(
                      color: widget.backgroundColor,
                      borderRadius: BorderRadius.circular(widget.boderRadius),
                      border: Border.all(
                        color: widget.shadowColor,
                        width: 2,
                      ),
                    ),
                    child: widget.child,
                  ),
                );
              }),
        ],
      ),
    );
  }
}
