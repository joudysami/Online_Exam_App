import 'package:exam_app/config/Di/di.dart';
import 'package:exam_app/config/base/base_state.dart';
import 'package:exam_app/core/theme/app_colors.dart';
import 'package:exam_app/feature/Home/domain/entity/subject_entity.dart';
import 'package:exam_app/feature/Home/presentation/view/widgets/search_text_field.dart';
import 'package:exam_app/feature/Home/presentation/view/widgets/subject_card.dart';
import 'package:exam_app/feature/Home/presentation/view_model/home_event.dart';
import 'package:exam_app/feature/Home/presentation/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late final HomeViewModel homeViewModel = getIt<HomeViewModel>();
  @override
  void initState() {
    super.initState();
    homeViewModel.doEvent(GetAllSubject());
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: 8.h),
          Text(
            'Survey',
            style: TextStyle(
              color: colors.blue[500],
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.15,
            ),
          ),
          SizedBox(height: 20.h),
          SearchTextField(hintText: 'Search'),
          SizedBox(height: 28.h),
          Text(
            'Browse by subject',
            style: TextStyle(
              color: colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.15,
            ),
          ),
          SizedBox(height: 16.h),
          BlocBuilder<HomeViewModel, BaseState<List<SubjectEntity>>>(
            bloc: homeViewModel,
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.data != null) {
                final subjects = state.data!;

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: subjects.length,
                  itemBuilder: (context, index) {
                    final subject = subjects[index];

                    return SubjectCard(
                      title: subject.name,
                      icon: subject.icon,
                      onTap: () {
                      },
                    );
                  },
                );
              }
              if (state.errorMessage.isNotEmpty) {
                return Center(child: Text(state.errorMessage));
              }

              return const SizedBox.shrink();
            },
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
