import 'dart:convert';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/bl/maintainence_bl.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/model/maintainence_service_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/module_service_layer.dart';
import 'package:semnox_core/utils/database/dataConstant.dart';
import 'package:semnox_core/utils/database/databaseHelper.dart';
import 'package:semnox_core/utils/storage_service/local_storage.dart';

class CheckListDetailDbHandler extends ModuleServiceLayer {
  late DatabaseHelper maintainanceDatabase;
  dynamic sqlstate;
  final String _storageKey = "checkListLastRefreshTime";
  int _dataLifeInMins = 60;

  CheckListDetailDbHandler(
      ExecutionContextDTO executionContext, int dataLifeInMins)
      : super(executionContext) {
    maintainanceDatabase = DatabaseHelper();
    _dataLifeInMins = dataLifeInMins;
  }

  static final String CREATE_CHECKLIST_TABLE =
      "CREATE TABLE IF NOT EXISTS ${DatabaseTableName.TABLE_CHECKLIST_DETAIL}(${DataConstColumnName.COLUMN_MAINT_CHECKLIST_DETAIL_ID} integer, ${DataConstColumnName.COLUMN_LOCAL_MAINT_CHECKLIST_DETAIL_ID} integer primary key, ${DataConstColumnName.COLUMN_JOB_SCHEDULE_ID} integer, ${DataConstColumnName.COLUMN_JOBTASKID} integer, ${DataConstColumnName.COLUMN_JOB_NAME} text, ${DataConstColumnName.COLUMN_JOB_TYPE} integer, ${DataConstColumnName.COLUMN_SCHEDULE_TIME} DATETIME, ${DataConstColumnName.COLUMN_ASSIGNED_TO} text, ${DataConstColumnName.COLUMN_ASSIGNED_USER_ID} integer, ${DataConstColumnName.COLUMN_DEPARTMENT_ID} integer, ${DataConstColumnName.COLUMN_JOB_STATUS} integer, ${DataConstColumnName.COLUMN_CLOSE_DATE} DATETIME, ${DataConstColumnName.COLUMN_TASK_NAME} text, ${DataConstColumnName.COLUMN_VALID_TAG} INTEGER DEFAULT 0, ${DataConstColumnName.COLUMN_CARD_ID} integer, ${DataConstColumnName.COLUMN_CARD_NUMBER} text, ${DataConstColumnName.COLUMN_TASK_CARDNUMBER} text, ${DataConstColumnName.COLUMN_REMARKS_MANDATORY} INTEGER DEFAULT 0, ${DataConstColumnName.COLUMN_ASSETID} integer, ${DataConstColumnName.COLUMN_ASSET_NAME} text, ${DataConstColumnName.COLUMN_ASSET_TYPE} text, ${DataConstColumnName.COLUMN_ASSETGROUPNAME} text, ${DataConstColumnName.COLUMN_CHECKLIST_VALUE} INTEGER DEFAULT 0, ${DataConstColumnName.COLUMN_CHECKLIST_REMARKS} text, ${DataConstColumnName.COLUMN_SOURCE_SYSTEMID} text, ${DataConstColumnName.COLUMN_DURATION_TO_COMPLETE} integer, ${DataConstColumnName.COLUMN_REQUEST_TYPE} integer, ${DataConstColumnName.COLUMN_REQUEST_DATE} DATETIME, ${DataConstColumnName.COLUMN_PRIORITY} integer, ${DataConstColumnName.COLUMN_REQUEST_DETAIL} text, ${DataConstColumnName.COLUMN_IMAGE_NAME} text, ${DataConstColumnName.COLUMN_REQUESTED_BY} text, ${DataConstColumnName.COLUMN_CONTACT_PHONE} text, ${DataConstColumnName.COLUMN_CONTACT_EMAIL} text, ${DataConstColumnName.COLUMN_RESOLUTION} text, ${DataConstColumnName.COLUMN_COMMENTS} text, ${DataConstColumnName.COLUMN_REPAIR_COST} double, ${DataConstColumnName.COLUMN_DOC_FILENAME} text, ${DataConstColumnName.COLUMN_ATTRIBUTE} text, ${DataConstColumnName.COLUMN_ISACTIVE} INTEGER DEFAULT 0, ${DataConstColumnName.COLUMN_CREATED_BY} text, ${DataConstColumnName.COLUMN_CREATED_DATE} DATETIME, ${DataConstColumnName.COLUMN_LASTUPDATEDBY} text, ${DataConstColumnName.COLUMN_LASTUPDATEDDATE} DATETIME, ${DataConstColumnName.COLUMN_GUID} text, ${DataConstColumnName.COLUMN_SITEID} text, ${DataConstColumnName.COLUMN_SYNCHSTATUS} INTEGER DEFAULT 0, ${DataConstColumnName.COLUMN_MASTERENTITYID} integer,${DataConstColumnName.COLUMN_BOOKINGID} integer, ${DataConstColumnName.COLUMN_BOOKINGCHECKLISTID} integer, ${DataConstColumnName.COLUMN_JOBSCHEDULETASKID} integer, ${DataConstColumnName.COLUMN_JOBNUMBER} text, ${DataConstColumnName.COLUMN_ISCHANGED} INTEGER DEFAULT 0, ${DataConstColumnName.COLUMN_ISCHANGEDRECURSIVE} INTEGER DEFAULT 0, ${DataConstColumnName.COLUMN_SERVERSYNC} INTEGER DEFAULT 0, ${DataConstColumnName.COLUMN_SERVERSYNCTIME} DATETIME, ${DataConstColumnName.COLUMN_APPLASTUPDATEDTIME} DATETIME, ${DataConstColumnName.COLUMN_APPLASTUPDATEDBY} text)";

