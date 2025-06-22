import 'package:flutter/material.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Placeholder data; in the future, load from SharedPreferences
    final List<Map<String, dynamic>> stats = [
      {'match': 1, 'runs': 45, 'wickets': 2, 'result': 'Won'},
      {'match': 2, 'runs': 12, 'wickets': 1, 'result': 'Lost'},
      {'match': 3, 'runs': 67, 'wickets': 0, 'result': 'Won'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Stats'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Previous Matches',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: stats.length,
                itemBuilder: (context, index) {
                  final stat = stats[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text('${stat['match']}'),
                      ),
                      title: Text('Runs: ${stat['runs']}  |  Wickets: ${stat['wickets']}'),
                      trailing: Text(
                        stat['result'],
                        style: TextStyle(
                          color: stat['result'] == 'Won' ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
} 