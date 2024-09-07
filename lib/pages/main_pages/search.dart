import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verifeye/base/theme/colors.dart';
import 'package:verifeye/bloc/search/search_bloc.dart';
import 'package:verifeye/bloc/search/search_state.dart';
import 'package:verifeye/core/global_values/global_values.dart';
import 'package:verifeye/widgets/custom%20fields/serach_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 25 + safeAreaTop,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchBarWidget(),
              const SizedBox(
                height: 30,
              ),
              state.loading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.backgroundViolet.withOpacity(0.7),
                      ),
                    )
                  : const Text('data'),
            ],
          ),
        );
      }),
    );
  }
}