  static Map<dynamic, String> dbSearchParameters = {
    CheckListDetailSearchParameter.ISACTIVE:
        DataConstColumnName.COLUMN_ISACTIVE,
    CheckListDetailSearchParameter.SITEID: DataConstColumnName.COLUMN_SITEID,
    CheckListDetailSearchParameter.PRIORITY:
        DataConstColumnName.COLUMN_PRIORITY,
    CheckListDetailSearchParameter.STATUS:
        DataConstColumnName.COLUMN_JOB_STATUS,
    CheckListDetailSearchParameter.ASSIGNEDTO:
        DataConstColumnName.COLUMN_ASSIGNED_TO,
    CheckListDetailSearchParameter.SCHEDULEFROMDATE:
        DataConstColumnName.COLUMN_SCHEDULE_TIME,
    CheckListDetailSearchParameter.SCHEDULETODATE:
        DataConstColumnName.COLUMN_SCHEDULE_TIME,
    CheckListDetailSearchParameter.JOBTYPE: DataConstColumnName.COLUMN_JOB_TYPE,
    CheckListDetailSearchParameter.TASKNAME:
        DataConstColumnName.COLUMN_JOB_NAME,
    CheckListDetailSearchParameter.TASKID: DataConstColumnName.COLUMN_JOBTASKID,
    CheckListDetailSearchParameter.REQUESTTYPE:
        DataConstColumnName.COLUMN_REQUEST_TYPE,
    CheckListDetailSearchParameter.SERVERSYNC:
        DataConstColumnName.COLUMN_SERVERSYNC,
    CheckListDetailSearchParameter.ASSIGNEDUSERID:
        DataConstColumnName.COLUMN_ASSIGNED_USER_ID,
    CheckListDetailSearchParameter.ASSETID: DataConstColumnName.COLUMN_ASSETID
  };

  static final List<String> values = [
    /// Add all fields
    DataConstColumnName.COLUMN_MAINT_CHECKLIST_DETAIL_ID
  ];

  String query = "SELECT * FROM ${DatabaseTableName.TABLE_CHECKLIST_DETAIL}";

