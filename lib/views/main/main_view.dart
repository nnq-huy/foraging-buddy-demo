import 'package:flutter/material.dart';
import 'package:foraging_buddy/views/constants/styles.dart';
import 'package:foraging_buddy/views/main/user_profile_page.dart';
import 'package:foraging_buddy/views/tabs/guides/guide_by_search_term_view.dart';
import 'package:foraging_buddy/views/tabs/user_results/user_results_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:foraging_buddy/state/auth/providers/auth_state_provider.dart';
import 'package:foraging_buddy/views/components/dialogs/alert_dialog_model.dart';
import 'package:foraging_buddy/views/components/dialogs/logout_dialog.dart';
import 'package:foraging_buddy/views/constants/strings.dart';
import 'package:foraging_buddy/views/tabs/user_posts/user_posts_view.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  int _selectedIndex = 0;
  String _selectedTitle = Strings.guides;
  static const List<Widget> _widgetOptions = <Widget>[
    GuideSearchView(),
    UserPostsView(),
    UserResultsView(),
  ];
  final screenTitle = [
    Strings.guides,
    Strings.pickingSpots,
    Strings.identifier
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _selectedTitle = screenTitle[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_selectedTitle),
          actions: [
            //user profile setting button
            IconButton(
              onPressed: () async {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const UserProfilePage()));
              },
              icon: const Icon(
                Icons.person,
              ),
            ),
            //log out button
            IconButton(
              onPressed: () async {
                final shouldLogOut =
                    await const LogoutDialog().present(context).then(
                          (value) => value ?? false,
                        );
                if (shouldLogOut) {
                  await ref.read(authStateProvider.notifier).logOut();
                }
              },
              icon: const Icon(
                Icons.logout,
              ),
            ),
          ],
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 30,
          selectedFontSize: 16,
          unselectedFontSize: 8,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.book,
              ),
              label: Strings.guides,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
              ),
              label: Strings.pickingSpots,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search_sharp,
              ),
              label: Strings.identifier,
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
