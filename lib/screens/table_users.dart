import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserTable extends StatefulWidget {
  const UserTable({Key? key}) : super(key: key);

  @override
  _UserTableState createState() => _UserTableState();
}

class _UserTableState extends State<UserTable> {
  late List<Map<String, dynamic>> _users;

  _UserTableState() {
    _users = [];
  }

  Future<void> _fetchUsers() async {
    final response = await http.get(
      Uri.parse(
          'http://localhost/flutter-project-backend/Routes/UserRoutes.php/users'),
    );

    if (response.statusCode == 200) {
      setState(() {
        _users = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> _addUser(
      String username, String email, String phone, String password) async {
    final headers = {
      'Content-Type': 'application/json',
    };

    final body = json.encode({
      "username": username,
      "email": email,
      "phone": phone,
      "password": password,
    });
    final response = await http.post(
      Uri.parse(
          'http://localhost/flutter-project-backend/Routes/UserRoutes.php/users/add'),
      headers: headers,
      body: body,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add user');
    } else {
      _fetchUsers(); // Refresh the user list after adding a user
    }
  }

  Future<void> _deleteUser(int id) async {
    final response = await http.post(
      Uri.parse(
          'http://localhost/flutter-project-backend/Routes/UserRoutes.php/users/delete'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "id": id,
      }),
    );

    if (response.statusCode == 200) {
      _fetchUsers(); // Refresh the user list after deleting a user
    } else {
      throw Exception('Failed to delete user');
    }
  }

  Future<void> _updateUser(int id, String username, String email, String phone,
      String password) async {
    final headers = {
      'Content-Type': 'application/json',
    };

    final body = json.encode({
      "id": id,
      "username": username,
      "email": email,
      "phone": phone,
      "password": password,
    });

    final response = await http.post(
      Uri.parse(
          'http://localhost/flutter-project-backend/Routes/UserRoutes.php/users/update'),
      headers: headers,
      body: body,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update user information');
    } else {
      _fetchUsers(); // Refresh the user list after updating a user
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 20.0),
      ElevatedButton(
        child: const Text('Add User'),
        onPressed: () {
          final TextEditingController _usernameController =
              TextEditingController();
          final TextEditingController _emailController =
              TextEditingController();
          final TextEditingController _phoneController =
              TextEditingController();
          final TextEditingController _passwordController =
              TextEditingController();
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Username'),
                      controller: _usernameController,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Email'),
                      controller: _emailController,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Phone'),
                      controller: _phoneController,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Password'),
                      controller: _passwordController,
                      obscureText: true,
                    ),
                    ElevatedButton(
                      child: const Text('Save'),
                      onPressed: () {
                        _addUser(
                          _usernameController.text,
                          _emailController.text,
                          _phoneController.text,
                          _passwordController.text,
                        );
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      Expanded(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Username')),
              DataColumn(label: Text('Email')),
              DataColumn(label: Text('Phone')),
              DataColumn(label: Text('Actions')),
            ],
            rows: _users.map((user) {
              return DataRow(cells: [
                DataCell(Text(user['id'])),
                DataCell(Text(user['username'])),
                DataCell(Text(user['email'])),
                DataCell(Text(user['phone'])),
                DataCell(Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        final TextEditingController _usernameController =
                            TextEditingController(text: user['username']);
                        final TextEditingController _emailController =
                            TextEditingController(text: user['email']);
                        final TextEditingController _phoneController =
                            TextEditingController(text: user['phone']);
                        final TextEditingController _passwordController =
                            TextEditingController();
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  TextField(
                                    decoration: const InputDecoration(
                                        labelText: 'Username'),
                                    controller: _usernameController,
                                  ),
                                  TextField(
                                    decoration:
                                        InputDecoration(labelText: 'Email'),
                                    controller: _emailController,
                                  ),
                                  TextField(
                                    decoration:
                                        InputDecoration(labelText: 'Phone'),
                                    controller: _phoneController,
                                  ),
                                  TextField(
                                    decoration:
                                        InputDecoration(labelText: 'Password'),
                                    controller: _passwordController,
                                    obscureText: true,
                                  ),
                                  ElevatedButton(
                                    child: const Text('Update'),
                                    onPressed: () {
                                      _updateUser(
                                        user['id'],
                                        _usernameController.text,
                                        _emailController.text,
                                        _phoneController.text,
                                        _passwordController.text,
                                      );
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                )),
              ]);
            }).toList(),
          ),
        ),
      ),
    ]);
  }
}
