import 'package:flutter/material.dart';
import 'user_model.dart';
import 'api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo Parsing JSON SMK RPL',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
        ),
        useMaterial3: true,
      ),
      home: const UserListScreen(),
    );
  }
}

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late Future<List<UserModel>> _futureUsers;

  @override
  void initState() {
    super.initState();

    // Mengambil data dari API
    _futureUsers = ApiService.fetchUsers();

    // Contoh JSON String untuk pengujian
    String jsonString = '''
    {
      "id": 1,
      "name": "Evan Aziz Arganta",
      "username": "evan09",
      "email": "evan@example.com",
      "phone": "081234567890"
    }
    ''';

    print(jsonString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pelanggan PT. Evan Aziz Arganta'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<UserModel>>(
        future: _futureUsers,
        builder: (context, snapshot) {

          // Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Error
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Terjadi Kesalahan:\n${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
            );
          }

          // Jika data berhasil
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            List<UserModel> users = snapshot.data!;

            return ListView.builder(
              itemCount: users.length,
              padding: const EdgeInsets.all(8.0),
              itemBuilder: (context, index) {

                UserModel user = users[index];

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(
                    vertical: 6.0,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Text(
                        user.name[0],
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),

                    title: Text(
                      user.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    subtitle: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text('@${user.username}'),
                        Text('✉️ ${user.email}'),
                        Text('📞 ${user.phone}'),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          // Jika kosong
          return const Center(
            child: Text(
              'Tidak ada data pengguna.',
            ),
          );
        },
      ),
    );
  }
}