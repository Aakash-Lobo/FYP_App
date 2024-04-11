import 'package:flutter/material.dart';

class InboxPage extends StatelessWidget {
  final String username;

  InboxPage({required this.username}); // Constructor to receive the username

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Inbox',
            style:
                TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: InboxList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add action for the floating action button
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class InboxList extends StatelessWidget {
  final List<Mail> mails = [
    Mail(
      sender: 'John Doe',
      subject: 'Meeting Reminder',
      body: 'Don\'t forget the meeting tomorrow at 10 AM.',
    ),
    Mail(
      sender: 'Jane Smith',
      subject: 'Report Submission',
      body: 'Please submit your weekly report by EOD today.',
    ),
    Mail(
      sender: 'Alice Johnson',
      subject: 'Project Update',
      body: 'Here\'s the latest update on our project progress.',
    ),
    Mail(
      sender: 'Bob Brown',
      subject: 'Invitation',
      body: 'You\'re invited to the team lunch this Friday.',
    ),
    Mail(
      sender: 'Emily Williams',
      subject: 'Feedback Request',
      body: 'Please provide feedback on the recent training session.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: mails.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text(
              mails[index].sender,
              style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mails[index].subject,
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  mails[index].body,
                  style: TextStyle(
                    fontFamily: 'Raleway',
                  ),
                ),
              ],
            ),
            onTap: () {
              // Add action when a mail is tapped
            },
          ),
        );
      },
    );
  }
}

class Mail {
  final String sender;
  final String subject;
  final String body;

  Mail({required this.sender, required this.subject, required this.body});
}
