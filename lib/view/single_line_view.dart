import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 单行的widget
class SingleLineView extends StatefulWidget {
  final String? title;
  final String content;
  final TextStyle contentStyle;
  final Widget? leftIcon;
  final Widget? rightWidget;
  final GestureTapCallback? onTap;
  final bool showArrow;
  final double height;
  final EdgeInsetsGeometry margin;
  SingleLineView(
      {Key? key,
      @required this.title,
      this.content = '',
      this.onTap,
      this.showArrow = true,
      this.rightWidget,
      this.leftIcon,
      this.contentStyle = const TextStyle(color: Colors.black87, fontSize: 14),
      this.height = 48,
      this.margin = const EdgeInsets.only(top: 1)})
      : super(key: key);

  @override
  _SingleLineWidgetIconState createState() => _SingleLineWidgetIconState();
}

class _SingleLineWidgetIconState extends State<SingleLineView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap ?? () {},
      behavior: HitTestBehavior.opaque,
      child: Container(
        color: Colors.white,
        margin: widget.margin,
        height: widget.height,
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            widget.leftIcon ?? SizedBox(),
            SizedBox(width: widget.leftIcon == null ? 0 : 8),
            Text(widget.title ?? "", style: widget.contentStyle),
            SizedBox(width: 10),
            Expanded(
                child: Text(widget.content,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.end,
                    style: widget.contentStyle)),
            widget.rightWidget != null
                ? widget.rightWidget!
                : widget.showArrow
                    ? Icon(Icons.keyboard_arrow_right)
                    : SizedBox(),
          ],
        ),
      ),
    );
  }
}
