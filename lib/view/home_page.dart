import 'package:flutter/material.dart';
import 'package:meuapp/controller/course_controller.dart';
import 'package:meuapp/model/course_model.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<CourseEntity>> coursesFuture;
  CourseController controller = CourseController();

  Future<List<CourseEntity>> getCourses() async {
      return await controller.getCourseList();
  }

  @override
  void initState() {
    super.initState();
    coursesFuture = getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Meu app"),
        ),
        body: FutureBuilder(
          future: coursesFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      title: Text(snapshot.data![index].name ?? ''),
                      leading: const CircleAvatar(
                        child: Text("CS"),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      subtitle: Text(snapshot.data![index].description ?? ''),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
