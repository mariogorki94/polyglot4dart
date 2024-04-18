import 'package:flutter/material.dart';

typedef SubmitCallback = void Function(String);

class CityBar extends StatefulWidget {
  final bool enabled;
  final SubmitCallback callback;

  const CityBar({
    super.key,
    required this.enabled,
    required this.callback,
  });

  @override
  State createState() => _CityBarState();
}

class _CityBarState extends State<CityBar> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
      child: TextField(
        enabled: widget.enabled,
        style: const TextStyle(color: Colors.black),
        maxLines: 1,
        controller: _textController,
        decoration: const InputDecoration(
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          icon: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.search,
              color: Colors.blue,
            ),
          ),
          contentPadding: EdgeInsets.only(
            left: 0,
            bottom: 11,
            top: 11,
            right: 15,
          ),
          hintText: "Search Location",
        ),
        onSubmitted: (value) {
          if (value.isEmpty) {
            return;
          }
          widget.callback(value);
        },
      ),
    );
  }
}