  @override
  Future<List?> getData({required Map? searchparams}) async {
    if (_isLocalDataStale() == false) {
      var dbClient = await maintainanceDatabase.database;
      // traverse through the params
      // build query
      String selectQuery = query;
      selectQuery += getFilterQuery(searchparams!);
      print(selectQuery);
      final result = await dbClient.rawQuery(
          "$selectQuery Order By ${DataConstColumnName.COLUMN_LOCAL_MAINT_CHECKLIST_DETAIL_ID} DESC");
      return result;
    } else {
      // clear all the transaction data
      return [];
    }
  }

  bool _isLocalDataStale() {
    var lastRefreshedTime = LocalStorage().get(_storageKey);
    if (lastRefreshedTime == null) {
      return true;
    }
    if (DateTime.parse(lastRefreshedTime).isBefore(
        DateTime.now().subtract(Duration(minutes: _dataLifeInMins)))) {
      return true;
    }
    return false;
  }

  @override
  Future<int?> postDataToLocalDB(Object dto) async {
    var dbClient = await maintainanceDatabase.database;
    var queryResult = await dbClient.query(
      DatabaseTableName.TABLE_CHECKLIST_DETAIL,
      columns: values,
      where:
          '${DataConstColumnName.COLUMN_LOCAL_MAINT_CHECKLIST_DETAIL_ID} = ?',
      whereArgs: [
        CheckListDetailDTO.fromJson(jsonEncode(dto)).localmaintChklstdetId
      ],
    );

    if (queryResult.isEmpty) {
      sqlstate = await dbClient.insert(DatabaseTableName.TABLE_CHECKLIST_DETAIL,
          CheckListDetailDTO.fromJson(jsonEncode(dto)).toMap());
      if (sqlstate != -1) {
        LocalStorage().save(_storageKey, DateTime.now().toString());
      }
    } else {
      sqlstate = await dbClient.update(DatabaseTableName.TABLE_CHECKLIST_DETAIL,
          CheckListDetailDTO.fromJson(jsonEncode(dto)).toMap(),
          where:
              "${DataConstColumnName.COLUMN_LOCAL_MAINT_CHECKLIST_DETAIL_ID} = ?",
          whereArgs: [
            CheckListDetailDTO.fromJson(jsonEncode(dto)).localmaintChklstdetId
          ]);
      if (sqlstate != -1) {
        LocalStorage().save(_storageKey, DateTime.now().toString());
      }
    }
    return sqlstate;
  }

  Future<int> cleartable(
      Map<CheckListDetailSearchParameter, dynamic>
          checkListDetailssearchParams) async {
    try {
      var dbClient = await maintainanceDatabase.database;
      sqlstate = await dbClient.delete(DatabaseTableName.TABLE_CHECKLIST_DETAIL,
          where: "${DataConstColumnName.COLUMN_SERVERSYNC} = ?",
          whereArgs: [
            checkListDetailssearchParams[
                CheckListDetailSearchParameter.SERVERSYNC]
          ]);
      return sqlstate;
    } on Exception catch (e) {
      print(e);
      return -1;
    } catch (error) {
      print(error);
      return -1;
    }
  }

