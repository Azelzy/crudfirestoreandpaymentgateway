import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      appBar: isTablet ? null : AppBar(
        title: const Text('PROFILE', style: TextStyle(fontWeight: FontWeight.black)),
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(color: Colors.black, height: 2),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 3),
        ),
        child: ListView(
          padding: EdgeInsets.all(isTablet ? 40 : 16),
          children: [
            Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: isTablet ? 600 : double.infinity,
                ),
                child: Column(
                  children: [
                    // BAGIAN GAMBAR PNG
                    Container(
                      width: isTablet ? 160 : 140,
                      height: isTablet ? 160 : 140,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEB8D9F),
                        border: Border.all(color: Colors.black, width: 4),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(4, 4),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/profile.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.person,
                            size: 80,
                            color: Colors.black,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: isTablet ? 32 : 24),
                    
                    Container(
                      padding: EdgeInsets.all(isTablet ? 20 : 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF9B97D1),
                        border: Border.all(color: Colors.black, width: 3),
                      ),
                      child: Text(
                        'GUEST USER',
                        style: TextStyle(
                          fontSize: isTablet ? 32 : 24,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -1,
                        ),
                      ),
                    ),
                    SizedBox(height: isTablet ? 32 : 24),
                    
                    _buildInfoCard(
                      'EMAIL',
                      'guest@burgerqueen.com',
                      Icons.email,
                      isTablet,
                    ),
                    SizedBox(height: isTablet ? 20 : 12),
                    
                    _buildInfoCard(
                      'PHONE',
                      '+62 000-000-000',
                      Icons.phone,
                      isTablet,
                    ),
                    SizedBox(height: isTablet ? 20 : 12),
                    
                    _buildInfoCard(
                      'ADDRESS',
                      'Jl. Contoh No. 123, Semarang',
                      Icons.location_on,
                      isTablet,
                    ),
                    SizedBox(height: isTablet ? 32 : 24),
                    
                    _buildActionButton(
                      'EDIT PROFILE',
                      const Color(0xFFBDDAF0),
                      Icons.edit,
                      () {},
                      isTablet,
                    ),
                    SizedBox(height: isTablet ? 20 : 12),
                    
                    _buildActionButton(
                      'SETTINGS',
                      const Color(0xFFFCDCB3),
                      Icons.settings,
                      () {},
                      isTablet,
                    ),
                    SizedBox(height: isTablet ? 20 : 12),
                    
                    _buildActionButton(
                      'LOGOUT',
                      const Color(0xFFEB8D9F),
                      Icons.logout,
                      () {},
                      isTablet,
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

  Widget _buildInfoCard(String label, String value, IconData icon, bool isTablet) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isTablet ? 24 : 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFCDCB3),
        border: Border.all(color: Colors.black, width: 3),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(isTablet ? 14 : 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Icon(icon, color: Colors.black, size: isTablet ? 32 : 24),
          ),
          SizedBox(width: isTablet ? 20 : 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFBDDAF0),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: isTablet ? 13 : 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                SizedBox(height: isTablet ? 10 : 8),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: isTablet ? 18 : 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String text,
    Color bgColor,
    IconData icon,
    VoidCallback onTap,
    bool isTablet,
  ) {
    return Container(
      width: double.infinity,
      height: isTablet ? 68 : 56,
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: Colors.black, width: 3),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isTablet ? 28 : 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, color: Colors.black, size: isTablet ? 30 : 24),
                    SizedBox(width: isTablet ? 20 : 12),
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: isTablet ? 20 : 16,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                  size: isTablet ? 30 : 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}