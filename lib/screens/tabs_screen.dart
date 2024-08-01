import 'package:flutter/material.dart';
import 'package:todoapp/screens/drawer.dart';
import 'package:todoapp/screens/pending_screen.dart';

import '../utils/colors.dart';
import 'add_task_screen.dart';
import 'completed_task.dart';
import 'favourite_screen.dart';

class TabScreen extends StatelessWidget {
  const TabScreen({super.key});
  static const id = "tabs_screen";

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController detailController = TextEditingController();

    final PageController pageController = PageController();

    void _addTask(BuildContext context) {
      showModalBottomSheet(
        backgroundColor: primaryColors,
        context: context,
        builder: (context) => SingleChildScrollView(
          child: AddTaskScreen(
            titleController: titleController,
            detailController: detailController,
          ),
        ),
      );
    }

    void _onItemTapped(int index) {
      pageController.jumpToPage(index);
    }

    return Scaffold(
      drawer: MyDrawer(),
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {},
        children: [
          PendingScreen(),
          CompletedScreen(),
          FavouriteScreen(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColors,
        onPressed: () => _addTask(context),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:
            pageController.hasClients ? pageController.page?.toInt() ?? 0 : 0,
        onTap: _onItemTapped,
        selectedItemColor: primaryColors,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Pending",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: "Completed",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorite",
          ),
        ],
      ),
    );
  }
}
