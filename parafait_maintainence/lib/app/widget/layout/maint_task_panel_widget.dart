import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parafait_maintainence/app/parafait_home/route/module.dart';
import 'package:semnox_core/widgets/elements/text.dart';
import 'package:semnox_core/widgets/elements/uihelper.dart';

class TaskPanel extends StatelessWidget {
  final menulist = [
    ["assets/icons/recent.svg", "Open"],
    ["assets/icons/pending.svg", "WFR"],
    ["assets/icons/wip.svg", "WIP"],
    ["assets/icons/closed.svg", "Closed"],
  ];

  TaskPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SemnoxText.button(
                textScaleFactor: 0.8,
                text: 'TASKS',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          UIHelper.verticalSpaceSmall(),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 120,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8),
            itemCount: menulist.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Modular.to.pushNamed(HomeModule.tasktab,
                      arguments: menulist[index][1]);
                },
                child: Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              stops: [0.1, 0.9],
                              colors: [
                                Color(0xFFEA9556),
                                Color(0xFFEB7075),
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SvgPicture.asset(menulist[index][0]),
                          ),
                        ),
                        UIHelper.verticalSpaceSmall(),
                        SemnoxText.button(
                          textScaleFactor: 0.6,
                          text: menulist[index][1],
                          style: const TextStyle(),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
