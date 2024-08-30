import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skillforge_ai/models/user.dart';
import 'package:skillforge_ai/services/auth_service.dart';
import 'package:skillforge_ai/widgets/button.dart';

class ConnectionsScreen extends StatefulWidget {
  const ConnectionsScreen({super.key});

  @override
  ConnectionsScreenState createState() => ConnectionsScreenState();
}

class ConnectionsScreenState extends State<ConnectionsScreen> {
  List<User> _suggestedConnections = [];

  @override
  void initState() {
    super.initState();
    _fetchSuggestedConnections();
  }

  Future<void> _fetchSuggestedConnections() async {
    // Simulate a network call
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _suggestedConnections = [
        User(id: '1', name: 'John Doe', email: 'john.doe@example.com'),
        User(id: '2', name: 'Jane Smith', email: 'jane.smith@example.com'),
        // Add more users as needed
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context).currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Connections'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple.shade50, Colors.white],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Network',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.deepPurple.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${user?.connections.length ?? 0} Connections',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    ...(user?.connections ?? []).map((connection) =>
                        _buildConnectionTile(context, connection)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Suggested Connections',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.deepPurple.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    _suggestedConnections.isEmpty
                        ? const Text('No suggested connections at the moment.')
                        : Column(
                            children: _suggestedConnections
                                .map((connection) =>
                                    _buildConnectionTile(context, connection))
                                .toList(),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConnectionTile(BuildContext context, User connection) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.deepPurple.shade200,
        child: Text(
          connection.name.substring(0, 1).toUpperCase(),
          style: TextStyle(color: Colors.deepPurple.shade700),
        ),
      ),
      title: Text(connection.name),
      subtitle: Text(connection.email),
      trailing: Button(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Messaging ${connection.name}...')),
          );
        },
        text: 'Message',
      ),
    );
  }
}
