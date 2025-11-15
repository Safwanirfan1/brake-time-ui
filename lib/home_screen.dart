// import 'package:flutter/material.dart';
// import 'chatbot_screen.dart';
// import 'tracker_screen.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     const Color darkGreen = Color(0xFF006400);
//     const Color lightGreen = Color(0xFF32CD32);

//     return Scaffold(
//       backgroundColor: Colors.white,
     
//       appBar: AppBar(
//   backgroundColor: Colors.white,
//   elevation: 0,
//   leading: IconButton(
//     icon: const Icon(Icons.logout_outlined, color: Colors.black87),
//     onPressed: () {
//       Navigator.of(context).pushReplacementNamed('/login');
//     },
//   ),
//   title: RichText(
//     textAlign: TextAlign.center,
//     text: const TextSpan(
//       children: [
//         TextSpan(
//           text: 'Brake',
//           style: TextStyle(
//             color: Color(0xFF006400), // dark green
//             fontSize: 40,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         TextSpan(
//           text: 'Time',
//           style: TextStyle(
//             color: Color(0xFF32CD32), // light green
//             fontSize: 40,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     ),
//   ),
//   centerTitle: true,
//   actions: [
//     IconButton(
//       icon: const Icon(Icons.notifications_none_sharp, color: Colors.black87),
//       onPressed: () {
//         // alarm icon click action (optional)
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('notification feature coming soon')),
//         );
//       },
//     ),
//   ],
// ),

//       body: SafeArea(
//   child: Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         const SizedBox(height: 8),

//         // Centered cards block with "choose option" text just above
//         Expanded(
//           child: Center(
//             child: ConstrainedBox(
//               constraints: const BoxConstraints(maxWidth: 520),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Center(
//                     child: Text(
//                       'Choose an option to continue',
//                       style: TextStyle(color: Color(0xFF555555), fontSize: 15),
//                     ),
//                   ),
//                   const SizedBox(height: 50),

//                   // First card: Chat Bot
//                   GestureDetector(
//                     onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ChatScreen())),
//                     child: Container(
//                       height: 92,
//                       margin: const EdgeInsets.only(bottom: 16),
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFF7F7F7),
//                         borderRadius: BorderRadius.circular(18),
//                         boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))],
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 56,
//                             height: 56,
//                             decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
//                             child: const Icon(Icons.android, color: Color(0xFF006400), size: 30),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: const [
//                                 Text('BTCM BOT', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                                 SizedBox(height: 6),
//                                 Text('Get instant assistance and support', style: TextStyle(fontSize: 13, color: Color(0xFF777777))),
//                               ],
//                             ),
//                           ),
//                           const Icon(Icons.arrow_forward_ios, color: Colors.black54, size: 18),
//                         ],
//                       ),
//                     ),
//                   ),

//                   // Second card: Tracker
//                   GestureDetector(
//                     onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TrackerScreen())),
//                     child: Container(
//                       height: 92,
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFF7F7F7),
//                         borderRadius: BorderRadius.circular(18),
//                         boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))],
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 56,
//                             height: 56,
//                             decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
//                             child: const Icon(Icons.location_on, color: Color(0xFF006400), size: 30),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: const [
//                                 Text('Tracker', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                                 SizedBox(height: 6),
//                                 Text('Find nearby stores and locations', style: TextStyle(fontSize: 13, color: Color(0xFF777777))),
//                                 Text('coming soon', style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 31, 30, 30))),
//                               ],
//                             ),
//                           ),
//                           const Icon(Icons.arrow_forward_ios, color: Colors.black54, size: 18),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   ),
// ),

//     );
//   }
// } 
import 'package:flutter/material.dart';
import 'chatbot_screen.dart';
import 'tracker_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color darkGreen = Color(0xFF006400);
    const Color lightGreen = Color(0xFF32CD32);

    final Size screenSize = MediaQuery.of(context).size;
    final bool isLandscape = screenSize.width > screenSize.height;
    final bool isTablet = screenSize.width > 600;

    final double cardHeight = isTablet ? 120 : 92;
    final double iconSize = isTablet ? 40 : 30;
    final double fontSizeTitle = isTablet ? 20 : 16;
    final double fontSizeSubtitle = isTablet ? 14 : 12;
    final double titleFont = isTablet ? 48 : 40;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.logout_outlined, color: Colors.black87),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/login');
          },
        ),
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Brake',
                  style: TextStyle(
                    color: darkGreen,
                    fontSize: titleFont,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'Time',
                  style: TextStyle(
                    color: lightGreen,
                    fontSize: titleFont,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_sharp, color: Colors.black87),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notification feature coming soon')),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 32 : 20,
                    vertical: isTablet ? 30 : 18,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 8),
                      Center(
                        child: Text(
                          'Choose an option to continue',
                          style: TextStyle(
                            color: const Color(0xFF555555),
                            fontSize: isTablet ? 18 : 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: isTablet ? 60 : 50),

                      // Responsive Layout for Portrait & Landscape
                      Expanded(
                        child: isLandscape
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: _buildOptionCard(
                                      context: context,
                                      icon: Icons.android,
                                      title: 'BTCM BOT',
                                      subtitle: 'Get instant assistance and support',
                                      cardHeight: cardHeight,
                                      iconSize: iconSize,
                                      fontSizeTitle: fontSizeTitle,
                                      fontSizeSubtitle: fontSizeSubtitle,
                                      onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(builder: (_) => const ChatScreen()),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: _buildOptionCard(
                                      context: context,
                                      icon: Icons.location_on,
                                      title: 'Tracker',
                                      subtitle: 'Find nearby stores and locations (coming soon)',
                                      cardHeight: cardHeight,
                                      iconSize: iconSize,
                                      fontSizeTitle: fontSizeTitle,
                                      fontSizeSubtitle: fontSizeSubtitle,
                                      onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(builder: (_) => const TrackerScreen()),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildOptionCard(
                                      context: context,
                                      icon: Icons.android,
                                      title: 'BTCM BOT',
                                      subtitle: 'Get instant assistance and support',
                                      cardHeight: cardHeight,
                                      iconSize: iconSize,
                                      fontSizeTitle: fontSizeTitle,
                                      fontSizeSubtitle: fontSizeSubtitle,
                                      onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(builder: (_) => const ChatScreen()),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    _buildOptionCard(
                                      context: context,
                                      icon: Icons.location_on,
                                      title: 'Tracker',
                                      subtitle: 'Find nearby stores and locations (coming soon)',
                                      cardHeight: cardHeight,
                                      iconSize: iconSize,
                                      fontSizeTitle: fontSizeTitle,
                                      fontSizeSubtitle: fontSizeSubtitle,
                                      onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(builder: (_) => const TrackerScreen()),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required double cardHeight,
    required double iconSize,
    required double fontSizeTitle,
    required double fontSizeSubtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: cardHeight,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 6, offset: const Offset(0, 3)),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: cardHeight * 0.6,
              height: cardHeight * 0.6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: const Color(0xFF006400), size: iconSize),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      title,
                      style: TextStyle(fontSize: fontSizeTitle, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Flexible(
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: fontSizeSubtitle,
                        color: const Color(0xFF777777),
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.arrow_forward_ios, color: Colors.black54, size: 16),
          ],
        ),
      ),
    );
  }
}