  String getFilterQuery(Map searchParameters) {
    int count = 0;
    StringBuffer query = StringBuffer();
    if ((searchParameters.isNotEmpty)) {
      String joiner;
      searchParameters.forEach((key, value) {
        joiner = count == 0 ? " where " : " and ";
        if (dbSearchParameters.containsKey(key) == true) {
          if (key == CheckListDetailSearchParameter.SITEID) {
            query.write(
                "$joiner(${dbSearchParameters[key]}=${searchParameters[key]} or ${searchParameters[key]}=-1) ");
          } else if (key == CheckListDetailSearchParameter.JOBTYPE) {
            query.write(
                "$joiner(${dbSearchParameters[key]}=${searchParameters[key]}) ");
          } else if (key == CheckListDetailSearchParameter.PRIORITY) {
            query.write(
                "$joiner(${dbSearchParameters[key]}=${searchParameters[key]} or ${searchParameters[key]}=-1) ");
          } else if (searchParameters[key] != null &&
              key == CheckListDetailSearchParameter.STATUS) {
            query.write(
                "$joiner(${dbSearchParameters[key]}=${searchParameters[key]} or ${searchParameters[key]}=-1) ");
          } else if (key == CheckListDetailSearchParameter.REQUESTTYPE) {
            query.write(
                "$joiner(${dbSearchParameters[key]}=${searchParameters[key]}) ");
          } else if (key == CheckListDetailSearchParameter.SERVERSYNC) {
            query.write(
                "$joiner(${dbSearchParameters[key]}=${searchParameters[key]}) ");
          } else if (key == CheckListDetailSearchParameter.ASSETID) {
            query.write(
                "$joiner(${dbSearchParameters[key]}=${searchParameters[key]}) ");
          } else if (key == CheckListDetailSearchParameter.TASKID) {
            query.write(
                "$joiner(${dbSearchParameters[key]}=${searchParameters[key]}) ");
          } else if (key == CheckListDetailSearchParameter.ASSIGNEDUSERID) {
            if (searchParameters[key] != null) {
              query.write(
                  "$joiner(${dbSearchParameters[key]}=${searchParameters[key].toString()})");
            }
          } else if (key == CheckListDetailSearchParameter.SCHEDULEFROMDATE) {
            if (searchParameters[key] != null && searchParameters[key] != "") {
              if (searchParameters[
                      CheckListDetailSearchParameter.SCHEDULEFROMDATE] !=
                  null) {
                query.write(
                    "$joiner(DATE(${DataConstColumnName.COLUMN_SCHEDULE_TIME})) >= DATE('${searchParameters[CheckListDetailSearchParameter.SCHEDULEFROMDATE]}')");
                // query.write(
                //     "DATE($joiner(${DataConstColumnName.COLUMN_SCHEDULE_TIME}) >= DATE('${searchParameters[CheckListDetailSearchParameter.SCHEDULEFROMDATE]}') AND DATE(${DataConstColumnName.COLUMN_SCHEDULE_TIME}) < DATE('${searchParameters[CheckListDetailSearchParameter.SCHEDULETODATE]}')) ");
              }
            }
          } else if (key == CheckListDetailSearchParameter.SCHEDULETODATE) {
            if (searchParameters[key] != null && searchParameters[key] != "") {
              if (searchParameters[
                      CheckListDetailSearchParameter.SCHEDULETODATE] !=
                  null) {
                query.write(
                    "$joiner(DATE(${DataConstColumnName.COLUMN_SCHEDULE_TIME})) < DATE('${searchParameters[CheckListDetailSearchParameter.SCHEDULETODATE]}')");
                // query.write(
                //     "DATE($joiner(${DataConstColumnName.COLUMN_SCHEDULE_TIME}) >= DATE('${searchParameters[CheckListDetailSearchParameter.SCHEDULEFROMDATE]}') AND DATE(${DataConstColumnName.COLUMN_SCHEDULE_TIME}) < DATE('${searchParameters[CheckListDetailSearchParameter.SCHEDULETODATE]}')) ");
              }
            }
          }
          count++;
        }
      });
    }
    return query.toString();
  }

  @override
  Future<List?> postData(Object? dto, Map? searchparams) async {
    // TODO: implement postDataToLocalDB
    throw UnimplementedError();
  }

  /// *********************

  Future<int> insertCheckListDetail(
      CheckListDetailDTO checkListDetailDTO) async {
    try {
      var dbClient = await maintainanceDatabase.database;

      var queryResult = await dbClient.query(
        DatabaseTableName.TABLE_CHECKLIST_DETAIL,
        columns: values,
        where: '${DataConstColumnName.COLUMN_MAINT_CHECKLIST_DETAIL_ID} = ?',
        whereArgs: [checkListDetailDTO.maintChklstdetId],
      );

      if (queryResult.isEmpty) {
        sqlstate = dbClient.insert(DatabaseTableName.TABLE_CHECKLIST_DETAIL,
            checkListDetailDTO.toMap());

        if (sqlstate != -1) {
          LocalStorage().save(_storageKey, DateTime.now().toString());
        }
      }

      return sqlstate;
    } on Exception catch (e) {
      print(e);
      return -1;
    } catch (error) {
      print(error);
      return -1;
    }
  }

