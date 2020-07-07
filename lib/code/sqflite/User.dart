import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableName = 'user'; //表名
final String columnId = 'id'; //主键
final String columnUserId = 'userId'; //用户唯一标识
final String columnName = 'name'; //用户名
final String columnAge = 'age'; //年龄
final String columnSex = 'sex'; //性别字段 2

class User {
  int id;
  int userId;
  String name;
  int age;
  String sex;

  User();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      columnId: id,
      columnUserId: userId,
      columnName: name,
      columnAge: age,
      columnSex: sex,
    };
  }

  User.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    userId = map[columnUserId];
    name = map[columnName];
    age = map[columnAge];
    sex = map[columnSex];
  }

  @override
  String toString() {
    return 'User{id : $id,userId : $userId,name : $name,age : $age,sex : $sex}';
  }
}

class SqlLite {
  Database db;

  //创建数据库
  openSqlLite() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "testaaa.db");
    db = await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  void _onCreate(db, version) async {
    var batch = db.batch();
    _createTableUser(batch);
    await batch.commit();
  }

  ///创建用户表
  void _createTableUser(batch) {
    batch.execute('''
          create table $tableName (
            $columnId integer primary key,
            $columnUserId integer,
            $columnName text,
            $columnAge integer,
            $columnSex text
            )
          ''');
  }

  //升级
  void _onUpgrade(db, oldVersion, newVersion) async {
    print('升级');
    var batch = db.batch();
    if (oldVersion == 1) {
      _updateTableUser(batch); //升级过程中也可以创建新表
    }
    await batch.commit();
  }

  //增加性别字段
  void _updateTableUser(batch) {
    batch.execute('alter table $tableName add $columnSex text');
  }

  /// 插入数据
  Future<int> insert(user) async {
    return await db.insert(tableName, user.toMap());
  }

  //查询所有数据
  Future<List<User>> queryAll() async {
    List<Map> maps = await db.query(tableName, columns: null);
    if (maps == null || maps.length == 0) {
      return null;
    }
    List<User> users = List();
    for (int i = 0; i < maps.length; i++) {
      users.add(User.fromMap(maps[i]));
    }
    return users;
  }

  //根据id查询数据
  Future<User> getUser(userId) async {
    List<Map> maps = await db.query(tableName,
        columns: null, where: '$columnUserId=?', whereArgs: [userId]);

    if (maps.length > 0) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  //删除数据
  Future<int> delete(userId) async {
    return await db
        .delete(tableName, where: '$columnUserId=?', whereArgs: [userId]);
  }

  //更新数据
  Future<int> update(user) async {
    return await db.update(tableName, user.toMap(),
        where: '$columnUserId = ?', whereArgs: [user.userId]);
  }

  //关闭数据
  close() async {
    await db.close();
  }
}
