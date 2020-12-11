import 'package:flutter/material.dart';

const double _radius = 10.0;

const EdgeInsets _defaultInsetPadding =
    EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0);
RoundedRectangleBorder _defaultShape =
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radius));

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    Key key,
    this.title,
    this.titlePadding,
    this.titleTextStyle,
    this.content,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 24.0),
    this.contentTextStyle,
    this.actions,
    this.actionsPadding = EdgeInsets.zero,
    this.actionsOverflowDirection,
    this.actionsOverflowButtonSpacing,
    this.buttonPadding = EdgeInsets.zero,
    this.backgroundColor,
    this.elevation,
    this.semanticLabel,
    this.insetPadding = _defaultInsetPadding,
    this.clipBehavior = Clip.none,
    this.shape,
  })  : assert(contentPadding != null),
        assert(clipBehavior != null),
        super(key: key);
  final Widget title;
  final EdgeInsetsGeometry titlePadding;
  final TextStyle titleTextStyle;
  final Widget content;
  final EdgeInsetsGeometry contentPadding;
  final TextStyle contentTextStyle;
  final List<Widget> actions;
  final EdgeInsetsGeometry actionsPadding;
  final VerticalDirection actionsOverflowDirection;
  final double actionsOverflowButtonSpacing;
  final EdgeInsetsGeometry buttonPadding;

  final Color backgroundColor;

  final double elevation;
  final String semanticLabel;

  final EdgeInsets insetPadding;

  final Clip clipBehavior;

  final ShapeBorder shape;

  _reActions() {
    List<Widget> actionWidgets =
        actions.map<Widget>((e) => Expanded(child: e)).toList();
    int insertNum = actionWidgets.length - 1;
    if (insertNum > 0) {
      int step = 1;
      for (int i = 0; i < insertNum; i++) {
        actionWidgets.insert(
            i + step,
            SizedBox(
              height: 48.0,
              child: VerticalDivider(width: 1.0),
            ));
        step++;
      }
    }
    return actionWidgets;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final ThemeData theme = Theme.of(context);
    final DialogTheme dialogTheme = DialogTheme.of(context);
    String label = semanticLabel;
    if (title == null) {
      switch (theme.platform) {
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          label = semanticLabel;
          break;
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          label = semanticLabel ??
              MaterialLocalizations.of(context)?.alertDialogLabel;
      }
    }
    Widget titleWidget;
    Widget contentWidget;
    Widget actionsWidget;
    if (title != null)
      titleWidget = Padding(
        padding: titlePadding ??
            EdgeInsets.fromLTRB(16.0, 16.0, 16.0, content == null ? 20.0 : 0.0),
        child: DefaultTextStyle(
          style: titleTextStyle ??
              dialogTheme.titleTextStyle ??
              TextStyle(fontSize: 18.0, color: Colors.black),
          textAlign: TextAlign.center,
          child: Semantics(
            child: title,
            namesRoute: true,
            container: true,
          ),
        ),
      );
    if (content != null)
      contentWidget = Padding(
        padding: contentPadding,
        child: DefaultTextStyle(
          style: contentTextStyle ??
              dialogTheme.contentTextStyle ??
              TextStyle(
                fontSize: 16.0,
                color: Colors.grey[800],
              ),
          textAlign: TextAlign.center,
          child: content,
        ),
      );
    if (actions != null) {
      actionsWidget = Padding(
        padding: actionsPadding,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(_radius),
              bottomRight: Radius.circular(_radius)),
          child: ButtonTheme(
            textTheme: ButtonTextTheme.primary,
            colorScheme: theme.colorScheme.copyWith(primary: Colors.blue),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _reActions(),
            ),
          ),
        ),
      );
    }

    List<Widget> columnChildren;
    columnChildren = <Widget>[
      if (title != null) titleWidget,
      if (content != null) Flexible(child: contentWidget),
      if (actions != null)
        Divider(
          height: 1.0,
        ),
      if (actions != null) actionsWidget,
    ];

    Widget dialogChild = IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: columnChildren,
      ),
    );
    if (label != null)
      dialogChild = Semantics(
        namesRoute: true,
        label: label,
        child: dialogChild,
      );
    return Dialog(
      backgroundColor: backgroundColor,
      elevation: elevation,
      insetPadding: insetPadding,
      clipBehavior: clipBehavior,
      shape: shape ?? _defaultShape,
      child: dialogChild,
    );
  }
}
