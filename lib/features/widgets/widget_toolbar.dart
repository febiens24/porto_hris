import 'package:flutter/material.dart';

import '../../common/utils/color_const.dart';

class WidgetToolBar extends StatefulWidget {
  const WidgetToolBar({
    Key? key,
    required this.title,
    this.onSubmitted,
    this.actionButton,
  }) : super(key: key);

  final String title;
  final Widget? actionButton;
  final Function(String)? onSubmitted;

  @override
  _WidgetToolBarState createState() => _WidgetToolBarState();
}

class _WidgetToolBarState extends State<WidgetToolBar> {
  final TextEditingController _searchController = TextEditingController();

  bool? isSearching;

  void _openSearch() {
    setState(() {
      isSearching = true;
    });
  }

  void _closeSearch() {
    setState(() {
      isSearching = false;
    });
  }

  @override
  void initState() {
    super.initState();
    isSearching = false;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConst.defaultColor,
      height: kToolbarHeight,
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          Expanded(
            child: _buildTitle(isSearching),
          ),
          _buildAction(),
          widget.actionButton ?? const SizedBox.shrink()
        ],
      ),
    );
  }

  _buildAction() {
    return Row(
      children: <Widget>[
        isSearching!
            ? IconButton(
                onPressed: () {
                  _closeSearch();
                },
                icon: const Icon(Icons.close, color: Colors.white),
              )
            : IconButton(
                onPressed: () {
                  _openSearch();
                },
                icon: const Icon(Icons.search, color: Colors.white),
              ),
        // const SizedBox(width: 12)
      ],
    );
  }

  _buildTitle(isSearching) {
    // _searchController.text == '';
    return isSearching!
        ? TextField(
            controller: _searchController,
            keyboardType: TextInputType.text,
            maxLines: 1,
            autofocus: true,
            textInputAction: TextInputAction.search,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            decoration: const InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            onSubmitted: widget.onSubmitted,
          )
        : Text(
            widget.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          );
  }
}
