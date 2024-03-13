import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/model/comments_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/repositories/comments_repositories.dart';

class CommentsBL {
  CommentsDTO? _commentsDTO;
  ExecutionContextDTO? _executionContext;
  CommentRepositories? _commentsRepositories;
  int? _id;

  CommentsBL.id(ExecutionContextDTO executionContext, int? id) {
    _id = id;
    _executionContext = executionContext;
    _commentsRepositories = CommentRepositories(_executionContext!);
  }

  CommentsBL.dto(
      ExecutionContextDTO executionContext, CommentsDTO commentsDTO) {
    _executionContext = executionContext;
    _commentsDTO = commentsDTO;
    _commentsRepositories = CommentRepositories(_executionContext!);
  }

  Future<int> postCommentDTo(
      Map<CommentsSearchParameter, dynamic> postsearchparams) async {
    int? result = await _commentsRepositories!
        .postCommenttDto(_commentsDTO!, postsearchparams);
    return result;
  }

  Future<int> saveComments() async {
    return await _commentsRepositories!.saveComments(_commentsDTO!);
  }
}

class CommentsListBL {
  late ExecutionContextDTO _executionContext;
  CommentsListBL(ExecutionContextDTO executionContext) {
    _executionContext = executionContext;
  }

  Future<List<CommentsDTO>> getcommentDTOList(
      Map<CommentsSearchParameter, dynamic> searchparams) async {
    return await CommentRepositories(_executionContext)
        .getcommentDTOList(searchparams);
  }
}
