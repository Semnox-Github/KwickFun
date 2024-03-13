import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/model/images_dto.dart';
import 'package:semnox_core/utils/database/dataConstant.dart';
import 'package:semnox_core/utils/database/databaseHelper.dart';

class ImageDbHandler {
  late DatabaseHelper maintainanceDatabase;
  late ExecutionContextDTO _executionContextDTO;
  var sqlstate;

  ImageDbHandler(ExecutionContextDTO executionContext) {
    maintainanceDatabase = DatabaseHelper();
    _executionContextDTO = executionContext;
  }

  //MaintenanceChecklistTable

  static final String CREATE_IMAGE_TABLE = "CREATE TABLE IF NOT EXISTS " +
      DatabaseTableName.TABLE_IMAGE +
      "(" +
      DataConstColumnName.COLUMN_LOCAL_IMAGE_ID +
      DataConstDataType.INTEGER_PRIMARY_KEY +
      DataConstColumnName.COLUMN_IMAGE_ID +
      " integer, " +
      DataConstColumnName.COLUMN_MAINT_CHECKLIST_DETAILS_ID +
      " integer, " +
      DataConstColumnName.COLUMN_IMAGETYPE +
      " integer, " +
      DataConstColumnName.COLUMN_IMAGE_FILENAME +
      " text, " +
      // DataConstColumnName.COLUMN_IMAGE_PATH +
      // " text, " +
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
      DataConstColumnName.COLUMN_FILEUPLOAD +
      " INTEGER DEFAULT 0, " +
      DataConstColumnName.COLUMN_SERVERSYNCTIME +
      " DATETIME, " +
      DataConstColumnName.COLUMN_APPLASTUPDATEDTIME +
      " DATETIME, " +
      DataConstColumnName.COLUMN_APPLASTUPDATEDBY +
      " text)";

  static final List<String> values = [
    /// Add all fields
    DataConstColumnName.COLUMN_IMAGE_ID
  ];

  String SELECT_QUERY = "SELECT * FROM ${DatabaseTableName.TABLE_IMAGE} ";

  static Map<dynamic, String> dbSearchParameters = {
    ImageSearchParameter.SITEID: DataConstColumnName.COLUMN_SITEID,
    ImageSearchParameter.MAINTCHECKLISTDETAILID:
        DataConstColumnName.COLUMN_MAINT_CHECKLIST_DETAILS_ID,
    ImageSearchParameter.IMAGETYPE: DataConstColumnName.COLUMN_IMAGETYPE,
    ImageSearchParameter.LASTUPDATEDDATE:
        DataConstColumnName.COLUMN_LASTUPDATEDDATE,
    ImageSearchParameter.SERVERSYNC: DataConstColumnName.COLUMN_SERVERSYNC,
  };

  Future<int> insertimageTable(ImageDTO imageDTO) async {
    try {
      var dbClient = await maintainanceDatabase.database;

      // var queryResult = await dbClient.query(
      //   DatabaseTableName.TABLE_IMAGE,
      //   columns: values,
      //   where: '${DataConstColumnName.COLUMN_IMAGE_ID} = ?',
      //   whereArgs: [imageDTO.imageId],
      // );

      // if (queryResult.isEmpty) {
      //   sqlstate =
      //       dbClient.insert(DatabaseTableName.TABLE_IMAGE, imageDTO.toMap());
      // }

      sqlstate =
          dbClient.insert(DatabaseTableName.TABLE_IMAGE, imageDTO.toMap());

      return sqlstate;
    } on Exception {
      rethrow;
    } on Error {
      rethrow;
    }
  }

  Future<int> updateimageTable(ImageDTO imageDTO) async {
    try {
      var dbClient = await maintainanceDatabase.database;

      sqlstate = dbClient.update(
          DatabaseTableName.TABLE_IMAGE, imageDTO.toMap(),
          where: '${DataConstColumnName.COLUMN_LOCAL_IMAGE_ID} = ?',
          whereArgs: [imageDTO.localImageId]);

      return sqlstate;
    } on Exception {
      rethrow;
    } on Error {
      rethrow;
    }
  }

  Future<List<ImageDTO>> getImageList(
      Map<ImageSearchParameter, dynamic> imageSearchParameter) async {
    try {
      var dbClient = await maintainanceDatabase.database;
      String selectQuery = SELECT_QUERY;
      selectQuery += getFilterQuery(imageSearchParameter);
      print(selectQuery);
      final result = await dbClient.rawQuery(
          "$selectQuery Order By ${DataConstColumnName.COLUMN_LASTUPDATEDDATE} DESC");

      return result.map((json) => ImageDTO.fromMap(json)).toList();
    } on Exception {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  String getFilterQuery(
      Map<ImageSearchParameter, dynamic> imageSearchParameter) {
    int count = 0;
    StringBuffer query = StringBuffer();
    if ((imageSearchParameter.isNotEmpty)) {
      String joiner;
      imageSearchParameter.forEach((key, value) {
        joiner = count == 0 ? "where" : " and ";
        if (dbSearchParameters.containsKey(key)) {
          if (key == ImageSearchParameter.SITEID) {
            query.write(
                "$joiner(${dbSearchParameters[key]}=${imageSearchParameter[key]} or ${imageSearchParameter[key]}=-1) ");
          } else if (key == ImageSearchParameter.MAINTCHECKLISTDETAILID) {
            query.write(
                "$joiner(${dbSearchParameters[key]}=${imageSearchParameter[key]}) ");
          } else if (key == ImageSearchParameter.IMAGETYPE) {
            query.write(
                "$joiner(${dbSearchParameters[key]}=${imageSearchParameter[key]}) ");
          } else if (key == ImageSearchParameter.SERVERSYNC) {
            query.write(
                "$joiner(${dbSearchParameters[key]}=${imageSearchParameter[key]}) ");
          }
          count++;
        }
      });
    }
    return query.toString();
  }
}
