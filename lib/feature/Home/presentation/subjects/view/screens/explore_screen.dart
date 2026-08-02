import 'package:exam_app/config/Di/di.dart';
import 'package:exam_app/config/base/base_state.dart';
import 'package:exam_app/core/constant/app_string.dart';
import 'package:exam_app/core/theme/app_colors.dart';
import 'package:exam_app/feature/Home/domain/entity/subject_entity.dart';
import 'package:exam_app/feature/Home/presentation/exams/view/screens/exams_screen.dart';
import 'package:exam_app/feature/Home/presentation/subjects/view/widgets/search_text_field.dart';
import 'package:exam_app/feature/Home/presentation/subjects/view/widgets/subject_card.dart';
import 'package:exam_app/feature/Home/presentation/subjects/view_model/subject_event.dart';
import 'package:exam_app/feature/Home/presentation/subjects/view_model/subject_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}
class _ExploreScreenState extends State<ExploreScreen> {
  late final SubjectViewModel subjectViewModel = getIt<SubjectViewModel>();
  @override
  void initState() {
    super.initState();
    subjectViewModel.doEvent(GetAllSubject());
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
            AppString.survey,
            style: TextStyle(
              color: colors.blue[500],
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.15,
            ),
          ),
          SizedBox(height: 20.h),
          SearchTextField(hintText: AppString.search),
          SizedBox(height: 28.h),
          Text(
            AppString.browseBySubject,
            style: TextStyle(
              color: colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.15,
            ),
          ),
          SizedBox(height: 16.h),
          BlocBuilder<SubjectViewModel, BaseState<List<SubjectEntity>>>(
            bloc: subjectViewModel,
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.data != null) {
                final subjects = state.data!;

                return ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 10.h);
                  },
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: subjects.length,
                  itemBuilder: (context, index) {
                    final subject = subjects[index];
                    return SubjectCard(
                      title: subject.name,
                      icon: subject.icon,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ExamsScreen(
                              subjectId: subject.id,
                              subjectName: subject.name,
                              subjectIcon: subject.icon,
                            ),
                          ),
                        );
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
