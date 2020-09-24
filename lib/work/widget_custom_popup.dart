import 'dart:core';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShowMoreTextPopup {
  double _popupWidth = 200.0;
  double _popupHeight = 200.0;
  double arrowHeight = 10.0;
  OverlayEntry _entry;
  Widget _content;
  Offset _offset;
  Rect _showRect;
  bool _isDownArrow = true;
  bool _isRightArrow = true;

  VoidCallback dismissCallback;

  Size _screenSize;

  BuildContext context;
  Color _backgroundColor;

  bool _isVisible = false;

  bool _horizontalTriangle = false;

  bool _hasArrow = true;

  BorderRadius _borderRadius;
  EdgeInsetsGeometry _padding;

  ShowMoreTextPopup(this.context,
      {double height,
      double width,
      VoidCallback onDismiss,
      Color backgroundColor,
      bool horizontalTriangle,
      bool hasArrow,
      Widget content,
      BorderRadius borderRadius,
      EdgeInsetsGeometry padding}) {
    dismissCallback = onDismiss;
    _popupHeight = height;
    _popupWidth = width;
    _content = content;
    _hasArrow = hasArrow ?? true;
    _horizontalTriangle = horizontalTriangle ?? false;
    _backgroundColor = backgroundColor ?? Color(0xFFFFA500);
    _borderRadius = borderRadius ?? BorderRadius.circular(10.0);
    _padding = padding ?? EdgeInsets.all(4.0);
  }

  /// Shows a popup near a widget with key [widgetKey] or [rect].
  void show({Rect rect, GlobalKey widgetKey}) {
    if (rect == null && widgetKey == null) {
      print("both 'rect' and 'key' can't be null");
      return;
    }

    _showRect = rect ?? _getWidgetGlobalRect(widgetKey);
    _screenSize = window.physicalSize / window.devicePixelRatio;
    dismissCallback = dismissCallback;

    _calculatePosition(context);

    _entry = OverlayEntry(builder: (context) {
      return _horizontalTriangle
          ? buildHorizontalPopupLayout(_offset)
          : buildVerticalPopupLayout(_offset);
    });

    Overlay.of(context).insert(_entry);
    _isVisible = true;
  }

  void _calculatePosition(BuildContext context) {
    _offset = _horizontalTriangle
        ? _calculateHorizontalOffset(context)
        : _calculateVerticalOffset(context);
  }

  /// Returns globalRect of widget with key [key]
  Rect _getWidgetGlobalRect(GlobalKey key) {
    RenderBox renderBox = key.currentContext.findRenderObject();
    var offset = renderBox.localToGlobal(Offset.zero);
    return Rect.fromLTWH(
        offset.dx, offset.dy, renderBox.size.width, renderBox.size.height);
  }

  Offset _calculateVerticalOffset(BuildContext context) {
    var dx = _showRect.left + _showRect.width / 2.0 - _popupWidth / 2.0;
    if (dx < 10.0) {
      dx = 10.0;
    }

    if (dx + _popupWidth > _screenSize.width && dx > 10.0) {
      var tempDx = _screenSize.width - _popupWidth - 10;
      if (tempDx > 10) dx = tempDx;
    }

    var dy = _showRect.top - _popupHeight;
    if (dy <= MediaQuery.of(context).padding.top + 10) {
      // not enough space above, show popup under the widget.
      dy = _showRect.height + _showRect.top;
      if (_hasArrow) {
        dy += arrowHeight;
      }
      _isDownArrow = false;
    } else {
      if (_hasArrow) {
        dy -= arrowHeight;
      }
      _isDownArrow = true;
    }

    return Offset(dx, dy);
  }

  /// Returns calculated widget offset using [context]
  Offset _calculateHorizontalOffset(BuildContext context) {
    var dy = _showRect.top + _showRect.height / 2.0 - _popupHeight / 2.0;
    if (dy < 10.0) {
      dy = 10.0;
    }

    if (dy + _popupHeight > _screenSize.height && dy > 10.0) {
      var tempDy = _screenSize.height - _popupHeight - 10;
      if (tempDy > 10) dy = tempDy;
    }

    var dx = _showRect.left - _popupWidth;
    if (dx <= MediaQuery.of(context).padding.left + 10) {
      // not enough space above, show popup under the widget.
      dx = _showRect.width + _showRect.left;
      if (_hasArrow) {
        dx += arrowHeight;
      }
      _isRightArrow = false;
    } else {
      if (_hasArrow) {
        dx -= arrowHeight;
      }
      _isRightArrow = true;
    }

    return Offset(dx, dy);
  }

  Widget _contentWidget() {
    return Container(
        padding: _padding,
        width: _popupWidth,
        height: _popupHeight,
        decoration: BoxDecoration(
            color: _backgroundColor,
            borderRadius: _borderRadius,
            boxShadow: [
              BoxShadow(
                color: Color(0xFF808080),
                blurRadius: 1.0,
              ),
            ]),
        child: _content);
  }

  /// Builds Layout of popup for specific [offset]
  LayoutBuilder buildVerticalPopupLayout(Offset offset) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          dismiss();
        },
        child: Material(
          color: Colors.transparent,
          child: Stack(
            children: <Widget>[
              // triangle arrow
              if (_hasArrow)
                Positioned(
                  left: _showRect.left + _showRect.width / 2.0 - 7.5,
                  top: _isDownArrow
                      ? offset.dy + _popupHeight
                      : offset.dy - arrowHeight,
                  child: CustomPaint(
                    size: Size(15.0, arrowHeight),
                    painter: TriangleVerticalPainter(
                        isDownArrow: _isDownArrow, color: _backgroundColor),
                  ),
                ),
              // popup content
              Positioned(
                left: offset.dx,
                top: offset.dy,
                child: _contentWidget(),
              )
            ],
          ),
        ),
      );
    });
  }

  /// Builds Layout of popup for specific [offset]
  LayoutBuilder buildHorizontalPopupLayout(Offset offset) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          dismiss();
        },
        child: Material(
          color: Colors.transparent,
          child: Stack(
            children: <Widget>[
              // triangle arrow
              if (_hasArrow)
                Positioned(
                  left: _isRightArrow
                      ? offset.dx + _popupWidth
                      : offset.dx - arrowHeight,
                  top: _showRect.top + _showRect.height / 2.0 - 7.5,
                  child: CustomPaint(
                    size: Size(15.0, arrowHeight),
                    painter: TriangleHorizontalPainter(
                        isRightArrow: _isRightArrow, color: _backgroundColor),
                  ),
                ),
              // popup content
              Positioned(
                left: offset.dx,
                top: offset.dy,
                child: _contentWidget(),
              )
            ],
          ),
        ),
      );
    });
  }

  /// Dismisses the popup
  void dismiss() {
    if (!_isVisible) {
      return;
    }
    _entry.remove();
    _isVisible = false;
    if (dismissCallback != null) {
      dismissCallback();
    }
  }
}

