import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../controller/dataService.dart';
import '../../model/player.dart';


class SelectPlayerScreen extends StatefulWidget {
  final String position;
  final double bank;
  final Function(Player) onPlayerSelected;

  const SelectPlayerScreen({
    super.key,
    required this.position,
    required this.onPlayerSelected, required this.bank,
  });

  @override
  State<SelectPlayerScreen> createState() => _SelectPlayerScreenState();
}

class _SelectPlayerScreenState extends State<SelectPlayerScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Player> filteredPlayers = [];
  String selectedClub = 'All Clubs';
  String selectedPrice = 'All';
  final DataService _dataService = DataService();

  @override
  void initState() {

    super.initState();
    _loadPlayers();
  }

  void _loadPlayers() {
    setState(() {
      filteredPlayers = _dataService.getPlayersByPosition(widget.position);
    });
    print('Loaded ${filteredPlayers.length} players for position ${widget.position}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add_player'.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
      width: MediaQuery.of(context).size.width*0.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),  // Adjust the radius as needed
                topRight: Radius.circular(20),
              ),
              color: Colors.purple[900],
            ),

            // padding: const EdgeInsets.all(16),
            child: Text(
              'Bank £${widget.bank}m', // Replace with actual bank value
              style: const TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.grey[200],
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Row(
                children: [

                  DropdownButton<String>(
                    value: widget.position,
                    items: ['GKP', 'DEF', 'MID', 'FWD'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: null, // Disabled as position is fixed
                  ),

                  const SizedBox(width: 4),
                  Expanded(
                    child: DropdownButton<String>(
                      value: selectedPrice,
                      items: ['All', 'Affordable', 'Premium'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedPrice = newValue;
                            // Implement price filtering
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: DropdownButton<String>(
                      value: selectedClub,
                      items: _dataService.getAllClubs().map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedClub = newValue;
                            // Implement club filtering
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: filteredPlayers.isEmpty
                ? Center(
              child: Text(
                'No players found for ${widget.position}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            )
                : ListView.builder(
              itemCount: filteredPlayers.length,
              itemBuilder: (context, index) {
                final player = filteredPlayers[index];
                return ListTile(
                  leading: Image.network(
                    player.kitImageUrl,
                    width: 40,
                    height: 40,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        player.kitImageUrl,
                        height: 40,
                        width: 40,
                      );
                    },
                  ),
                  title: Text(player.name),
                  subtitle: Text(player.clubName),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('£${player.price}m'),
                      Text('Form: ${player.form ?? 'N/A'}'),
                    ],
                  ),
                  onTap: () {
                    widget.onPlayerSelected(player);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}