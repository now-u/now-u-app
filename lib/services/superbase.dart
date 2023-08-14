import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  bool isInitialized = false;

  SupabaseClient? get client => isInitialized ? Supabase.instance.client : null;

  Future init() async {
    isInitialized = true;
    // TODO This just hangs if there is no user!
    await Supabase.initialize(
      url: 'https://uqwaxxhrkpbzvjdlfdqe.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVxd2F4eGhya3BienZqZGxmZHFlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzcyMjc5ODMsImV4cCI6MTk5MjgwMzk4M30.JiWVL_JjY-bUK_XauRrnexJSvkia1mH8FcWgUDN1grI',
    );
  }
}
