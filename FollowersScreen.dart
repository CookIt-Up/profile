// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class FollowersScreen extends StatelessWidget {
//   final String userEmail;

//   FollowersScreen({required this.userEmail});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Followers',
//           style: TextStyle(fontSize: 20), // Reduced text size
//         ),
//         toolbarHeight: 50, // Reduced app bar height
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection("users")
//             .doc(userEmail)
//             .collection("followers")
//             .snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//           if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
//             return Center(child: Text('No followers yet.'));
//           }
//           return Container(
//             color: Colors.green[100], // Set background color to green
//             child: ListView.builder(
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 var followerDoc = snapshot.data!.docs[index];
//                 var followerEmail = followerDoc.id; // Get the follower's email
//                 return FutureBuilder<DocumentSnapshot>(
//                   future: FirebaseFirestore.instance
//                       .collection('users')
//                       .doc(
//                           followerEmail) // Fetch user data using follower's email
//                       .get(),
//                   builder: (context, userSnapshot) {
//                     if (userSnapshot.connectionState ==
//                         ConnectionState.waiting) {
//                       return ListTile(
//                         title: Text('Loading...'),
//                       );
//                     }
//                     if (userSnapshot.hasError) {
//                       return ListTile(
//                         title: Text('Error: ${userSnapshot.error}'),
//                       );
//                     }
//                     if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
//                       return ListTile(
//                         title: Text('User not found'),
//                       );
//                     }
//                     var userData = userSnapshot.data!;
//                     return ListTile(
//                       leading: CircleAvatar(
//                         backgroundImage:
//                             NetworkImage(userData['profilepic'] ?? ''),
//                       ),
//                       title: Text(userData['name'] ?? ''),
//                     );
//                   },
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'uploader_profile.dart'; // Import the uploader_profile.dart file

class FollowersScreen extends StatelessWidget {
  final String userEmail;

  FollowersScreen({required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Followers',
          style: TextStyle(fontSize: 20), // Reduced text size
        ),
        toolbarHeight: 50, // Reduced app bar height
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(userEmail)
            .collection("followers")
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No followers yet.'));
          }
          return Container(
            color: Colors.green[100], // Set background color to green
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var followerDoc = snapshot.data!.docs[index];
                var followerEmail = followerDoc.id; // Get the follower's email
                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(
                          followerEmail) // Fetch user data using follower's email
                      .get(),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return ListTile(
                        title: Text('Loading...'),
                      );
                    }
                    if (userSnapshot.hasError) {
                      return ListTile(
                        title: Text('Error: ${userSnapshot.error}'),
                      );
                    }
                    if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                      return ListTile(
                        title: Text('User not found'),
                      );
                    }
                    var userData = userSnapshot.data!;
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UploaderProfilePage(
                                email:
                                    followerEmail), // Navigate to uploader_profile.dart
                          ),
                        );
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(userData['profilepic'] ?? ''),
                        ),
                        title: Text(userData['name'] ?? ''),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
