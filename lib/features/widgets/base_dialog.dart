import 'package:flutter/material.dart';

// /// Defines variants of entry animations
// enum EntryAnimation {
//   /// Appears in Center, standard Material dialog entrance animation, i.e. slow fade-in in the center of the screen.
//   DEFAULT,

//   /// Enters screen horizontally from the left
//   LEFT,

//   /// Enters screen horizontally from the right
//   RIGHT,

//   /// Enters screen horizontally from the top
//   TOP,

//   /// Enters screen horizontally from the bottom
//   BOTTOM,

//   /// Enters screen from the top left corner
//   TOP_LEFT,

//   /// Enters screen from the top right corner
//   TOP_RIGHT,

//   /// Enters screen from the bottom left corner
//   BOTTOM_LEFT,

//   /// Enters screen from the bottom right corner
//   BOTTOM_RIGHT,
// }

class BaseDialog extends StatefulWidget {
  const BaseDialog({
    Key? key,
    this.imageWidget,
    this.title,
    this.onOkButtonPressed,
    this.description,
    this.onlyOkButton,
    this.onlyCancelButton,
    this.buttonOkText,
    this.buttonCancelText,
    this.buttonOkColor,
    this.buttonCancelColor,
    this.cornerRadius,
    this.buttonRadius,
    this.onCancelButtonPressed,
  }) : super(key: key);

  final Widget? imageWidget;
  final Text? title;
  final Text? description;
  final bool? onlyOkButton;
  final bool? onlyCancelButton;
  final Text? buttonOkText;
  final Text? buttonCancelText;
  final Color? buttonOkColor;
  final Color? buttonCancelColor;
  final double? buttonRadius;
  final double? cornerRadius;
  final VoidCallback? onOkButtonPressed;
  final VoidCallback? onCancelButtonPressed;

  @override
  _BaseDialogState createState() => _BaseDialogState();
}

class _BaseDialogState extends State<BaseDialog> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _entryAnimation;

  get _start => const Offset(0.0, 1.0);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _entryAnimation =
        Tween<Offset>(begin: _start, end: const Offset(0.0, 0.0)).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    )..addListener(() => setState(() {}));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _entryAnimation.removeListener(() {});
    super.dispose();
  }

  Widget _buildPortraitWidget(BuildContext context, Widget imageWidget) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(widget.cornerRadius!),
              topLeft: Radius.circular(widget.cornerRadius!),
            ),
            child: imageWidget,
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: widget.title,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.description,
              ),
              _buildButtonsBar(context)
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLandscapeWidget(BuildContext context, Widget imageWidget) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(widget.cornerRadius!),
              bottomLeft: Radius.circular(widget.cornerRadius!),
            ),
            child: imageWidget,
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: widget.title,
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: widget.description,
              ),
              _buildButtonsBar(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButtonsBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: !widget.onlyOkButton!
            ? MainAxisAlignment.spaceEvenly
            : MainAxisAlignment.center,
        children: <Widget>[
          if (!widget.onlyOkButton!) ...[
            // RaisedButton(
            //   color: widget.buttonCancelColor,
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(widget.buttonRadius)),
            //   onPressed: widget.onCancelButtonPressed ??
            //       () => Navigator.of(context).pop(),
            //   child: widget.buttonCancelText ??
            //       Text(
            //         'Cancel',
            //         style: TextStyle(color: Colors.white),
            //       ),
            // )
            ElevatedButton(
              onPressed: widget.onCancelButtonPressed ??
                  () => Navigator.of(context).pop(),
              child: widget.buttonCancelText ?? const Text('Cancel'),
            ),
          ],
          if (!widget.onlyCancelButton!) ...[
            // RaisedButton(
            //   color: widget.buttonOkColor,
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(widget.buttonRadius)),
            //   onPressed: widget.onOkButtonPressed,
            //   child: widget.buttonOkText ??
            //       Text(
            //         'OK',
            //         style: TextStyle(color: Colors.white),
            //       ),
            // ),
            ElevatedButton(
              onPressed: widget.onOkButtonPressed,
              child: widget.buttonCancelText ?? const Text('OK'),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        transform: Matrix4.translationValues(
          _entryAnimation.value.dx * width,
          _entryAnimation.value.dy * width,
          0,
        ),
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * (isPortrait ? 0.8 : 0.6),
        child: Material(
          type: MaterialType.card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.cornerRadius!),
          ),
          elevation: Theme.of(context).dialogTheme.elevation ?? 24.0,
          child: isPortrait
              ? _buildPortraitWidget(context, widget.imageWidget!)
              : _buildLandscapeWidget(context, widget.imageWidget!),
        ),
      ),
    );
  }
}
