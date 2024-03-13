import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/maintenance/task/model/task_dto.dart';
import 'package:semnox_core/utils/database/dataConstant.dart';
import 'package:semnox_core/utils/database/databaseHelper.dart';

class TaskDbHandler {
  late DatabaseHelper maintainanceDatabase;

  TaskDbHandler(ExecutionContextDTO executionContextDTO) {
    maintainanceDatabase = DatabaseHelper();
  }

  static final String CREATE_TASK_TABLE =
      "CREATE TABLE IF NOT EXISTS ${DatabaseTableName.TABLE_TASK}(${DataConstColumnName.COLUMN_ID} integer primary key, ${DataConstColumnName.COLUMN_JOBTASKID} integer, ${DataConstColumnName.COLUMN_TASK_NAME} text, ${DataConstColumnName.COLUMN_MAINT_TASK_GROUP_ID} integer, ${DataConstColumnName.COLUMN_VALID_TAG} INTEGER DEFAULT 0, ${DataConstColumnName.COLUMN_CARD_NUMBER} text, ${DataConstColumnName.COLUMN_CARD_ID} integer, ${DataConstColumnName.COLUMN_REMARKS_MANDATORY} INTEGER DEFAULT 0, ${DataConstColumnName.COLUMN_ISACTIVE} INTEGER DEFAULT 0, ${DataConstColumnName.COLUMN_CREATED_BY} text, ${DataConstColumnName.COLUMN_CREATED_DATE} DATETIME, ${DataConstColumnName.COLUMN_LASTUPDATEDBY} text, ${DataConstColumnName.COLUMN_LASTUPDATEDDATE} DATETIME, ${DataConstColumnName.COLUMN_GUID} text, ${DataConstColumnName.COLUMN_SITEID} integer, ${DataConstColumnName.COLUMN_SYNCHSTATUS} INTEGER DEFAULT 0, ${DataConstColumnName.COLUMN_MASTERENTITYID} integer, ${DataConstColumnName.COLUMN_ISCHANGED} INTEGER DEFAULT 0, ${DataConstColumnName.COLUMN_SERVERSYNC} INTEGER DEFAULT 0, ${DataConstColumnName.COLUMN_SERVERSYNCTIME} DATETIME, ${DataConstColumnName.COLUMN_APPLASTUPDATEDTIME} DATETIME, ${DataConstColumnName.COLUMN_APPLASTUPDATEDBY} text)";

  static Map<dynamic, String> dbSearchParameters = {
    TaskDTOSearchParameter.ISACTIVE: DataConstColumnName.COLUMN_ISACTIVE,
    TaskDTOSearchParameter.SITEID: DataConstColumnName.COLUMN_SITEID,
  };

  String SELECT_QUERY = "SELECT * FROM ${DatabaseTableName.TABLE_TASK}";

  Future<int> insertTask(TaskDto taskdto) async {
    try {
      var dbClient = await maintainanceDatabase.database;
      var sqlstate =
          dbClient.insert(DatabaseTableName.TABLE_TASK, taskdto.toMap());
      return sqlstate;
    } on Exception catch (e) {
      print(e);
      return -1;
    } catch (error) {
      print(error);
      return -1;
    }
  }

  Future<int> updateTask(TaskDto taskdto) async {
    try {
      var dbClient = await maintainanceDatabase.database;
      var sqlstate = await dbClient.update(
          DatabaseTableName.TABLE_TASK, taskdto.toMap(),
          where: "${DataConstColumnName.COLUMN_JOBTASKID} = ?",
          whereArgs: [taskdto.jobTaskId]);
      return sqlstate;
    } on Exception catch (e) {
      print(e);
      return -1;
    } catch (error) {
      print(error);
      return -1;
    }
  }

  Future<List<TaskDto>> getTaskDTOList(
      Map<TaskDTOSearchParameter, dynamic> searchParameter) async {
    var dbClient = await maintainanceDatabase.database;
    // traverse through the params
    // build query
    String selectQuery = SELECT_QUERY;
    selectQuery += getFilterQuery(searchParameter);
    final result = await dbClient.rawQuery(selectQuery);
    return result.map((json) => TaskDto.fromMap(json)).toList();
  }

  String getFilterQuery(Map<TaskDTOSearchParameter, dynamic> searchParameters) {
    int count = 0;
    StringBuffer query = StringBuffer();
    if ((searchParameters.isNotEmpty)) {
      String joiner;
      searchParameters.forEach((key, value) {
        joiner = count == 0 ? " where " : " and ";
        if (dbSearchParameters.containsKey(key)) {
          if (key == TaskDTOSearchParameter.SITEID) {
            query.write(
                "$joiner(${dbSearchParameters[key]}=${searchParameters[key]} or ${searchParameters[key]}=-1) ");
          }
          count++;
        }
      });
    }
    return query.toString();
  }
}
