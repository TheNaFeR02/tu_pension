import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tu_pension/constants.dart';
import 'package:tu_pension/enums.dart';
import 'package:tu_pension/ui/screens/chat/chat_list_screen.dart';
import 'package:tu_pension/ui/screens/home/home_screen.dart';
import 'package:tu_pension/ui/screens/profile/profile_screen.dart';
import 'package:tu_pension/hooks/hasPendingNotifications.dart';
import 'package:badges/badges.dart' as badges;

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Shop Icon.svg",
                  color: MenuState.home == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, HomeScreen.routeName),
              ),
              IconButton(
                icon: SvgPicture.asset("assets/icons/Heart Icon.svg"),
                onPressed: () {},
              ),
              IconButton(
                // Verificar si hay notificaciones pendientes para mostrar el badge
                icon: FutureBuilder<bool>(
                  future: hasPendingNotifications(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!) {
                      return badges.Badge(
                        child: SvgPicture.asset(
                          "assets/icons/Chat bubble Icon.svg",
                          color: MenuState.message == selectedMenu
                              ? kPrimaryColor
                              : inActiveIconColor,
                        ),
                      );
                    } else {
                      return SvgPicture.asset(
                        "assets/icons/Chat bubble Icon.svg",
                        color: MenuState.message == selectedMenu
                            ? kPrimaryColor
                            : inActiveIconColor,
                      );
                    }
                  },
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, ChatListScreen.routeName),
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/User Icon.svg",
                  color: MenuState.profile == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, ProfileScreen.routeName),
              ),
            ],
          )),
    );
  }
}
