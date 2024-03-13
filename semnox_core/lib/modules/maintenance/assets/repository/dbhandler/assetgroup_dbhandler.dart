import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/model/assets_group_dto.dart';
import 'package:semnox_core/utils/database/dataConstant.dart';
import 'package:semnox_core/utils/database/databaseHelper.dart';

class AssetGroupDbHandler {
  DatabaseHelper? maintainanceDatabase;
  ExecutionContextDTO? _executionContext;
  var sqlstate;
  AssetGroupDbHandler(ExecutionContextDTO executionContext) {
    maintainanceDatabase = DatabaseHelper();
    _executionContext = executionContext;
  }

  //Asset Table Creation String
  static final String CREATE_ASSETSGROUP_TABLE = "CREATE TABLE IF NOT EXISTS " +
      DatabaseTableName.TABLE_ASSETSGROUP +
      "(" +
      DataConstColumnName.COLUMN_ID +
      " integer primary key, " +
      DataConstColumnName.COLUMN_ASSETGROUPID +
      " integer, " +
      DataConstColumnName.COLUMN_ASSETGROUPNAME +
      " text, " +
      DataConstColumnName.COLUMN_MASTERENTITYID +
      " integer, " +
      DataConstColumnName.COLUMN_ISACTIVE +
      " INTEGER DEFAULT 0, " +
      DataConstColumnName.COLUMN_CREATED_BY +
      " text, " +
      DataConstColumnName.COLUMN_CREATED_DATE +
      " DATETIME, " +
      DataConstColumnName.COLUMN_LASTUPDATEDDATE +
      " DATETIME, " +
      DataConstColumnName.COLUMN_LASTUPDATEDBY +
      " text, " +
      DataConstColumnName.COLUMN_GUID +
      " text, " +
      DataConstColumnName.COLUMN_SITEID +
      " integer, " +
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

  static Map<dynamic, String> dbSearchParameters = {
    AssetGroupsDTOSearchParameter.ISACTIVE: DataConstColumnName.COLUMN_ISACTIVE,
    AssetGroupsDTOSearchParameter.SITEID: DataConstColumnName.COLUMN_SITEID,
  };

  String SELECT_QUERY = "SELECT * FROM ${DatabaseTableName.TABLE_ASSETSGROUP}";

  Future<int> insertAssetGroups(AssetGroupsDTO assetGroupsDTO) async {
    try {
      var dbClient = await maintainanceDatabase!.database;
      sqlstate = dbClient.insert(
          DatabaseTableName.TABLE_ASSETSGROUP, assetGroupsDTO.toMap());
      return sqlstate;
    } on Exception catch (e) {
      print(e);
      return -1;
    } catch (error) {
      print(error);
      return -1;
    }
  }

  Future<int> updateAssetGroups(AssetGroupsDTO assetGroupsDTO) async {
    try {
      var dbClient = await maintainanceDatabase!.database;
      sqlstate = await dbClient.update(
          DatabaseTableName.TABLE_ASSETSGROUP, assetGroupsDTO.toMap(),
          where: '${DataConstColumnName.COLUMN_ASSETGROUPID}  ?',
          whereArgs: [assetGroupsDTO.assetGroupId]);
      return sqlstate;
    } on Exception catch (e) {
      print(e);
      return -1;
    } catch (error) {
      print(error);
      return -1;
    }
  }

  Future<List<AssetGroupsDTO>> getAssetGroupsList(
      Map<AssetGroupsDTOSearchParameter, dynamic> searchParameter) async {
    var dbClient = await maintainanceDatabase!.database;
    String selectQuery = SELECT_QUERY;
    selectQuery += getFilterQuery(searchParameter);
    final result = await dbClient.rawQuery(selectQuery);
    return result.map((json) => AssetGroupsDTO.fromMap(json)).toList();
  }

  String getFilterQuery(
      Map<AssetGroupsDTOSearchParameter, dynamic> searchParameters) {
    int count = 0;
    StringBuffer query = StringBuffer();
    if ((searchParameters.isNotEmpty)) {
      String joiner;
      searchParameters.forEach((key, value) {
        joiner = count == 0 ? " where " : " and ";
        if (dbSearchParameters.containsKey(key)) {
          if (key == AssetGroupsDTOSearchParameter.SITEID) {
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
