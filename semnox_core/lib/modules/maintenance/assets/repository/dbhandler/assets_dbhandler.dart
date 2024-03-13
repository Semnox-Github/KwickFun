import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/model/asset_dto.dart';
import 'package:semnox_core/utils/database/dataConstant.dart';
import 'package:semnox_core/utils/database/databaseHelper.dart';

class GenericAssetDbHandler {
  late DatabaseHelper maintainanceDatabase;
  late ExecutionContextDTO _executionContext;
  var sqlstate;
  GenericAssetDbHandler(ExecutionContextDTO executionContext) {
    maintainanceDatabase = DatabaseHelper();
    _executionContext = executionContext;
  }

  //Asset Table Creation String
  static final String CREATE_ASSETS_TABLE = "CREATE TABLE IF NOT EXISTS " +
      DatabaseTableName.TABLE_ASSETS +
      "(" +
      DataConstColumnName.COLUMN_ID +
      " integer primary key, " +
      DataConstColumnName.COLUMN_ASSETID +
      " integer, " +
      DataConstColumnName.COLUMN_NAME +
      " text, " +
      DataConstColumnName.COLUMN_DESCRIPTION +
      " text, " +
      DataConstColumnName.COLUMN_MACHINEID +
      " integer, " +
      DataConstColumnName.COLUMN_ASSET_TYPE_ID +
      " integer, " +
      DataConstColumnName.COLUMN_LOCATION +
      " text, " +
      DataConstColumnName.COLUMN_ASSETSTATUS +
      " text, " +
      DataConstColumnName.COLUMN_URN +
      " text, " +
      DataConstColumnName.COLUMN_PURCHASEDATE +
      " DATETIME, " +
      DataConstColumnName.COLUMN_SALEDATE +
      " DATETIME, " +
      DataConstColumnName.COLUMN_SCRAPDATE +
      " DATETIME, " +
      DataConstColumnName.COLUMN_ASSETTAXTYPEID +
      " integer, " +
      DataConstColumnName.COLUMN_PURCHASEVALUE +
      " double, " +
      DataConstColumnName.COLUMN_SALEVALUE +
      " double, " +
      DataConstColumnName.COLUMN_SCRAPVALUE +
      " double, " +
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
    AssetsGenericDTOSearchParameter.ISACTIVE:
        DataConstColumnName.COLUMN_ISACTIVE,
    AssetsGenericDTOSearchParameter.SITEID: DataConstColumnName.COLUMN_SITEID,
  };

  String SELECT_QUERY = "SELECT * FROM ${DatabaseTableName.TABLE_ASSETS}";

  Future<int> insertAsset(GenericAssetDTO genericAssetDTO) async {
    try {
      var dbClient = await maintainanceDatabase.database;
      sqlstate = dbClient.insert(
          DatabaseTableName.TABLE_ASSETS, genericAssetDTO.toMap());
      return sqlstate;
    } on Exception catch (e) {
      print(e);
      return -1;
    } catch (error) {
      print(error);
      return -1;
    }
  }

  Future<int> updateAsset(GenericAssetDTO assetDTO) async {
    try {
      var dbClient = await maintainanceDatabase.database;
      sqlstate = await dbClient.update(
          DatabaseTableName.TABLE_ASSETS, assetDTO.toMap(),
          where: '${DataConstColumnName.COLUMN_ASSETGROUPID}  ?',
          whereArgs: [assetDTO.assetId]);
      return sqlstate;
    } on Exception catch (e) {
      print(e);
      return -1;
    } catch (error) {
      print(error);
      return -1;
    }
  }

  Future<List<GenericAssetDTO>> getAssetLists() async {
    var dbClient = await maintainanceDatabase.database;
    var result = await dbClient.rawQuery(SELECT_QUERY);

    return result.map((json) => GenericAssetDTO.fromMap(json)).toList();
  }

  Future<List<GenericAssetDTO>> getAssetDTOList(
      Map<AssetsGenericDTOSearchParameter, dynamic> searchParameter) async {
    var dbClient = await maintainanceDatabase.database;
    String selectQuery = SELECT_QUERY;
    selectQuery += getFilterQuery(searchParameter);
    final result = await dbClient.rawQuery(selectQuery);
    return result.map((json) => GenericAssetDTO.fromMap(json)).toList();
  }

  String getFilterQuery(
      Map<AssetsGenericDTOSearchParameter, dynamic> searchParameters) {
    int count = 0;
    StringBuffer query = StringBuffer();
    if ((searchParameters.isNotEmpty)) {
      String joiner;
      searchParameters.forEach((key, value) {
        joiner = count == 0 ? " where " : " and ";
        if (dbSearchParameters.containsKey(key)) {
          if (key == AssetsGenericDTOSearchParameter.SITEID) {
            query.write(
                "$joiner(${dbSearchParameters[key]}=${searchParameters[key]} or ${searchParameters[key]}=-1) ");
          }
          // else if (key == AssetsGenericDTOSearchParameter.ISACTIVE) {
          //   query.write(joiner +
          //       "Isnull(" +
          //       DBSearchParameters[key].toString() +
          //       ",'Y') =" +
          //       searchParameters[key].toString());
          // }
          count++;
        }
      });
    }
    return query.toString();
  }

  // Future<bool> CheckExitsMaintChklstdetId(int? id) async {
  //   var dbClient = await maintainanceDatabase.database;
  //   final maps = await dbClient.query(
  //     TABLE_ASSETS,
  //     columns: values,
  //     where: '${DataConstTableName.COLUMN_ASSETID}  ?',
  //     whereArgs: [id],
  //   );

  //   if (maps.isNotEmpty) {
  //     return true;
  //   } else if (maps.isEmpty) {
  //     return false;
  //   } else {
  //     throw Exception('ID $id not found');
  //   }
  // }
}

// final ValueNotifier<int> assetstotalrecordcompleted = ValueNotifier<int>(0);