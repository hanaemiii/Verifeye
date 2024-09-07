import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verifeye/base/theme/colors.dart';
import 'package:verifeye/bloc/search/search_bloc.dart';
import 'package:verifeye/bloc/search/search_event.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.disabled,
  });
  final TextEditingController controller;
  final bool disabled;

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: _focusNode.hasFocus ? AppColors.backgroundViolet : Colors.grey,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              decoration: const InputDecoration(
                hintText: 'Search URL',
                labelText: 'Search',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
              ),
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
            ),
          ),
          Expanded(
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: widget.disabled
                    ? AppColors.backgroundViolet.withOpacity(0.3)
                    : AppColors.backgroundViolet.withOpacity(0.7),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
              ),
              child: IconButton(
                  icon: const Icon(
                    CupertinoIcons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    widget.disabled
                        ? null
                        : BlocProvider.of<SearchBloc>(context).add(
                            CheckUrlEvent(),
                          );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
