import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/streams.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/modules/hr/model/user_container_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/bl/comments_bl.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/model/comments_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/model/maintainence_service_dto.dart';
import 'package:semnox_core/utils/dataprovider/data_provider.dart';
import 'package:semnox_core/utils/dataprovider/data_state.dart';
import 'package:semnox_core/utils/message.dart';
import 'package:semnox_core/utils/utils.dart';

class CommentsViewModel extends ChangeNotifier {
  static final provider = AutoDisposeChangeNotifierProviderFamily<
      CommentsViewModel, CheckListDetailDTO>(
    (ref, checkListDetailDTO) {
      return CommentsViewModel(checkListDetailDTO);
    },
  );

  final CheckListDetailDTO? _checkListDetailDTO;
  ExecutionContextDTO? _executionContextDTO;
  List<CommentsDTO>? commentsListDto;
  List<CommentsDTO>? get getservicerequestcommentDTOList => commentsListDto;
  final TextEditingController commentsTextController = TextEditingController();

  final DataProvider<bool> stateupdate = DataProvider<bool>(initial: false);
  ValueStream<DataState<bool>> get loadstates => stateupdate.dataStream;

  CommentsViewModel(this._checkListDetailDTO) {
    init();
  }

  void init() async {
    stateupdate.startLoading();
    _executionContextDTO =
        await ExecutionContextProvider().getExecutionContext();
    CommentsListBL commentsListBL = CommentsListBL(_executionContextDTO!);

    Map<CommentsSearchParameter, dynamic> commentsSearchParams = {
      CommentsSearchParameter.SITEID: _executionContextDTO!.siteId,
      CommentsSearchParameter.MAINTCHECKLISTDETAILID:
          _checkListDetailDTO!.maintChklstdetId,
    };

    commentsListDto =
        await commentsListBL.getcommentDTOList(commentsSearchParams);
    stateupdate.updateData(true);
    notifyListeners();
  }

  String getUserNameFromLoginId(
      List<UserContainerDto>? usersDTOList, String? lognId) {
    int userIdIndex =
        usersDTOList!.indexWhere((element) => element.loginId == lognId);
    String? empUserName = usersDTOList[userIdIndex].userName;
    return empUserName.toString();
  }

  String changeDateAndTimeForCommentsCard(String commentCreatedDateTime) {
    var tempDateAndTimeArray = commentCreatedDateTime.split(" ");
    var time = tempDateAndTimeArray[1].split(":");
    String hour = time[0];
    String minutes = time[1];
    String timeInMinutesAndSeconds = "$hour:$minutes";
    String date = DateFormat("dd MMM yyyy - HH:mm a").format(
        DateTime.parse("${tempDateAndTimeArray[0]} $timeInMinutesAndSeconds"));
    // String time = DateFormat("hh:mm").parse(tempDateAndTimeArray[1]).toString();
    return "$date  "; // + tempDateAndTimeArray[1];
  }

  void saveComments(CommentsViewModel viewModel, BuildContext context) async {
    if (commentsTextController.text.isEmpty) {
      Utils().showSemnoxDialog(
          context, "Comment field is empty,please enter comments");
      return;
    }
    int commentUpdatedStatus =
        await viewModel.saveCommentsForSR(commentsTextController.text, context);
    if (commentUpdatedStatus > 0) {
      FocusScope.of(context).unfocus();
      commentsTextController.text = "";
    }
  }

  Future<int> saveCommentsForSR(String comments, BuildContext context) async {
    int updated = -1;
    try {
      CommentsDTO commentsDTO = CommentsDTO(
        commentId: -1,
        maintCheckListDetailId: _checkListDetailDTO!.maintChklstdetId,
        comment: comments,
        commentType: _checkListDetailDTO!.maintJobType,
        createdBy: _executionContextDTO!.loginId,
        guid: _checkListDetailDTO!.guid,
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
      CommentsBL commentsBL =
          CommentsBL.dto(_executionContextDTO!, commentsDTO);
      updated = await commentsBL.saveComments();
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
}
