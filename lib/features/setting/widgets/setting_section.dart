import 'package:flutter/material.dart';
import 'package:retrofit_bloc_go_router_getit/features/setting/widgets/setting_tile.dart';

class SettingSection extends StatelessWidget {
  final String sectionTitle;
  final List<SettingTile> tiles;
  const SettingSection({super.key, required this.tiles, required this.sectionTitle,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              sectionTitle,
              style:const  TextStyle(fontSize: 20.0),
            ),
          ),
          for (final tile in tiles)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: tile,
            ),
        ],
      ),
    );
  }
}