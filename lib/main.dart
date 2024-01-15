import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://spicqwegnemglnqbcvga.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNwaWNxd2VnbmVtZ2xucWJjdmdhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDUxOTM5ODEsImV4cCI6MjAyMDc2OTk4MX0.D64kVhqjaafaLw_nhLFhKAZG5vRsO4weYkvmicPXLyI',
  );

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'teachers',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _future = Supabase.instance.client.from('teachers').select();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final teachers = snapshot.data!;
          return ListView.builder(
            itemCount: teachers.length,
            itemBuilder: ((context, index) {
              final teacher = teachers[index];
              return ListTile(
                leading: Icon(
                  Icons.flag_circle_rounded,
                  color: Colors.red,
                ),
                // trailing: Icon(Icons.flag_circle_outlined, color: Colors.amber),
                title: Text(
                  teacher['nama'],
                  style: TextStyle(color: Colors.blue),
                ),
                subtitle: Text(teacher['mapel']),
                subtitle: Text(teacher['kelas']),
                subtitle: Text(teacher['tahunmasuk']),
              );
            }),
          );
        },
      ),
    );
  }
}
