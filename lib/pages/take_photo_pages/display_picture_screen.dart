import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verifeye/base/theme/colors.dart';
import 'package:verifeye/bloc/account_bloc/account_bloc.dart';
import 'package:verifeye/bloc/account_bloc/account_event.dart';
import 'package:verifeye/bloc/account_bloc/account_state.dart';
import 'package:verifeye/core/global_values/global_values.dart';

class DisplayPictureScreen extends StatefulWidget {
  const DisplayPictureScreen({super.key});
  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AccountBloc>(context).add(
      TakePictureEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        if (state.file != null) {
          return Container(
            padding: const EdgeInsets.only(top: 50),
            color: AppColors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: screenHeight - 100,
                  child: Image.file(state.file!),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.refresh,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
