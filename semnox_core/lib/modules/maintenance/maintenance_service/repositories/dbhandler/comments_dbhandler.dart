import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/model/comments_dto.dart';
import 'package:semnox_core/utils/database/dataConstant.dart';
import 'package:semnox_core/utils/database/databaseHelper.dart';

class CommentsDbHandler {
  late DatabaseHelper maintainanceDatabase;
  var sqlstate;

  CommentsDbHandler(ExecutionContextDTO executionContext) {
    maintainanceDatabase = DatabaseHelper();
  }

  //MaintenanceChecklistTable

  static final String CREATE_COMMENTS_TABLE = "CREATE TABLE IF NOT EXISTS " +
      DatabaseTableName.TABLE_COMMENTS +
      "(" +
      DataConstColumnName.COLUMN_LOCAL_COMMENT_ID +
      " integer primary key," +
      DataConstColumnName.COLUMN_COMMENT_ID +
      " integer, " +
      DataConstColumnName.COLUMN_MAINT_CHECKLIST_DETAILS_ID +
      " integer, " +
      DataConstColumnName.COLUMN_COMMENTTYPE +
      " integer, " +
      DataConstColumnName.COLUMN_COMMENT_FOR_COMMENTS_TABLE +
      " text, " +
      DataConstColumnName.COLUMN_MASTERENTITYID +
      " integer, " +
      DataConstColumnName.COLUMN_ISACTIVE +
      " INTEGER DEFAULT 0, " +
      DataConstColumnName.COLUMN_CREATED_BY +
      " text, " +
      DataConstColumnName.COLUMN_CREATED_DATE +
      " DATETIME, " +
      DataConstColumnName.COLUMN_LASTUPDATEDBY +
      " text, " +
      DataConstColumnName.COLUMN_LASTUPDATEDDATE +
      " DATETIME, " +
      DataConstColumnName.COLUMN_GUID +
      " text, " +
      DataConstColumnName.COLUMN_SITEID +
      " text, " +
      DataConstColumnName.COLUMN_SYNCHSTATUS +
      " INTEGER DEFAULT 0, " +
      DataConstColumnName.COLUMN_ISCHANGED +
      " INTEGER DEFAULT 0, " +
      DataConstColumnName.COLUMN_SERVERSYNC +
      " INTEGER DEFAULT 0, " +
      DataConstColumnName.COLUMN_SERVERSYNCTIME +
      " DATETIME, " +
      DataConstColumnName.COLUMN_APPLASTUPDATEDTIME +
      " DATETIME, " +
      DataConstColumnName.COLUMN_APPLASTUPDATEDBY +
      " text)";

  static final List<String> values = [
    /// Add all fields
    DataConstColumnName.COLUMN_COMMENT_ID
  ];

  static Map<dynamic, String> dbSearchParameters = {
    CommentsSearchParameter.SITEID: DataConstColumnName.COLUMN_SITEID,
    CommentsSearchParameter.MAINTCHECKLISTDETAILID:
        DataConstColumnName.COLUMN_MAINT_CHECKLIST_DETAILS_ID,
    CommentsSearchParameter.LASTUPDATEDDATE:
        DataConstColumnName.COLUMN_LASTUPDATEDDATE,
    CommentsSearchParameter.SERVERSYNC: DataConstColumnName.COLUMN_SERVERSYNC,
  };

  String SELECT_QUERY = "SELECT * FROM ${DatabaseTableName.TABLE_COMMENTS} ";

  Future<int> insertCommentTable(CommentsDTO commentsDTO) async {
    try {
      var dbClient = await maintainanceDatabase.database;

      sqlstate = dbClient.insert(
          DatabaseTableName.TABLE_COMMENTS, commentsDTO.toMap());

      // var queryResult = await dbClient.query(
      //   DatabaseTableName.TABLE_COMMENTS,
      //   columns: values,
      //   where: '${DataConstColumnName.COLUMN_COMMENT_ID} = ?',
      //   whereArgs: [commentsDTO.commentId],
      // );

      // if (queryResult.isEmpty) {
      //   sqlstate = dbClient.insert(
      //       DatabaseTableName.TABLE_COMMENTS, commentsDTO.toMap());
      // }
      return sqlstate;
    } on Exception {
      rethrow;
    } on Error {
      rethrow;
    }
  }

  // Future<int> insertComment(CommentsDTO commentsDTO) async {
  //   try {
  //     var dbClient = await maintainanceDatabase.database;

  //     sqlstate = dbClient.insert(
  //         DatabaseTableName.TABLE_COMMENTS, commentsDTO.toMap());

  //     return sqlstate;
  //   } on Exception catch (exception) {
  //     throw exception;
  //   } on Error catch (error) {
  //     throw error;
  //   }
  // }

  Future<int> updateCommentTable(CommentsDTO commentsDTO) async {
    try {
      var dbClient = await maintainanceDatabase.database;
      sqlstate = await dbClient.update(
          DatabaseTableName.TABLE_COMMENTS, commentsDTO.toMap(),
          where: "${DataConstColumnName.COLUMN_LOCAL_COMMENT_ID} = ?",
          whereArgs: [commentsDTO.localcommentId]);
      return sqlstate;
    } on Exception catch (e) {
      print(e);
      return -1;
    } catch (error) {
      print(error);
      return -1;
    }
  }

  Future<List<CommentsDTO>> getCommentList(
      Map<CommentsSearchParameter, dynamic> commentSearchParams) async {
    try {
      var dbClient = await maintainanceDatabase.database;
      String selectQuery = SELECT_QUERY;
      selectQuery += getFilterQuery(commentSearchParams);
      print(selectQuery);
      final result = await dbClient.rawQuery(
          "$selectQuery Order By ${DataConstColumnName.COLUMN_LASTUPDATEDDATE} DESC");

      return result.map((json) => CommentsDTO.fromMap(json)).toList();
    } on Exception {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  String getFilterQuery(
      Map<CommentsSearchParameter, dynamic> commentSearchParams) {
    int count = 0;
    StringBuffer query = StringBuffer();
    if ((commentSearchParams.isNotEmpty)) {
      String joiner;
      commentSearchParams.forEach((key, value) {
        joiner = count == 0 ? "where" : " and ";
        if (dbSearchParameters.containsKey(key)) {
          if (key == CommentsSearchParameter.SITEID) {
            query.write(
                "$joiner(${dbSearchParameters[key]}=${commentSearchParams[key]} or ${commentSearchParams[key]}=-1) ");
          } else if (key == CommentsSearchParameter.MAINTCHECKLISTDETAILID) {
            query.write(
                "$joiner(${dbSearchParameters[key]}=${commentSearchParams[key]}) ");
          } else if (key == CommentsSearchParameter.SERVERSYNC) {
            query.write(
                "$joiner(${dbSearchParameters[key]}=${commentSearchParams[key]}) ");
          }
          count++;
        }
      });
    }
    return query.toString();
  }
}
