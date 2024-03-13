import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/maintenance/task_group/model/task_group_dto.dart';
import 'package:semnox_core/modules/maintenance/task_group/model/taskgroupsummary_dto.dart';
import 'package:semnox_core/utils/database/dataConstant.dart';
import 'package:semnox_core/utils/database/databaseHelper.dart';

class TaskGroupDbHandler {
  late DatabaseHelper maintainanceDatabase;
  late ExecutionContextDTO _executionContextDTO;
  var sqlstate;
  TaskGroupDbHandler(ExecutionContextDTO executionContextDTO) {
    maintainanceDatabase = DatabaseHelper();
    _executionContextDTO = executionContextDTO;
  }

  static final String CREATE_TASK_GROUP_TABLE =
      "CREATE TABLE IF NOT EXISTS ${DatabaseTableName.TABLE_TASKGROUP}(${DataConstColumnName.COLUMN_ID} integer primary key, ${DataConstColumnName.COLUMN_TASK_GROUP_NAME} text, ${DataConstColumnName.COLUMN_MAINT_TASK_GROUP_ID} integer, ${DataConstColumnName.COLUMN_MASTERENTITYID} integer, ${DataConstColumnName.COLUMN_ISACTIVE} INTEGER DEFAULT 0, ${DataConstColumnName.COLUMN_CREATED_BY} text, ${DataConstColumnName.COLUMN_CREATED_DATE} DATETIME, ${DataConstColumnName.COLUMN_LASTUPDATEDUSER} text, ${DataConstColumnName.COLUMN_LASTUPDATEDDATE} DATETIME, ${DataConstColumnName.COLUMN_GUID} text, ${DataConstColumnName.COLUMN_SITEID} integer, ${DataConstColumnName.COLUMN_SYNCHSTATUS} INTEGER DEFAULT 0, ${DataConstColumnName.COLUMN_ISCHANGED} INTEGER DEFAULT 0, ${DataConstColumnName.COLUMN_SERVERSYNC} INTEGER DEFAULT 0, ${DataConstColumnName.COLUMN_SERVERSYNCTIME} DATETIME, ${DataConstColumnName.COLUMN_APPLASTUPDATEDTIME} DATETIME, ${DataConstColumnName.COLUMN_APPLASTUPDATEDBY} text)";

  static Map<dynamic, String> dbSearchParameters = {
    TaskGroupsDTOSearchParameter.ISACTIVE: DataConstColumnName.COLUMN_ISACTIVE,
    TaskGroupsDTOSearchParameter.SITEID: DataConstColumnName.COLUMN_SITEID,
  };

  String SELECT_QUERY = "SELECT * FROM ${DatabaseTableName.TABLE_TASKGROUP}";

  Future<int> insertTaskGroup(TaskGroupsDTO taskGroupsDTO) async {
    try {
      var dbClient = await maintainanceDatabase.database;
      sqlstate = dbClient.insert(
          DatabaseTableName.TABLE_TASKGROUP, taskGroupsDTO.toMap());
      return sqlstate;
    } on Exception catch (e) {
      print(e);
      return -1;
    } catch (error) {
      print(error);
      return -1;
    }
  }

  Future<int> updateTaskGroup(TaskGroupsDTO taskGroupsDTO) async {
    try {
      var dbClient = await maintainanceDatabase.database;
      sqlstate = await dbClient.update(
          DatabaseTableName.TABLE_TASKGROUP, taskGroupsDTO.toMap(),
          where: "${DataConstColumnName.COLUMN_MAINT_TASK_GROUP_ID} = ?",
          whereArgs: [taskGroupsDTO.jobTaskGroupId]);
      return sqlstate;
    } on Exception catch (e) {
      print(e);
      return -1;
    } catch (error) {
      print(error);
      return -1;
    }
  }

  Future<List<TaskGroupsDTO>> getTaskGroupsList(
      Map<TaskGroupsDTOSearchParameter, dynamic> searchParameter) async {
    var dbClient = await maintainanceDatabase.database;
    String selectQuery = SELECT_QUERY;
    selectQuery += getFilterQuery(searchParameter);
    final result = await dbClient.rawQuery(selectQuery);
    return result.map((json) => TaskGroupsDTO.fromMap(json)).toList();
  }

  String getFilterQuery(
      Map<TaskGroupsDTOSearchParameter, dynamic> searchParameters) {
    int count = 0;
    StringBuffer query = StringBuffer();
    if ((searchParameters.isNotEmpty)) {
      String joiner;
      searchParameters.forEach((key, value) {
        joiner = count == 0 ? " where " : " and ";
        if (dbSearchParameters.containsKey(key)) {
          if (key == TaskGroupsDTOSearchParameter.SITEID) {
            query.write(
                "$joiner(${dbSearchParameters[key]}=${searchParameters[key]} or ${searchParameters[key]}=-1) ");
          }
          count++;
        }
      });
    }
    return query.toString();
  }

  Future<List<TaskGroupViewSummaryDTO>>? getTaskGroupSummaryDTO(
      Map<TaskGroupSummaryDTOSearchParameter, dynamic> searchParameter) async {
    var dbClient = await maintainanceDatabase.database;
    String selectQuery =
        "select COALESCE(TableAlltask.TaskGroupName,'Others') as TaskGroupName,TableAlltask.TaskGroupId,TableAlltask.TaskTotal,COALESCE(TablePending.TaskPending,0) as TaskPending From((select TaskGroupName,COALESCE(t.JobTaskGroupId,-1) as TaskGroupId,c.Status,count(*) as TaskTotal from CheckListDetail c left outer join Maint_Tasks t on c.JobTaskId = t.JobTaskId left outer join Maint_TaskGroups g on t.JobTaskGroupId = g.JobTaskGroupId Where DATE(c.ChklstScheduleTime) = DATE('${searchParameter[TaskGroupSummaryDTOSearchParameter.CHKLSTSCHEDULETIME]}') AND c.AssignedUserId = ${searchParameter[TaskGroupSummaryDTOSearchParameter.ASSIGNEDUSERID]} AND c.MaintJobType = ${searchParameter[TaskGroupSummaryDTOSearchParameter.MAINTJOBTYPE]} GROUP by g.JobTaskGroupId) as TableAlltask LEFT JOIN(select COALESCE(g.JobTaskGroupId,-1) as TaskGroupId,count(*) as TaskPending from CheckListDetail c left outer join Maint_Tasks t on c.JobTaskId = t.JobTaskId left outer join Maint_TaskGroups g on t.JobTaskGroupId = g.JobTaskGroupId where c.Status!= ${searchParameter[TaskGroupSummaryDTOSearchParameter.STATUS]} AND DATE(c.ChklstScheduleTime) = DATE('${searchParameter[TaskGroupSummaryDTOSearchParameter.CHKLSTSCHEDULETIME]}') AND c.AssignedUserId = ${searchParameter[TaskGroupSummaryDTOSearchParameter.ASSIGNEDUSERID]} AND c.MaintJobType = ${searchParameter[TaskGroupSummaryDTOSearchParameter.MAINTJOBTYPE]} GROUP by TaskGroupId) as TablePending on TableAlltask.TaskGroupId = TablePending.TaskGroupId)";
    print(selectQuery);
    final result = await dbClient.rawQuery(selectQuery);
    return result.map((json) => TaskGroupViewSummaryDTO.fromMap(json)).toList();
  }
}
