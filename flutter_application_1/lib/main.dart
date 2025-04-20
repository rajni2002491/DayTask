import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Service/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhscG5hamNpYWFscWFsbnd4eXFvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDUxNjM2NjgsImV4cCI6MjA2MDczOTY2OH0.8nVK9gyeQcGuKN_wsb92uZkc7JKdJzTlDPim-4_pOkc',
    url: 'https://hlpnajciaalqalnwxyqo.supabase.co',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supabase Flutter App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const AuthGate(), // Shows splash + handles routing
    );
  }
}
