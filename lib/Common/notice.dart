import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NoticePage extends StatefulWidget {
  final String username;

  NoticePage({required this.username});

  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  late Future<List<Map<String, String>>> _newsFuture;

  @override
  void initState() {
    super.initState();
    _newsFuture = fetchNewsData();
  }

  Future<List<Map<String, String>>> fetchNewsData() async {
    final response = await http
        .get(Uri.parse('http://localhost/fyp/app/roles/viewnotice.php'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      final List<Map<String, String>> newsList = [];

      for (var item in responseData) {
        newsList.add({
          'image': 'assets/General/notice.jpg',
          'title': item['title'].toString(),
          'description': item['message'].toString(),
          'post_date': item['post_date'].toString(),
        });
      }

      return newsList;
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notices',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<List<Map<String, String>>>(
          future: _newsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return NewsTile(
                    image: snapshot.data![index]['image']!,
                    title: snapshot.data![index]['title']!,
                    description: snapshot.data![index]['description']!,
                    postDate: snapshot.data![index]['post_date']!,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NewsDetailPage(news: snapshot.data![index]),
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class NewsTile extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String postDate;
  final VoidCallback onTap;

  NewsTile({
    required this.image,
    required this.title,
    required this.description,
    required this.postDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
        child: SizedBox(
          width: 80, // Adjust this width as needed
          height: 80, // Set the height equal to the width
          child: Image.asset(image, fit: BoxFit.cover),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          fontFamily: 'Raleway',
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: 'Raleway',
            ),
          ),
          SizedBox(height: 4),
          Text(
            postDate,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontFamily: 'Raleway',
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}

class NewsDetailPage extends StatelessWidget {
  final Map<String, String> news;

  NewsDetailPage({required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notice Details',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              news['image']!,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              news['title']!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Raleway',
              ),
            ),
            SizedBox(height: 10),
            Text(
              news['description']!,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Raleway',
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Post Date: ${news['post_date']}',
              style: TextStyle(
                color: Colors.grey,
                fontFamily: 'Raleway',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