  Future<int> updateCheckListTable(
      CheckListDetailDTO checkListDetailDTO) async {
    try {
      var dbClient = await maintainanceDatabase.database;
      var queryResult = await dbClient.query(
        DatabaseTableName.TABLE_CHECKLIST_DETAIL,
        columns: values,
        where:
            '${DataConstColumnName.COLUMN_LOCAL_MAINT_CHECKLIST_DETAIL_ID} = ?',
        whereArgs: [checkListDetailDTO.localmaintChklstdetId],
      );

      if (queryResult.isEmpty) {
        sqlstate = await dbClient.insert(
            DatabaseTableName.TABLE_CHECKLIST_DETAIL,
            checkListDetailDTO.toMap());
        if (sqlstate != -1) {
          LocalStorage().save(_storageKey, DateTime.now().toString());
        }
      } else {
        sqlstate = await dbClient.update(
            DatabaseTableName.TABLE_CHECKLIST_DETAIL,
            checkListDetailDTO.toMap(),
            where:
                "${DataConstColumnName.COLUMN_LOCAL_MAINT_CHECKLIST_DETAIL_ID} = ?",
            whereArgs: [checkListDetailDTO.localmaintChklstdetId]);
        if (sqlstate != -1) {
          LocalStorage().save(_storageKey, DateTime.now().toString());
        }
      }

      return sqlstate;
    } on Exception catch (e) {
      print(e);
      return -1;
    } catch (error) {
      print(error);
      return -1;
    }
  }

  Future<List<CheckListDetailDTO>> getCheckListDetailDTOList(
      Map<CheckListDetailSearchParameter, dynamic> searchParameter) async {
    if (_isLocalDataStale() == false) {
      var dbClient = await maintainanceDatabase.database;
      String selectQuery = query;
      selectQuery += getFilterQuery(searchParameter);
      final result = await dbClient.rawQuery(
          "$selectQuery Order By ${DataConstColumnName.COLUMN_LOCAL_MAINT_CHECKLIST_DETAIL_ID} DESC");
      return result.map((json) => CheckListDetailDTO.fromMap(json)).toList();
    } else {
      return [];
    }
  }

  Future<List<CheckListDetailDTO>> getCheckListDetailDTOListByTaskGroupId(
      Map<CheckListDetailSearchParameter, dynamic> searchParameter,
      int? taskgroupId) async {
    var dbClient = await maintainanceDatabase.database;
    // traverse through the params
    // build query
    String selectQuery = query;
    if (taskgroupId == -1) {
      selectQuery =
          "$selectQuery where ${DataConstColumnName.COLUMN_JOBTASKID} = -1 AND DATE(${DataConstColumnName.COLUMN_SCHEDULE_TIME}) >= DATE('${searchParameter[CheckListDetailSearchParameter.SCHEDULEFROMDATE]}') AND DATE(${DataConstColumnName.COLUMN_SCHEDULE_TIME}) < DATE('${searchParameter[CheckListDetailSearchParameter.SCHEDULETODATE]}') AND ${DataConstColumnName.COLUMN_JOB_STATUS} != COALESCE(${searchParameter[CheckListDetailSearchParameter.STATUS]},0) AND ${DataConstColumnName.COLUMN_ASSIGNED_USER_ID} = ${searchParameter[CheckListDetailSearchParameter.ASSIGNEDUSERID]} Order By ${DataConstColumnName.COLUMN_LOCAL_MAINT_CHECKLIST_DETAIL_ID} DESC";
    } else {
      selectQuery =
          "$selectQuery c left join ${DatabaseTableName.TABLE_TASK} t on t.${DataConstColumnName.COLUMN_JOBTASKID} = c.${DataConstColumnName.COLUMN_JOBTASKID} left join ${DatabaseTableName.TABLE_TASKGROUP} tg on tg.${DataConstColumnName.COLUMN_MAINT_TASK_GROUP_ID} = t.${DataConstColumnName.COLUMN_MAINT_TASK_GROUP_ID} where tg.${DataConstColumnName.COLUMN_MAINT_TASK_GROUP_ID} = $taskgroupId AND DATE(c.${DataConstColumnName.COLUMN_SCHEDULE_TIME}) >= DATE('${searchParameter[CheckListDetailSearchParameter.SCHEDULEFROMDATE]}') AND DATE(c.${DataConstColumnName.COLUMN_SCHEDULE_TIME}) < DATE('${searchParameter[CheckListDetailSearchParameter.SCHEDULETODATE]}') AND c.${DataConstColumnName.COLUMN_JOB_STATUS} != COALESCE(${searchParameter[CheckListDetailSearchParameter.STATUS]},0) AND c.${DataConstColumnName.COLUMN_ASSIGNED_USER_ID} = ${searchParameter[CheckListDetailSearchParameter.ASSIGNEDUSERID]} Order By ${DataConstColumnName.COLUMN_LOCAL_MAINT_CHECKLIST_DETAIL_ID} DESC";
    }
    final result = await dbClient.rawQuery(selectQuery);
    return result.map((json) => CheckListDetailDTO.fromMap(json)).toList();
  }

