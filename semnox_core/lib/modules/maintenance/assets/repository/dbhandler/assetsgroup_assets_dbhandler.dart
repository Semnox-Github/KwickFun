import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/model/assetgroup_Assets_dto.dart';
import 'package:semnox_core/utils/database/dataConstant.dart';
import 'package:semnox_core/utils/database/databaseHelper.dart';

class AssetsGroupAssetsDbHandler {
  late DatabaseHelper maintainanceDatabase;
  late ExecutionContextDTO _executionContext;
  var sqlstate;

  AssetsGroupAssetsDbHandler(ExecutionContextDTO executionContext) {
    maintainanceDatabase = DatabaseHelper();
    _executionContext = executionContext;
  }

  //Asset Table Creation String
  static final String CREATE_ASSETGROUP_ASSET_TABLE =
      "CREATE TABLE IF NOT EXISTS " +
          DatabaseTableName.TABLE_ASSETSGROUP_ASSETS +
          "(" +
          DataConstColumnName.COLUMN_ID +
          " integer primary key, " +
          DataConstColumnName.COLUMN_ASSETGROUPASSETID +
          " integer, " +
          DataConstColumnName.COLUMN_ASSETGROUPID +
          " integer, " +
          DataConstColumnName.COLUMN_ASSETID +
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
          " integer, " +
          DataConstColumnName.COLUMN_SYNCHSTATUS +
          " INTEGER DEFAULT 0, " +
          DataConstColumnName.COLUMN_MASTERENTITYID +
          " integer, " +
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

  static Map<dynamic, String> DBSearchParameters = {
    AssetGroupAssetsDTOSearchParameter.ISACTIVE:
        DataConstColumnName.COLUMN_ISACTIVE,
    AssetGroupAssetsDTOSearchParameter.SITEID:
        DataConstColumnName.COLUMN_SITEID,
  };

  String SELECT_QUERY =
      "SELECT * FROM ${DatabaseTableName.TABLE_ASSETSGROUP_ASSETS}";

  Future<int> insertAssetGroupAsset(
      AssetGroupAssetsDto assetGroupAssetsDto) async {
    try {
      var dbClient = await maintainanceDatabase.database;
      sqlstate = dbClient.insert(DatabaseTableName.TABLE_ASSETSGROUP_ASSETS,
          assetGroupAssetsDto.toJson());
      return sqlstate;
    } on Exception catch (e) {
      print(e);
      return -1;
    } catch (error) {
      print(error);
      return -1;
    }
  }

  Future<int> updateAsset(AssetGroupAssetsDto assetGroupAssetsDto) async {
    try {
      var dbClient = await maintainanceDatabase.database;
      sqlstate = await dbClient.update(
          DatabaseTableName.TABLE_ASSETSGROUP_ASSETS,
          assetGroupAssetsDto.toJson(),
          where: '${DataConstColumnName.COLUMN_ASSETGROUPASSETID}  ?',
          whereArgs: [assetGroupAssetsDto.assetId]);
      return sqlstate;
    } on Exception catch (e) {
      print(e);
      return -1;
    } catch (error) {
      print(error);
      return -1;
    }
  }

  Future<List<AssetGroupAssetsDto>> getAssetGroupAssetDTOList(
      Map<AssetGroupAssetsDTOSearchParameter, dynamic> searchParameter) async {
    var dbClient = await maintainanceDatabase.database;
    String selectQuery = SELECT_QUERY;
    selectQuery += getFilterQuery(searchParameter);
    final result = await dbClient.rawQuery(selectQuery);
    return result.map((json) => AssetGroupAssetsDto.fromJson(json)).toList();
  }

  String getFilterQuery(
      Map<AssetGroupAssetsDTOSearchParameter, dynamic> searchParameters) {
    int count = 0;
    StringBuffer query = StringBuffer();
    if ((searchParameters.isNotEmpty)) {
      String joiner;
      searchParameters.forEach((key, value) {
        joiner = count == 0 ? " where " : " and ";
        if (DBSearchParameters.containsKey(key)) {
          if (key == AssetGroupAssetsDTOSearchParameter.SITEID) {
            query.write(
                "$joiner(${DBSearchParameters[key]}=${searchParameters[key]} or ${searchParameters[key]}=-1) ");
          }
          count++;
        }
      });
    }
    return query.toString();
  }
}
