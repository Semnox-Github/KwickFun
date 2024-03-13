import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logger/logger.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/model/comments_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/repositories/dbhandler/comments_dbhandler.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/repositories/request/comments_service.dart';

class CommentRepositories {
  CommentService? _commentService;
  ExecutionContextDTO? _executionContext;

  CommentRepositories(ExecutionContextDTO executionContext) {
    _executionContext = executionContext;
    _commentService = CommentService(_executionContext!);
  }

  Future<List<CommentsDTO>> getcommentDTOList(
      Map<CommentsSearchParameter, dynamic> searchparams) async {
    CommentsDbHandler commentsDbHandler = CommentsDbHandler(_executionContext!);
    return await commentsDbHandler.getCommentList(searchparams);
  }

  Future<int> postCommenttDto(CommentsDTO commentsDTO,
      Map<CommentsSearchParameter, dynamic> postsearchparams) async {
    final result = await Connectivity().checkConnectivity();
    if (result.name != "none") {
      print('Connected to a network');
      try {
        List<CommentsDTO> serverCommentDTOList = await _commentService!
            .postCommentDTOList(commentsDTO, postsearchparams);
        if (serverCommentDTOList.isNotEmpty) {
          for (var dto in serverCommentDTOList) {
            commentsDTO.RefreshServerValues(dto);
            int value = await CommentsDbHandler(_executionContext!)
                .updateCommentTable(commentsDTO);
            if (value != -1) {
              return value;
            }
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      print('No Connection');
    }
    return -1;
  }

  Future<int> saveComments(CommentsDTO commentsDTO) async {
    return await CommentsDbHandler(_executionContext!)
        .insertCommentTable(commentsDTO);
  }

  Future<List<CommentsDTO>> getcommentfromserver(int? maintChklstdetId) async {
    // int updatedCount = 0, insertedCount = 0;
    late List<CommentsDTO> localcommentDTOList;
    CommentsDbHandler commentsDbHandler = CommentsDbHandler(_executionContext!);

    Map<CommentsSearchParameter, dynamic> searchparams = {
      CommentsSearchParameter.SITEID: _executionContext!.siteId,
      CommentsSearchParameter.ISACTIVE: 1,
    };

    final result = await Connectivity().checkConnectivity();
    if (result.name != "none") {
      print('Connected to a network');

      CommentService commentRequest = CommentService(_executionContext!);
      List<CommentsDTO> servercommentDTOList =
          await commentRequest.getCommentDTOList(maintChklstdetId);

      if (servercommentDTOList.isNotEmpty) {
        localcommentDTOList =
            await commentsDbHandler.getCommentList(searchparams);
        for (var element in servercommentDTOList) {
          bool insertElement = false;
          if (localcommentDTOList.isEmpty) {
            insertElement = true;
          } else {
            var contain = localcommentDTOList
                .where((e) => e.commentId == element.commentId);

            if (contain.isEmpty) {
              //value not exists
              insertElement = true;
            } else {
              //value exists
              CommentsDTO coomentlistdto = contain.first;
              if (element.lastUpdatedDate != coomentlistdto.lastUpdatedDate) {
                coomentlistdto.RefreshServerValues(element);

                Logger().d('''
              ${"*" * 10}
              Entity: "COMMENT GET" : Start Time: ${DateTime.now()}
              Total Count: ${servercommentDTOList.length},
              Maint_chklstID : $maintChklstdetId,
              ${"*" * 10}
              ''');

                int result =
                    await commentsDbHandler.updateCommentTable(coomentlistdto);

                if (result != -1) {
                  Logger().d('''
              ${"*" * 10}
              Entity: "COMMENT GET" : End Time: ${DateTime.now()}
              Updated Count to DB : ${servercommentDTOList.length}
              Maint_chklstID : $maintChklstdetId,
              ${"*" * 10}
              ''');
                }
              }
            }
          }
          if (insertElement == true) {
            // insert object
            CommentsDTO commentsDTO = CommentsDTO();
            commentsDTO.RefreshServerValues(element);

            Logger().d('''
              ${"*" * 10}
              Entity: "COMMENT GET" : Start Time: ${DateTime.now()}
              Total Count: ${servercommentDTOList.length},
              Maint_chklstID : $maintChklstdetId,
              ${"*" * 10}
              ''');

            int result =
                await commentsDbHandler.insertCommentTable(commentsDTO);

            if (result != -1) {
              Logger().d('''
              ${"*" * 10}
              Entity: "COMMENT GET" : End Time: ${DateTime.now()}
              Inserted Count to DB : ${servercommentDTOList.length}
              Maint_chklstID : $maintChklstdetId,
              ${"*" * 10}
              ''');
            }
          }
        }
      }
    }
    print('Fetch data from local');
    localcommentDTOList = await commentsDbHandler.getCommentList(searchparams);
    return localcommentDTOList;
  }
}
