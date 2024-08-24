import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verifeye/bloc/main_bloc/main_bloc.dart';
import 'package:verifeye/bloc/main_bloc/main_event.dart';
import 'package:verifeye/bloc/main_bloc/main_state.dart';
import 'package:verifeye/base/theme/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray.withOpacity(0.1),
      appBar: AppBar(
        title: const Text('Home'),
        flexibleSpace: Container(
          color: AppColors.black.withOpacity(0.85),
          // decoration: const BoxDecoration(
          //   gradient: LinearGradient(
          //       begin: Alignment.topCenter,
          //       end: Alignment.bottomCenter,
          //       colors: <Color>[
          //         Colors.black,
          //         AppColors.gray,
          //       ]),
          // ),
        ),
      ),
      body: BlocBuilder<MainBloc, MainState>(builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Center(
            child: state.file == null
                ? dottedAreaWidget()
                :
                // Image.asset(
                //   'assets/images/upload.png',
                //   height: 164.0,
                //   width: 164.0,
                // ),
                Column(
                    children: [
                      Image.file(
                        state.file!,
                        height: 150,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<MainBloc>(context).add(
                            DeleteSelectedPhotoEvent(),
                          );
                        },
                        child: Container(
                          color: AppColors.gray,
                          child: const Text(
                            'Delete',
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<MainBloc>(context).add(
                            SendToStorageEvent(),
                          );
                        },
                        child: Container(
                          color: AppColors.mint,
                          child: const Text(
                            'Submit',
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        );
      }),
    );
  }

  Widget dottedAreaWidget() {
    return DottedBorder(
      color: AppColors.black.withOpacity(0.5),
      strokeWidth: 1,
      borderType: BorderType.RRect,
      radius: const Radius.circular(16),
      dashPattern: const [10, 5],
      child: GestureDetector(
        onTap: () {},
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.upload,
                size: 48,
                color: AppColors.black.withOpacity(0.5),
              ),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 24,
              ),
              GestureDetector(
                onTap: () {
                  BlocProvider.of<MainBloc>(context).add(
                    ChoosePhotoEvent(),
                  );
                },
                child: Container(
                  color: Colors.red,
                  child: const Text('upload'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
