import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parafait_maintainence/app/parafait_home/view_model/pendingActionViewModel.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/bl/maintainence_bl.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/screen_utils/uihelper.dart';
import 'package:semnox_core/widgets/buttons/semnox_circle_loader.dart';

// ignore: must_be_immutable
class PendingActionLayout extends ConsumerWidget {
  Color? color;
  PendingActionLayout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(PendingActionViewModel.provider);
    return StreamBuilder<ActionCount?>(
        stream: viewmodel.streamController,
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
          if (snapshot.data?.percent != 0.0) {
            color =
                snapshot.data!.percent >= 0.61 && snapshot.data!.percent <= 0.95
                    ? const Color.fromRGBO(240, 163, 10, 1)
                    : snapshot.data!.percent > 0.95
                        ? const Color.fromRGBO(103, 190, 122, 1)
                        : const Color.fromRGBO(238, 134, 100, 1);

            return CustomPaint(
              painter: MyPainter(),
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircularPercentIndicator(
                      radius: 50.0,
                      lineWidth: 5.0,
                      animation: true,
                      percent: snapshot.data!.percent / 100,
                      center: SemnoxText.button(
                        text:
                            "${snapshot.data!.pendingcount.round()} / ${snapshot.data!.totalcount.round()}",
                      ),
                      backgroundColor: const Color.fromRGBO(238, 240, 240, 1),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: viewmodel.color,
                    ),
                    UIHelper.horizontalSpaceMedium(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SemnoxText.bodyMed1(
                          textScaleFactor: 0.7,
                          text: 'Pending Action Items',
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          child: const SemnoxText.bodyMed1(
                            textScaleFactor: 0.6,
                            text: 'Tap here to check them \n out',
                          ),
                          onTap: () {
                            viewmodel.navigatetopendinglayout();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
