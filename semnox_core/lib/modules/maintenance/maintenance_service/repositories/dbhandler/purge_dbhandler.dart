import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/model/maintainence_service_dto.dart';
import 'package:semnox_core/utils/database/dataConstant.dart';
import 'package:semnox_core/utils/database/databaseHelper.dart';

class PurgeDbHandler {
  late DatabaseHelper maintainanceDatabase;
  dynamic sqlstate;

  PurgeDbHandler(ExecutionContextDTO executionContext) {
    maintainanceDatabase = DatabaseHelper();
  }

  Future<int> purgeJobDetails(
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
}
