import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parafait_maintainence/app/parafait_home/route/module.dart';
import 'package:parafait_maintainence/app/parafait_home/view/parafait_homescreen.dart';
import 'package:parafait_maintainence/app/parafait_home/view_model/sync_view_model.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/utils.dart';
import 'package:semnox_core/widgets/buttons/semnox_circle_loader.dart';

class SyncLayout extends ConsumerWidget {
  const SyncLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(SyncViewmodel.provider);
    return StreamBuilder<SyncData>(
        stream: viewmodel.uploadanddownload?.fromserverstream,
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

          return Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SemnoxText.bodyMed1(
                          textScaleFactor: 0.6,
                          text: snapshot.data!.percent! < 100
                              ? 'Syncing'
                              : 'Syncing Completed',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20.mapToIdealHeight(context),
                        ),
                        GestureDetector(
                          child: SemnoxText.bodyMed1(
                            textScaleFactor: 0.6,
                            text: snapshot.data!.percent! < 100
                                ? 'Your device is syncing \n with the server....'
                                : 'Your device is sync completed',
                          ),
                          onTap: () {},
                        ),
                        SizedBox(
                          height: 40.mapToIdealHeight(context),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 1,
                              child: GestureDetector(
                                child: const SemnoxText.subtitle(
                                  textScaleFactor: 0.5,
                                  text: "VIEW DETAILS",
                                  style: TextStyle(
                                    color: Color.fromRGBO(164, 66, 54, 1),
                                  ),
                                ),
                                onTap: () {
                                  Modular.to.pushNamed(
                                      "./${HomeModule.syncdetails}",
                                      arguments: viewmodel);
                                },
                              ),
                            ),
                            SizedBox(
                              width: 20.mapToIdealHeight(context),
                            ),
                            const SemnoxText.subtitle(
                              textScaleFactor: 0.5,
                              text: "|",
                              style: TextStyle(
                                color: Color.fromRGBO(170, 170, 170, 1),
                              ),
                            ),
                            SizedBox(
                              width: 20.mapToIdealHeight(context),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (snapshot.data!.percent! == 100) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ParafaitHomeScreen()),
                                  );
                                }
                              },
                              child: SemnoxText.subtitle(
                                textScaleFactor: 0.5,
                                text: snapshot.data!.percent! < 100
                                    ? "STOP SYNC"
                                    : "SYNC AGAIN",
                                style: const TextStyle(
                                  color: Color.fromRGBO(164, 66, 54, 1),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    snapshot.data!.percent! < 100
                        ? CircularPercentIndicator(
                            radius: 50.0,
                            lineWidth: 5.0,
                            animation: false,
                            percent: snapshot.data!.percent! / 100,
                            center: SemnoxText.subtitle(
                              text: "${snapshot.data!.percent!}%",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            backgroundColor:
                                const Color.fromRGBO(238, 240, 240, 1),
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: snapshot.data!.percent! < 100
                                ? const Color.fromRGBO(238, 134, 100, 1)
                                : const Color.fromRGBO(103, 190, 122, 1),
                          )
                        : Container()
                  ],
                ),
              ),
            ),
          );
        });
  }
}
