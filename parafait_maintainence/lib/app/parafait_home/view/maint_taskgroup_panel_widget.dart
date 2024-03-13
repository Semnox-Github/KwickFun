import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parafait_maintainence/app/parafait_home/view_model/taskgroup_viewmodel.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:semnox_core/modules/maintenance/task_group/model/taskgroupsummary_dto.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/widgets/buttons/semnox_circle_loader.dart';

class TaskGroupLayout extends ConsumerWidget {
  const TaskGroupLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(TaskGroupViewModel.provider);
    return StreamBuilder<List<TaskGroupViewSummaryDTO>?>(
        stream: viewmodel.taskgroupsummaryController,
        initialData: const [],
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 20,
            );
          }
          if (!snapshot.hasData) {
            return const Center(
                child: SemnoxCircleLoader(
              color: Colors.red,
            ));
          }
          return snapshot.data!.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SemnoxText.button(
                      textScaleFactor: 0.8,
                      text: 'TASKS GROUPS',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      height: 20.mapToIdealHeight(context),
                    ),
                    SizedBox(
                      height: 160,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            var percent = (snapshot.data![index].taskpending!
                                        .toInt() /
                                    snapshot.data![index].tasktotal!.toInt()) *
                                100;
                            Color color = percent >= 61 && percent <= 95
                                ? const Color.fromRGBO(240, 163, 10, 1)
                                : percent > 95
                                    ? const Color.fromRGBO(103, 190, 122, 1)
                                    : const Color.fromRGBO(238, 134, 100, 1);
                            return InkWell(
                                onTap: () {
                                  viewmodel.navigatetopendinglayout(
                                      snapshot.data?[index].taskgroupId);
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      child: CircularPercentIndicator(
                                        radius: 50.0,
                                        lineWidth: 5.0,
                                        animation: true,
                                        percent: (snapshot
                                                    .data![index].taskpending!
                                                    .toInt() /
                                                snapshot.data![index].tasktotal!
                                                    .toInt()) /
                                            100,
                                        center: SemnoxText.button(
                                          textScaleFactor: 0.6,
                                          text:
                                              "${snapshot.data?[index].taskpending.toString()}"
                                              "/"
                                              "${snapshot.data?[index].tasktotal.toString()}",
                                        ),
                                        backgroundColor: const Color.fromRGBO(
                                            238, 240, 240, 1),
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
                                        progressColor: color,
                                        footer: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: SemnoxText.button(
                                            textScaleFactor: 0.6,
                                            maxLines: 2,
                                            softWrap: true,
                                            textAlign: TextAlign.center,
                                            text: snapshot
                                                .data![index].taskgroupname
                                                .toString(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ));
                          }),
                    ),
                  ],
                )
              : Container();
        });
  }
}
