import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parafait_maintainence/app/parafait_home/route/module.dart';
import 'package:semnox_core/widgets/elements/text.dart';
import 'package:semnox_core/widgets/elements/uihelper.dart';

class MaintServicePanel extends StatelessWidget {
  final menulist = [
    ["assets/icons/recent.svg", "Recent"],
    ["assets/icons/pending.svg", "Open"],
    ["assets/icons/closed.svg", "Resolved"],
    ["assets/icons/wip.svg", "Draft"],
    ["assets/icons/recent.svg", "Create SR"],
  ];

  MaintServicePanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SemnoxText.button(
                textScaleFactor: 0.8,
                text: 'SERVICE REQUEST',
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
                mainAxisSpacing: 6,
                crossAxisSpacing: 6),
            itemCount: menulist.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if (menulist[index][1] != "Create SR") {
                    Modular.to.pushNamed(HomeModule.srtab,
                        arguments: menulist[index][1]);
                  } else {
                    Modular.to.pushNamed(HomeModule.srcreate,
                        arguments: menulist[index][1]);
                  }
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
