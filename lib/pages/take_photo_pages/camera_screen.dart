import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verifeye/base/theme/colors.dart';
import 'package:verifeye/bloc/account_bloc/account_bloc.dart';
import 'package:verifeye/bloc/account_bloc/account_event.dart';
import 'package:verifeye/bloc/account_bloc/account_state.dart';
import 'package:verifeye/core/global_values/global_values.dart';
import 'package:verifeye/pages/take_photo_pages/display_picture_screen.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({
    super.key,
  });
  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  bool isFlipped = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AccountBloc>(context).add(
      OpenCameraEvent(isFlipped),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        if (state.controller != null) {
          return CameraPreview(
            state.controller!,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                fit: StackFit.expand,
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        color: AppColors.black,
                        height: screenHeight < 800 ? 90 : 100,
                      ),
                      Container(
                        padding: screenHeight < 800
                            ? const EdgeInsets.all(40)
                            : const EdgeInsets.all(80),
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        height: screenHeight > 800 ? 230 : 140,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              width: 40,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const DisplayPictureScreen(),
                                  ),
                                );
                              },
                              child: captureButtonWidget(),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isFlipped = !isFlipped;
                                });
                                BlocProvider.of<AccountBloc>(context).add(
                                  OpenCameraEvent(isFlipped),
                                );
                              },
                              child: const Icon(
                                Icons.flip_camera_ios_outlined,
                                color: AppColors.white,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.violet,
            ),
          );
        }
      },
    );
  }

  Widget captureButtonWidget() {
    return Container(
      width: 70,
      height: 70,
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.black,
            width: 2,
          ),
          shape: BoxShape.circle,
          color: AppColors.white,
        ),
      ),
    );
  }
}
