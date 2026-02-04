import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FFF5),
      body: SafeArea(
        child: Column(
          children: [

            const SizedBox(height: 20),

            // 🔝 LOGO + APP NAME
            Column(
              children: const [
                Icon(
                  Icons.shield,
                  size: 70,
                  color: Colors.green,
                ),
                SizedBox(height: 8),
                Text(
                  "SHE-IELD",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Your Safety, Our Priority",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // 🔴 BIG SOS BUTTON
            GestureDetector(
              onTap: () {
                _showSOSDialog(context);
              },
              child: Container(
                height: 170,
                width: 170,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.redAccent.withOpacity(0.6),
                      blurRadius: 25,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "SOS",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // ⚙️ OPTIONS GRID
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                padding: const EdgeInsets.all(16),
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: const [
                  DashboardOption(icon: Icons.people, label: "Close Contact"),
                  DashboardOption(icon: Icons.call, label: "Fake Call"),
                  DashboardOption(icon: Icons.location_on, label: "Share Location"),
                  DashboardOption(icon: Icons.mic, label: "Audio Record"),
                  DashboardOption(icon: Icons.track_changes, label: "Live Track"),
                  DashboardOption(icon: Icons.vibration, label: "Shake SOS"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔔 SOS CLICK DIALOG (DEMO)
  void _showSOSDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("🚨 SOS Activated"),
        content: const Text(
          "• Trusted contacts alerted\n"
              "• Location shared\n"
              "• Police call initiated\n"
              "• Audio recording started",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}

// 🔹 OPTION TILE WIDGET
class DashboardOption extends StatelessWidget {
  final IconData icon;
  final String label;

  const DashboardOption({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.green.shade100,
          child: Icon(icon, size: 28, color: Colors.green),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
