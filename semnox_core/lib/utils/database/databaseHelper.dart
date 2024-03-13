import 'package:path/path.dart';
import 'package:semnox_core/modules/maintenance/assets/repository/dbhandler/asset_type_dbhandler.dart';
import 'package:semnox_core/modules/maintenance/assets/repository/dbhandler/assetgroup_dbhandler.dart';
import 'package:semnox_core/modules/maintenance/assets/repository/dbhandler/assets_dbhandler.dart';
import 'package:semnox_core/modules/maintenance/assets/repository/dbhandler/assetsgroup_assets_dbhandler.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/repositories/dbhandler/comments_dbhandler.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/repositories/dbhandler/image_dbhandler.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/repositories/dbhandler/maintainence_dbhandler.dart';
import 'package:semnox_core/modules/maintenance/task/repository/dbhandler/task_dbhandler.dart';
import 'package:semnox_core/modules/maintenance/task_group/repository/dbhandler/task_group_dbhandler.dart';
import 'package:sqflite/sqflite.dart';

import './sqflite_migration/sqflite_migration.dart';

class DatabaseHelper {
  String dbName = "Maintenance3.db";
  static Database? _database;

  static List<String> initialScript = [
    GenericAssetDbHandler.CREATE_ASSETS_TABLE,
    AssetGroupDbHandler.CREATE_ASSETSGROUP_TABLE,
    AssetTypesDbHandler.CREATE_ASSET_TYPE_TABLE,
    AssetsGroupAssetsDbHandler.CREATE_ASSETGROUP_ASSET_TABLE,
    CheckListDetailDbHandler.CREATE_CHECKLIST_TABLE,
    TaskDbHandler.CREATE_TASK_TABLE,
    TaskGroupDbHandler.CREATE_TASK_GROUP_TABLE,
    CommentsDbHandler.CREATE_COMMENTS_TABLE,
    ImageDbHandler.CREATE_IMAGE_TABLE,
  ];

  static List<String> migrations = [];

  final config = MigrationConfig(
      initializationScript: initialScript, migrationScripts: migrations);

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _open();
    return _database!;
  }

  Future<Database> _open() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, dbName);

    return await openDatabaseWithMigration(path, config);
  }
}