  Future<Iterable<CheckListDetailDTO>> getCheckListDetailDTOListByLocalMaintID(
      int localmaintCheckId) async {
    var dbClient = await maintainanceDatabase.database;
    final result = await dbClient.rawQuery(
        'select * from ${DatabaseTableName.TABLE_CHECKLIST_DETAIL} where ${DataConstColumnName.COLUMN_LOCAL_MAINT_CHECKLIST_DETAIL_ID}=$localmaintCheckId');
    return result.map((json) => CheckListDetailDTO.fromMap(json));
  }

  Future<List<CheckListDetailDTO>> getCheckListDetailDTOListByID(
      String lookuppriorityValueID, String lookupstatusValueID) async {
    var dbClient = await maintainanceDatabase.database;
    final result = await dbClient.rawQuery(
        'select * from ${DatabaseTableName.TABLE_CHECKLIST_DETAIL} where Status=$lookupstatusValueID AND Priority=$lookuppriorityValueID');
    return result.map((json) => CheckListDetailDTO.fromMap(json)).toList();
  }

  Future<ActionCount> getPendingAction(
      Map<CheckListDetailSearchParameter, dynamic> searchParameter,
      int? taskClosedStatusId,
      int? srClosedStatusId,
      {int? taskgroupid}) async {
    var dbClient = await maintainanceDatabase.database;
    String? totalQuery, pendingQuery;
    if (taskgroupid != null) {
      if (taskgroupid == -1) {
        totalQuery =
            'select count(*) as totalcount from ${DatabaseTableName.TABLE_CHECKLIST_DETAIL} where DATE(${DataConstColumnName.COLUMN_SCHEDULE_TIME}) = DATE("${searchParameter[CheckListDetailSearchParameter.ChklstScheduleTime]}") AND ${DataConstColumnName.COLUMN_ASSIGNED_USER_ID} = ${searchParameter[CheckListDetailSearchParameter.ASSIGNEDUSERID]} AND ${DataConstColumnName.COLUMN_JOBTASKID} = $taskgroupid';
        pendingQuery =
            'select count(*) as totalcount from ${DatabaseTableName.TABLE_CHECKLIST_DETAIL} where ${DataConstColumnName.COLUMN_JOB_STATUS} != COALESCE($taskClosedStatusId,0) AND DATE(${DataConstColumnName.COLUMN_SCHEDULE_TIME}) = DATE("${searchParameter[CheckListDetailSearchParameter.ChklstScheduleTime]}") AND ${DataConstColumnName.COLUMN_ASSIGNED_USER_ID} = ${searchParameter[CheckListDetailSearchParameter.ASSIGNEDUSERID]} AND ${DataConstColumnName.COLUMN_JOBTASKID} = $taskgroupid';
      } else {
        pendingQuery =
            'select count(*) as totalcount from ${DatabaseTableName.TABLE_CHECKLIST_DETAIL} c left join ${DatabaseTableName.TABLE_TASK} t on t.${DataConstColumnName.COLUMN_JOBTASKID} = c.${DataConstColumnName.COLUMN_JOBTASKID} left join ${DatabaseTableName.TABLE_TASKGROUP} tg on tg.${DataConstColumnName.COLUMN_MAINT_TASK_GROUP_ID} = t.${DataConstColumnName.COLUMN_MAINT_TASK_GROUP_ID} where tg.${DataConstColumnName.COLUMN_MAINT_TASK_GROUP_ID} = $taskgroupid AND DATE(c.${DataConstColumnName.COLUMN_SCHEDULE_TIME}) = DATE("${searchParameter[CheckListDetailSearchParameter.ChklstScheduleTime]}") AND c.${DataConstColumnName.COLUMN_JOB_STATUS} != COALESCE($taskClosedStatusId,0) AND c.${DataConstColumnName.COLUMN_ASSIGNED_USER_ID} = ${searchParameter[CheckListDetailSearchParameter.ASSIGNEDUSERID]}';
        totalQuery =
            'select count(*) as totalcount from ${DatabaseTableName.TABLE_CHECKLIST_DETAIL} c left join ${DatabaseTableName.TABLE_TASK} t on t.${DataConstColumnName.COLUMN_JOBTASKID} = c.${DataConstColumnName.COLUMN_JOBTASKID} left join ${DatabaseTableName.TABLE_TASKGROUP} tg on tg.${DataConstColumnName.COLUMN_MAINT_TASK_GROUP_ID} = t.${DataConstColumnName.COLUMN_MAINT_TASK_GROUP_ID} where tg.${DataConstColumnName.COLUMN_MAINT_TASK_GROUP_ID} = $taskgroupid AND DATE(c.${DataConstColumnName.COLUMN_SCHEDULE_TIME}) = DATE("${searchParameter[CheckListDetailSearchParameter.ChklstScheduleTime]}") AND c.${DataConstColumnName.COLUMN_ASSIGNED_USER_ID} = ${searchParameter[CheckListDetailSearchParameter.ASSIGNEDUSERID]}';
      }
    } else {
      totalQuery =
          'select count(*) as totalcount from ${DatabaseTableName.TABLE_CHECKLIST_DETAIL} where DATE(${DataConstColumnName.COLUMN_SCHEDULE_TIME}) = DATE("${searchParameter[CheckListDetailSearchParameter.ChklstScheduleTime]}") AND ${DataConstColumnName.COLUMN_ASSIGNED_USER_ID} = ${searchParameter[CheckListDetailSearchParameter.ASSIGNEDUSERID]}';
      pendingQuery =
          'select count(*) as totalcount from ${DatabaseTableName.TABLE_CHECKLIST_DETAIL} where ${DataConstColumnName.COLUMN_JOB_STATUS} != COALESCE($taskClosedStatusId,0) AND ${DataConstColumnName.COLUMN_JOB_STATUS} != COALESCE($srClosedStatusId,0) AND DATE(${DataConstColumnName.COLUMN_SCHEDULE_TIME}) = DATE("${searchParameter[CheckListDetailSearchParameter.ChklstScheduleTime]}") AND ${DataConstColumnName.COLUMN_ASSIGNED_USER_ID} = ${searchParameter[CheckListDetailSearchParameter.ASSIGNEDUSERID]}';
    }
    final totItem = await dbClient.rawQuery(totalQuery);
    final pendingItem = await dbClient.rawQuery(pendingQuery);
    double? totalcount =
        double.tryParse(totItem.first.values.first.toString()) ?? 0.0;
    double? pendingcount =
        double.tryParse(pendingItem.first.values.first.toString()) ?? 0.0;
    double percent = (totalcount != 0) && (pendingcount != 0)
        ? (totalcount / pendingcount)
        : 0.0;
    ActionCount actionCount = ActionCount(pendingcount, totalcount, percent);
    return actionCount;
  }
}
