import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();

  late final SupabaseClient _supabase;

  factory SupabaseService() {
    return _instance;
  }

  SupabaseService._internal();

  Future<void> initialize() async {

    String jsonString = await rootBundle.loadString('assets/database.json');
    Map<String, dynamic> credentials = jsonDecode(jsonString);


    await Supabase.initialize(
      url: credentials['url'],
      anonKey: credentials['anonKey'],
    );
    _supabase = Supabase.instance.client;

  }

  Future<List<Map<String, dynamic>>> fetchTableData(String tableName) async {
    final response = await _supabase.from(tableName).select();
    return response;
  }

  Future<List<Map<String, dynamic>>> insertTableData(String tableName, String userName, String userEmail, String userPassword, String userBirthday) async {

    await initialize();

    final response = await _supabase.from(tableName).insert({
      'nome': userName,
      'email': userEmail,
      'dataNascimento': userBirthday
    });
    return response;
  }
}
