import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final List<dynamic> transactions;
  final List<dynamic> transaksi;

  const AppDrawer({
    Key? key,
    required this.transactions,
    required this.transaksi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              'Kelompok 2',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            accountEmail: Text(
              'kelompok2@gmail.com',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/wa.jpg'),
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 77, 70, 218),
            ),
          ),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text('Film'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/films');
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Tambah Film'),
            onTap: () {
              Navigator.of(context).pushNamed('/films');
            },
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Data Transaksi'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/transactions');
            },
          ),
          ListTile(
            leading: Icon(Icons.data_usage),
            title: Text('Data Master'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/data_master');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              _logout(context); // Call logout function
            },
          ),
        ],
      ),
    );
  }

  void _logout(BuildContext context) {
    // Clear authentication token or perform logout operations
    // Here you can add code to clear user session or token
    // For example, using shared preferences:
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.remove('auth_token');

    // Navigate to login screen and remove all previous routes
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }
}
