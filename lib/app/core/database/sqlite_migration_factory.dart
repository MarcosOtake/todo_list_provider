import 'package:todo_list_provider/app/core/database/migrations/migration_v1.dart';
import 'package:todo_list_provider/app/core/database/migrations/migration_v2.dart';
import 'package:todo_list_provider/app/core/database/migrations/migration_v3.dart';
import 'package:todo_list_provider/app/core/database/migrations/migrations.dart';

class SqliteMigrationFactory {
  List<Migrations> getCreateMigration() => [
        MigrationV1(),
        MigrationV2(),
        MigrationV3(),
      ];
  List<Migrations> getUpgradeMigration(int version) {
    final migrations = <Migrations>[];
    if (version == 1) {
      migrations.add(MigrationV2());
      migrations.add(MigrationV3());
    }
    if (version == 2) {
      migrations.add(MigrationV3());
    }
    return migrations;
  }
}

/*
DICAS DA LÓGICA DAS MIGRATIONS
Caso o usuario esteja na versão 1 e o projeto esteja na versão 3 
ele precisará atualizar a versão 2 e a 3 para pegar todas as mudanças da 2 tambem
*/