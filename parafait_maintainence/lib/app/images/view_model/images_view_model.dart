import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:parafait_maintainence/app/lookupRules/MaintainanceLookupsAndRulesBL.dart';
import 'package:parafait_maintainence/app/tasks/view_model/tasks_viewmodel.dart';
import 'package:parafait_maintainence/app/widget/elements/capture_picture.dart';
import 'package:parafait_maintainence/app/widget/elements/image_preview.dart';
import 'package:rxdart/streams.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/bl/image_bl.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/model/images_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/model/maintainence_service_dto.dart';
import 'package:semnox_core/utils/dataprovider/data_provider.dart';
import 'package:semnox_core/utils/dataprovider/data_state.dart';
import 'package:semnox_core/utils/message.dart';
import 'package:semnox_core/utils/utils.dart';

class ImageViewModel extends ChangeNotifier {
  static final provider =
      AutoDisposeChangeNotifierProviderFamily<ImageViewModel, CheckListData>(
    (ref, params) {
      return ImageViewModel(params.checkListDetailDTO, params.lookupvalue);
    },
  );

  final CheckListDetailDTO? _checkListDetailDTO;
  ExecutionContextDTO? _executionContextDTO;
  List<ImageDTO>? _imageDTOList;
  List<ImageDTO>? get getImageDTOList => _imageDTOList;
  MaintainanceLookupsAndRulesBL? maintainanceLookupsAndRulesRepository;
  final String? _lookupvalue;

  final DataProvider<bool> stateupdate = DataProvider<bool>(initial: false);
  ValueStream<DataState<bool>> get loadstates => stateupdate.dataStream;

  ImageViewModel(this._checkListDetailDTO, this._lookupvalue) {
    init();
  }

  void init() async {
    stateupdate.startLoading();
    _executionContextDTO =
        await ExecutionContextProvider().getExecutionContext();
    maintainanceLookupsAndRulesRepository =
        MaintainanceLookupsAndRulesBL(_executionContextDTO!);
    ImageListBL imageListBL = ImageListBL(_executionContextDTO!);
    Map<ImageSearchParameter, dynamic> imageSearchParameters = {
      ImageSearchParameter.SITEID: _executionContextDTO!.siteId,
      ImageSearchParameter.MAINTCHECKLISTDETAILID: _checkListDetailDTO != null
          ? _checkListDetailDTO!.maintChklstdetId
          : null,
      ImageSearchParameter.IMAGETYPE:
          await maintainanceLookupsAndRulesRepository
              ?.getimageTypeId(_lookupvalue),
    };
    _imageDTOList = await imageListBL.getimageDTOList(imageSearchParameters);
    stateupdate.updateData(true);
    notifyListeners();
  }

  Future<int> saveImage(BuildContext context, String fileName) async {
    int updated = -1;
    try {
      ImageDTO imageDTO = ImageDTO(
        imageId: -1,
        maintCheckListDetailId: _checkListDetailDTO!.maintChklstdetId,
        createdBy: _executionContextDTO!.loginId,
        guid: _checkListDetailDTO!.guid,
        imageFileName: fileName,
        imageType: await maintainanceLookupsAndRulesRepository
            ?.getimageTypeId(_lookupvalue),
        // imagePath: path,
        creationDate: DateFormat(Messages.default_date_time_format)
            .parse(DateTime.now().toString()),
        siteId: _executionContextDTO!.siteId,
        isActive: _checkListDetailDTO!.isActive,
        isChanged: _checkListDetailDTO!.isChanged,
        lastUpdatedBy: _checkListDetailDTO!.lastUpdatedBy,
        lastUpdatedDate: DateFormat(Messages.default_date_time_format)
            .parse(DateTime.now().toString()),
        synchStatus: _checkListDetailDTO!.synchStatus,
        masterEntityId: _checkListDetailDTO!.masterEntityId,
        serverSync: _checkListDetailDTO!.serverSync = false,
      );
      ImageBL imageBL = ImageBL.dto(_executionContextDTO!, imageDTO);
      updated = await imageBL.saveImage();
      if (updated > 0) {
        init();
      }
      return updated;
    } on Exception catch (exception) {
      Utils().showSemnoxDialog(context, exception.toString());
    } on Error catch (error) {
      Utils().showSemnoxDialog(context, error.toString());
    }
    return updated;
  }

  void showCamera(BuildContext context, ImageViewModel imageViewModel) async {
    final cameras = await availableCameras();
    final camera = cameras.first;
    // ignore: use_build_context_synchronously
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CapturePictureScreen(
          camera: camera,
          imageViewModel: imageViewModel,
        ),
      ),
    );
  }

  void showImagePreview(BuildContext context, String? path) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ImagePreview(
                imagePath: File(path!),
              )),
    );
  }
}
