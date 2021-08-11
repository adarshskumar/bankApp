import 'package:bankapp/models/transactionData.dart';
import 'package:bankapp/models/userData.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await database();
    return _db;
  }

  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'bankingsystem.db'),
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE userdetails(id INTEGER PRIMARY KEY, userName TEXT,cardNumber VARCHAR,totalAmount DOUBLE)");
        await db.execute(
            "CREATE TABLE transectionsData(id INTEGER PRIMARY KEY, transectionId INTEGER,userName TEXT,senderName TEXT,transectionAmount DOUBLE)");

        return db;
      },
      version: 1,
    );
  }

  Future<void> insertUserDetails(UserData userdata) async {
    final Database _db = await database();
    await _db.insert('userdetails', userdata.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertTransactionHistory(
      TransactionDetails transactionDetails) async {
    Database _db = await database();
    await _db.insert('transectionsData', transactionDetails.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateTotalAmount(int id, double totalAmount) async {
    Database _db = await database();
    await _db.rawUpdate(
        "UPDATE userDetails SET totalAmount = '$totalAmount' WHERE id = '$id'");
  }

  Future<List<UserData>> getUserDetails() async {
    final Database _db = await database();
    final List<Map<String, dynamic>> userMap = await _db.query('userdetails');
    return List.generate(
      userMap.length,
      (index) {
        return UserData(
          id: userMap[index]['id'],
          userName: userMap[index]['userName'],
          cardNumber: userMap[index]['cardNumber'],
          totalAmount: userMap[index]['totalAmount'],
        );
      },
    );
  }

  Future<List<UserData>> getUserDetailsList(int userId) async {
    final Database _db = await database();
    List<Map<String, dynamic>> userMap =
        await _db.rawQuery("SELECT * FROM userDetails WHERE id != $userId");
    return List.generate(userMap.length, (index) {
      return UserData(
        id: userMap[index]['id'],
        userName: userMap[index]['userName'],
        cardNumber: userMap[index]['cardNumber'],
        totalAmount: userMap[index]['totalAmount'],
      );
    });
  }

  Future<List<TransactionDetails>> getTransactionDetails() async {
    Database _db = await database();
    final List<Map<String, dynamic>> transactionMap =
        await _db.rawQuery("SELECT * FROM transectionsData");
    return List.generate(transactionMap.length, (index) {
      return TransactionDetails(
        id: transactionMap[index]['id'],
        receiverName: transactionMap[index]['userName'],
        senderName: transactionMap[index]['senderName'],
        transectionId: transactionMap[index]['transectionId'],
        transectionAmount: transactionMap[index]['transectionAmount'],
      );
    });
  }

  Future<void> updateTransactionIsDone(int id, int transactionDone) async {
    Database _db = await database();
    await _db.rawUpdate(
        "UPDATE transectionsData SET transectionDone = '$transactionDone' WHERE id = '$id'");
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      'userdetails',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
