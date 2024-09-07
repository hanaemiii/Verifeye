import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verifeye/base/assets/assets.dart';
import 'package:verifeye/bloc/main_bloc/main_bloc.dart';
import 'package:verifeye/bloc/main_bloc/main_event.dart';
import 'package:verifeye/bloc/main_bloc/main_state.dart';
import 'package:verifeye/base/theme/colors.dart';
import 'package:verifeye/core/global_values/global_values.dart';
import 'package:verifeye/widgets/buttons/main_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    BlocProvider.of<MainBloc>(context).add(
      GetUserEvent(),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        String name = '';
        if (state.user != null) {
          name = state.user!.firstName;
        }
        return Scaffold(
          backgroundColor: AppColors.gray.withOpacity(0.1),
          appBar: AppBar(
            backgroundColor: AppColors.backgroundViolet,
            toolbarHeight: safeAreaTop + 70,
            title: Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Row(
                children: [
                  photoWidget(state),
                  const SizedBox(
                    width: 20,
                  ),
                  greetingWidget(name),
                ],
              ),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(25),
              ),
            ),
            elevation: 2,
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 70,
            ),
            color: AppColors.gray.withOpacity(0.1),
            alignment: Alignment.center,
            child:
                state.file == null ? dottedAreaWidget() : uploadedWidget(state),
          ),
        );
      },
    );
  }

  Widget uploadedWidget(MainState state) {
    return Column(
      children: [
        Image.file(
          state.file!,
          width: screenWidth,
          height: 200,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          height: 50,
        ),
        MainButton(
          color: AppColors.black.withOpacity(0.8),
          title: 'Delete Selected Image',
          onTap: () => BlocProvider.of<MainBloc>(context).add(
            DeleteSelectedPhotoEvent(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        MainButton(
          color: AppColors.violet.withOpacity(0.3),
          title: 'Submit',
          onTap: () => BlocProvider.of<MainBloc>(context).add(
            SendToStorageEvent(),
          ),
        ),
      ],
    );
  }

  Widget greetingWidget(String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hi $name',
          style: Theme.of(context).primaryTextTheme.bodyLarge!.copyWith(
                color: AppColors.white,
              ),
        ),
        Text(
          'Nice to see you!',
          style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(
                color: AppColors.white,
              ),
        ),
      ],
    );
  }

  Widget photoWidget(MainState state) {
    return Container(
      width: 80,
      height: 80,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white,
      ),
      child: state.user != null && state.user!.photoUrl != null
          ? SizedBox(
              width: 80.0,
              height: 80.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60.0),
                child: Image.network(
                  state.user!.photoUrl!,
                  fit: BoxFit.cover,
                ),
              ),
            )
          : const Icon(
              Icons.person,
              size: 40,
              color: AppColors.gray,
            ),
    );
  }

  Widget dottedAreaWidget() {
    return DottedBorder(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      color: AppColors.black.withOpacity(0.5),
      strokeWidth: 1,
      borderType: BorderType.RRect,
      radius: const Radius.circular(16),
      dashPattern: const [10, 5],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.upload,
              height: 180.0,
              width: 180.0,
            ),
            const SizedBox(
              height: 24,
            ),
            MainButton(
              title: 'Open Gallery',
              onTap: () => BlocProvider.of<MainBloc>(context).add(
                ChoosePhotoEvent(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
