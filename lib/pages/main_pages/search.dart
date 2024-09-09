import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verifeye/base/assets/assets.dart';
import 'package:verifeye/base/theme/colors.dart';
import 'package:verifeye/bloc/search/search_bloc.dart';
import 'package:verifeye/bloc/search/search_event.dart';
import 'package:verifeye/bloc/search/search_state.dart';
import 'package:verifeye/core/global_values/global_values.dart';
import 'package:verifeye/models/searched_link_model.dart';
import 'package:verifeye/widgets/custom%20fields/serach_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with WidgetsBindingObserver {
  double _keyboardHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    setState(() {
      _keyboardHeight =
          PlatformDispatcher.instance.views.first.viewInsets.bottom;
    });
  }

  @override
  void didChangeDependencies() {
    BlocProvider.of<SearchBloc>(context).add(
      CleanStateEvent(),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundViolet,
        toolbarHeight: safeAreaTop + 20,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
        title: Text(
          'URL Verification',
          style: Theme.of(context).primaryTextTheme.bodyLarge!.copyWith(
                color: AppColors.white,
              ),
        ),
        elevation: 2,
      ),
      backgroundColor: AppColors.gray.withOpacity(0.1),
      body: BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
        return Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 25 + safeAreaTop,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchBarWidget(
                    disabled: state.loading,
                    controller: state.controller,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  state.loading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.backgroundViolet.withOpacity(0.7),
                          ),
                        )
                      : state.link != null
                          ? result(link: state.link!)
                          : const SizedBox(),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  AppAssets.verifeyeLogo,
                  height: _keyboardHeight == 0 ? 350 : 150,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget result({required SearchedLink link}) {
    final TextStyle textStyle = Theme.of(context).textTheme.bodyLarge!;

    switch (link.sslStatus) {
      case 'Valid':
        return answerWidget(
          initialTextStyle: textStyle,
          link: link,
          color: AppColors.green,
          message: 'The link appears to be safe.',
          title: 'All clear!',
          icon: Icons.verified,
        );

      default:
        return answerWidget(
          initialTextStyle: textStyle,
          link: link,
          color: AppColors.red,
          message:
              'The link appears to be unsafe. Proceed with caution or consider avoiding it.',
          title: 'Warning:',
          icon: Icons.warning,
        );
    }
  }

  Widget answerWidget({
    required TextStyle initialTextStyle,
    required SearchedLink link,
    required Color color,
    required String title,
    required String message,
    required IconData icon,
  }) {
    final TextStyle textStyle = initialTextStyle.copyWith(color: color);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: color,
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '$title ',
                      style: textStyle,
                    ),
                    TextSpan(
                      text: '$message\n',
                      style: textStyle,
                    ),
                    WidgetSpan(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '- domain status: ${link.domainStatus}',
                            style: textStyle,
                          ),
                          Text(
                            '- ssl status: ${link.sslStatus}',
                            style: textStyle,
                          ),
                          Text(
                            '- virustotal: ${link.virustotalStatus}',
                            style: textStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
