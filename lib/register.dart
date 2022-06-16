import 'package:flutter/material.dart';
import 'package:realtime_gps/admin/register_admin.dart';
import 'package:realtime_gps/user/register_user.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  List<Widget> _listPage = [
    RegisterAdminScreen(),
    RegisterUserScreen(),
  ];
  PageController _pageController = PageController();
  int currentIndex = 0;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, keepPage: true);
    print("${_pageController.initialPage}");
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.green,
        ),
      ),
      body: SafeArea(
          child: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              headerButton(),
              SizedBox(
                height: 25,
              ),
              Expanded(
                child: PageView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (value) {
                      print("PAGE KE : $value");
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                    controller: _pageController,
                    itemCount: _listPage.length,
                    itemBuilder: (context, index) {
                      return _listPage[index];
                    }),
              )
            ],
          ),
        ),
      )),
    );
  }

  Widget headerButton() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            style: TextButton.styleFrom(
                backgroundColor:
                    selectedIndex == 0 ? Colors.green : Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(color: Colors.green))),
            onPressed: () {
              _pageController.previousPage(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut);
            },
            child: Text(
              "Admin",
              style: TextStyle(
                color: selectedIndex == 0 ? Colors.white : Colors.green,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          TextButton(
            style: TextButton.styleFrom(
                backgroundColor:
                    selectedIndex == 1 ? Colors.green : Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(color: Colors.green))),
            onPressed: () {
              _pageController.nextPage(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut);
            },
            child: Text(
              "User",
              style: TextStyle(
                color: selectedIndex == 1 ? Colors.white : Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
