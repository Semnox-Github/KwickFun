import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox_core/modules/game/model/model.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/widgets/buttons/flat_fill_button.dart';
import '../../provider/view_model/machine_selection_view_model.dart';

class GameMachineList extends ConsumerWidget {
  const GameMachineList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, ref) {
    GameMachineSelectionViewModel viewModel =
        ref.watch(GameMachineSelectionViewModel.provider);
    viewModel.context = context;
    return WillPopScope(
      onWillPop: () async {
        Modular.to.pop(context);
        return false;
      },
      child: SemnoxScaffold(
        appBar: SemnoxAppBar(
          title:
              // const SemnoxText(text: "Select Game Machine"),
              SemnoxSearchBox(properties: viewModel.gameField),
          // leading: InkWell(
          //   onTap: () => Modular.to.pushReplacementNamed("${AppRoutes.home}/"),
          //   child:
          //       SemnoxIcons.arrowLeft.toIcon(size: 40.mapToIdealWidth(context)),
          // ),
        ),
        body: Column(
          children: [
            Expanded(
              child: DataProviderBuilder<List<GameMachine>?>(
                  dataProvider: viewModel.gameMachineProvider.dataStream,
                  builder: (context, machines) {
                    return ListView.builder(
                        itemCount: machines?.length,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: SemnoxListTile(
                                onPressed: () {
                                  viewModel.toggleSelection(machines![i]);
                                },
                                // leading: SizedBox(
                                //   width: 30,
                                // ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30.mapToIdealWidth(context)),
                                title: SemnoxText.h6(
                                  text: machines![i].machineName,
                                ),
                                // subtitle: SemnoxText(text: machines[i].machineAddress),
                                trailing: Checkbox(
                                    activeColor: Theme.of(context).primaryColor,
                                    value: viewModel.isActive(machines[i]),
                                    onChanged: (_) {
                                      viewModel.toggleSelection(machines[i]);
                                    })),
                          );
                        });
                  }),
            ),
            viewModel.gameMachineProvider.dataStream.hasValue
                ? SemnoxFlatFillButton(
                    child: const SemnoxText.button(
                      text: "SAVE",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      await viewModel.savegamemachine();
                    },
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
