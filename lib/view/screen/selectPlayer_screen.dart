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
    required this.onPlayerSelected,
    required this.bank,
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
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPlayers();
  }

  void _loadPlayers() async {
    setState(() {
      _isLoading = true;
    });

    // Fetch players from API
    await _dataService.fetchPlayers();

    setState(() {
      filteredPlayers = _dataService.getPlayersByPosition(widget.position);
      _isLoading = false;
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
      body:
      _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          // Keep existing UI elements (bank display, dropdowns, etc.)
          // ...

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
                    player.logoUrl,
                    width: 40,
                    height: 40,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        "assets/${player.logoUrl}",
                        height: 40,
                        width: 40,
                      );
                    },
                  ),
                  title: Text(player.name),
                  subtitle: Text("${player.clubId}"),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('DZD ${player.price}m'),
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