/// [TrianglePainter] is custom painter for drawing a triangle for popup
/// to point specific widget
class TriangleVerticalPainter extends CustomPainter {
  bool isDownArrow;
  Color color;

  TriangleVerticalPainter({this.isDownArrow = true, this.color});

  /// Draws the triangle of specific [size] on [canvas]
  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    var paint = Paint();
    paint.strokeWidth = 2.0;
    paint.color = color;
    paint.style = PaintingStyle.fill;

    if (isDownArrow) {
      path.moveTo(0.0, -1.0);
      path.lineTo(size.width, -1.0);
      path.lineTo(size.width / 2.0, size.height);
    } else {
      path.moveTo(size.width / 2.0, 0.0);
      path.lineTo(0.0, size.height + 1);
      path.lineTo(size.width, size.height + 1);
    }

    canvas.drawPath(path, paint);
  }

  /// Specifies to redraw for [customPainter]
  @override
  bool shouldRepaint(CustomPainter customPainter) {
    return true;
  }
}

class TriangleHorizontalPainter extends CustomPainter {
  bool isRightArrow;
  Color color;

  TriangleHorizontalPainter({this.isRightArrow = true, this.color});

  /// Draws the triangle of specific [size] on [canvas]
  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    var paint = Paint();
    paint.strokeWidth = 2.0;
    paint.color = color;
    paint.style = PaintingStyle.fill;

    if (isRightArrow) {
      path.moveTo(1.0, 0.0);
      path.lineTo(1.0, size.width);
      path.lineTo(size.width / 2, size.width / 2.0);
    } else {
      path.moveTo(1.0, size.width / 2.0);
      path.lineTo(size.width / 2 + 1.0, size.width);
      path.lineTo(size.width / 2 + 1.0, 0.0);
    }

    canvas.drawPath(path, paint);
  }

  /// Specifies to redraw for [customPainter]
  @override
  bool shouldRepaint(CustomPainter customPainter) {
    return true;
  }
}
