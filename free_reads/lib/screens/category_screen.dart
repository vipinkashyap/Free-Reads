import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:free_reads/models/list_info.dart';
import 'package:free_reads/screens/screens.dart';
import 'package:free_reads/services/api_services/nyt_api_service.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Book Categories',
          style: GoogleFonts.merriweather(),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: NytApiService().fetchBookCategories(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  var result = ListInfo.fromJson(snapshot.data[index]);
                  var displayName = result.displayName;

                  return ListTile(
                      title: TextButton(
                    style: const ButtonStyle(
                        alignment: Alignment.centerLeft, enableFeedback: true),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        displayName,
                        style: GoogleFonts.merriweather(
                            color: Colors.white, fontSize: 20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ListPreviewScreen(
                          listTitle: result.displayName,
                          encodedName: result.encodedName,
                        );
                      }));
                    },
                  ));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    color: Colors.grey,
                  );
                },
                itemCount: snapshot.data.length);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
