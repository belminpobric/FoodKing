import 'package:flutter/material.dart';
import 'package:foodking_admin/providers/UserProvider.dart';
import 'package:foodking_admin/screens/user_insert_screen.dart';
import 'package:foodking_admin/widgets/master_screen.dart';
import 'package:foodking_admin/widgets/foodKing_text_field.dart';
import 'package:foodking_admin/widgets/User_list_item.dart';
import 'package:foodking_admin/widgets/korisnici_list_item.dart';
import 'package:foodking_admin/screens/user_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:foodking_admin/models/User.dart';
import 'package:foodking_admin/utils/pdf_utils.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late UserProvider _UserProvider;
  List<User> _Users = [];
  List<dynamic> _UsersJson = [];
  bool _isLoading = true;
  String? _selectedSortBy;
  String? _selectedSortOrder;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _UserProvider = context.read<UserProvider>();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final data = await _UserProvider.getUsers(
        searchString:
            _searchController.text.isNotEmpty ? _searchController.text : null,
        isRoleIncluded: true,
      );

      setState(() {
        final List<dynamic> UsersJson = data['result'] ?? [];
        _UsersJson = UsersJson;
        _Users = UsersJson.map((json) => User.fromJson(json)).toList();
        _applySorting();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error loading Users: $e');
    }
  }

  void _applySorting() {
    if (_selectedSortBy == null) return;

    switch (_selectedSortBy) {
      case 'Naziv A-Ž':
        _Users.sort((a, b) => (a.firstName ?? '').compareTo(b.firstName ?? ''));
        break;
      case 'Naziv Ž-A':
        _Users.sort((a, b) => (b.firstName ?? '').compareTo(a.firstName ?? ''));
        break;
    }
  }

  void _clearFilters() {
    setState(() {
      _selectedSortBy = null;
      _selectedSortOrder = null;
      _searchController.clear();
      _loadUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 40,
                    ),
                    const SizedBox(width: 24),
                    SizedBox(
                      width: 300,
                      child: FoodKingTextField(
                        labelText: 'Pretraga korisnika',
                        controller: _searchController,
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: _loadUsers,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: const BorderSide(color: Colors.blue),
                        ),
                      ),
                      child: const Text('Pretraga'),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Izvještaj se generiše...'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    await generateUsersPdf(
                      _Users,
                      onStart: () {},
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Izvještaj je spreman za preuzimanje!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text('Preuzmi izvještaj'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implement User insert
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => UserInsertScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text('Dodaj korisnika'),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Lista korisnika",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      "Sortiraj",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: DropdownButton<String>(
                        value: _selectedSortBy,
                        underline: const SizedBox(),
                        hint: const Text('Odaberi'),
                        items: ['Naziv A-Ž', 'Naziv Ž-A'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedSortBy = newValue;
                              _applySorting();
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      onPressed: _loadUsers,
                      icon: const Icon(Icons.refresh),
                      tooltip: 'Osvježi listu',
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: _clearFilters,
                      icon: const Icon(Icons.clear_all),
                      tooltip: 'Očisti filtere',
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _Users.isEmpty
                          ? const Center(child: Text('Nema korisnika'))
                          : ListView.builder(
                              itemCount: _Users.length,
                              itemBuilder: (context, index) {
                                final User = _Users[index];
                                final raw = _UsersJson[index] ?? {};
                                return KorisniciListItem(
                                  text:
                                      "${User.firstName ?? ''} ${User.lastName ?? ''} (${User.email ?? ''}) ${User.phoneNumber ?? ''}",
                                  onDetailsPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => UserDetailsScreen(
                                          userJson: raw as Map<String, dynamic>,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                ),
              ),
            ),
          ],
        ),
      ),
      appBarTitle: "Lista korisnika",
    );
  }
}
