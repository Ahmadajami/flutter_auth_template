import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:retrofit_bloc_go_router_getit/features/auth/blocs/auth.dart';
import 'package:retrofit_bloc_go_router_getit/features/setting/widgets/setting_section.dart';
import 'package:retrofit_bloc_go_router_getit/features/setting/widgets/setting_tile.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(
        children:  [

          SettingSection(
            sectionTitle: "Pref",
            tiles: [
              SettingTile(
                  prefixIcon: Icons.room_preferences ,
                  title: "Theme",
                  desc: "Change Your Theme",
                  suffixOnPressed:() {
                    context.push("/setting/theme");

                  },
                  suffixIcon:Icons.arrow_forward_ios_outlined),
            ],
          ),

          SettingSection(
            sectionTitle: "Profile",
            tiles: [
              SettingTile(
                  prefixIcon: Icons.person ,
                  title: "Profile",
                  desc: "Logout",
                  suffixOnPressed:() {
                    context.read<AuthBloc>().add(AuthLogoutRequested());

                  },
                  suffixIcon:Icons.logout),
            ],
          ),

        ],
      ),
    );
  }
}




