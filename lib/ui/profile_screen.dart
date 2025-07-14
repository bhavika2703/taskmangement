import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Gradient background
              Container(
                height: 200,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepOrangeAccent, Colors.orange],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),

              // Positioned Profile Avatar
              Positioned(
                bottom: -50,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    // Profile image with circular border
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        child: Icon(
                          Icons.person,
                          size: 20,
                          color: Colors.white,
                        ),
                        /* backgroundImage: AssetImage(
                          'assets/profile.jpg',
                        ), */
                        // Replace with your asset
                      ),
                    ),
                    // Edit icon
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(4),
                        child: Icon(Icons.edit, size: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 60),
          const Text(
            'John Doe',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            'Marketing Manager',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 40),
          _buildMenuTile(
            icon: Icons.edit,
            title: "Edit Profile",
            onTap: () {},
            traling: const Icon(Icons.arrow_forward_rounded, size: 20),
          ),
          _buildMenuTile(
            icon: Icons.lock,
            title: "Change Password",
            traling: const Icon(Icons.arrow_forward_rounded, size: 20),
            onTap: () {},
          ),
          _buildMenuTile(icon: Icons.logout, title: "Log out", onTap: () {}),
        ],
      ),
    );
  }

  Column buildProfileAvtraview() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 50,
              /* backgroundImage: AssetImage(
                      'assets/profile.jpg',
                    ),*/
              child: Icon(Icons.person), // change path
            ),
            Positioned(
              bottom: 4,
              right: 4,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange,
                ),
                padding: const EdgeInsets.all(4),
                child: const Icon(Icons.edit, color: Colors.white, size: 16),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          "John Doe",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Text("Marketing Manager", style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Widget? traling,
  }) {
    return ListTile(
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: Colors.orange.shade50,
        child: Icon(icon, color: Colors.deepOrange),
      ),
      title: Text(title),
      trailing: traling,
      onTap: onTap,
    );
  }
}
