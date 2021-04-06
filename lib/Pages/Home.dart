import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:smart_study/Models/Post.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smart_study/Pages/CustomDrawer.dart';
import 'package:smart_study/Widgets/AddPostWidget.dart';
import 'package:smart_study/Widgets/DetailPostWidget.dart';
import 'package:smart_study/Widgets/ListPostWidget.dart';
import 'package:smart_study/services/PostApiService.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}



class _HomeState extends State<Home> {

  bool isLoading = true;
  bool isAuthor = false;
  String username;
  String userId;

  final storage = new FlutterSecureStorage();
  final PostApiService api= new PostApiService();

  // A function that converts a response body into a List<Posts>.
  List<Post> parsePosts(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Post>((json) => Post.fromJson(json)).toList();
  }

  Future<void> fetchPosts() async {
    final response = await get(Uri.http('10.0.2.2:3000','/posts'));
    posts= parsePosts(response.body);
    String value = await storage.read(key: "jwt");
    var listPayload = parseJwt(value).values.toList();
    print(listPayload[1]);
    bool test=false;
    if (listPayload[1]=="ROLE_AUTHOR"){
      test = true;
    }

    setState(()  {
      isLoading = false;
      isAuthor = test;
      userId = listPayload[0];
      username = listPayload[2];
    });

  }

  String parseTime(String datetime) {
    //create datatime object
    DateTime now = DateTime.parse(datetime);
   String time = DateFormat.MMMMEEEEd().format(now);
   return time;
  }

  List<Post> posts=[];

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(32.0,64.0,32.0,16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.account_circle, size: 90.0,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("$username", style: TextStyle(fontSize: 20.0),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("", style: TextStyle(color: Colors.black45),),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(40.0,16.0,40.0,40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Home", style: TextStyle(fontSize: 18.0),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Forms", style: TextStyle(fontSize: 18.0),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Posts", style: TextStyle(fontSize: 18.0),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Interests", style: TextStyle(fontSize: 18.0),),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Tools", style: TextStyle(fontSize: 18.0, color: Colors.teal),),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: isAuthor? InkWell(child:Text("New Post", style: TextStyle(fontSize: 18.0),),onTap: () {
                            _navigateToAddScreen(context);
                          },):Container(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: isAuthor? InkWell(child: Text("Manage Posts", style: TextStyle(fontSize: 18.0),),onTap: () async{
                            await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ListPost()),
                            );
                          },):Container()
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(""),
                        ),
                        Divider(),
                        SizedBox(height: 50.0,),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: ListTile(
                            title: Text("LOGOUT"),
                            onTap: () {
                              storage.delete(key: "jwt");
                              Navigator.pushReplacementNamed(context, "/login");
                            },
                            leading: Icon(Icons.logout),

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      appBar: AppBar(
        title: Text("Post List",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),),elevation: 0.0,centerTitle: true,
        backgroundColor: Colors.green[300],
        iconTheme: IconThemeData(color: Colors.black87),

      ),
      body: isLoading
          ? Center(child:CircularProgressIndicator(),)
          :ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0.0,0.5,0.0,0.5),
            child: Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailPage(lesson: posts[index],)),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("${posts[index].tags}", style: TextStyle(color: Colors.black38,fontWeight: FontWeight.w500, fontSize: 16.0),),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0,12.0,0.0,12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(child: Text(posts[index].title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),), flex: 3,),
                            Flexible(
                              flex: 1,
                              child: Container(
                                  height: 80.0,
                                  width: 80.0,
                                  child: Image.network('http://10.0.2.2:3000/image/${posts[index].image}',fit: BoxFit.cover)

                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(posts[index].author, style: TextStyle(fontSize: 18.0),),
                              Text(parseTime(posts[index].dateAdded) , style: TextStyle(color: Colors.black45, fontWeight: FontWeight.w500),)
                            ],
                          ),
                          Icon(Icons.bookmark_border),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: posts.length,
      ),
      floatingActionButton: isAuthor ?FloatingActionButton(backgroundColor:Colors.black38 ,
        onPressed: () {
          _navigateToAddScreen(context);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ):null
    );
  }

  _navigateToAddScreen (BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddPostWidget(userId: userId,username: username,)),
    );



  }



  //For decoding the JWT

  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

}
