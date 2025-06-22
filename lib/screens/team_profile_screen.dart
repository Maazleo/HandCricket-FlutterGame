import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TeamProfileScreen extends StatefulWidget {
  const TeamProfileScreen({Key? key}) : super(key: key);

  @override
  State<TeamProfileScreen> createState() => _TeamProfileScreenState();
}

class _TeamProfileScreenState extends State<TeamProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String teamName = '';
  List<String> playerNames = List.generate(11, (i) => '');
  List<String> roles = List.generate(11, (i) => 'Batter');
  int captainIndex = 0;
  int wicketKeeperIndex = 0;
  List<String> roleOptions = [
    'Opener', 'Batter', 'Allrounder', 'Bowler', 'Wicket Keeper'
  ];

  Future<void> saveTeamProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final teamProfile = {
      'teamName': teamName,
      'playerNames': playerNames,
      'roles': roles,
      'captainIndex': captainIndex,
      'wicketKeeperIndex': wicketKeeperIndex,
    };
    await prefs.setString('teamProfile', jsonEncode(teamProfile));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Team Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Team Name', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Enter your team name'),
                onChanged: (val) => setState(() => teamName = val),
                validator: (val) => val == null || val.isEmpty ? 'Enter a team name' : null,
              ),
              const SizedBox(height: 24),
              const Text('Players', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 11,
                itemBuilder: (context, i) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Player ${i + 1} Name',
                              ),
                              onChanged: (val) => setState(() => playerNames[i] = val),
                              validator: (val) => val == null || val.isEmpty ? 'Enter name' : null,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 2,
                            child: DropdownButtonFormField<String>(
                              value: roles[i],
                              items: roleOptions.map((role) => DropdownMenuItem(
                                value: role,
                                child: Text(role),
                              )).toList(),
                              onChanged: (val) => setState(() => roles[i] = val ?? 'Batter'),
                              decoration: const InputDecoration(labelText: 'Role'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            children: [
                              Radio<int>(
                                value: i,
                                groupValue: captainIndex,
                                onChanged: (val) => setState(() => captainIndex = val!),
                              ),
                              const Text('C'),
                            ],
                          ),
                          Column(
                            children: [
                              Radio<int>(
                                value: i,
                                groupValue: wicketKeeperIndex,
                                onChanged: (val) => setState(() => wicketKeeperIndex = val!),
                              ),
                              const Text('WK'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await saveTeamProfile();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Team profile saved!')),
                      );
                    }
                  },
                  child: const Text('Save Team'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Top-level function for loading team profile
Future<Map<String, dynamic>?> loadTeamProfile() async {
  final prefs = await SharedPreferences.getInstance();
  final data = prefs.getString('teamProfile');
  if (data == null) return null;
  return jsonDecode(data);
} 