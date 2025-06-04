import 'package:flutter/material.dart';
import 'package:foodking_admin/providers/StaffProvider.dart';
import 'package:foodking_admin/screens/staff_insert_screen.dart';
import 'package:foodking_admin/widgets/master_screen.dart';
import 'package:foodking_admin/widgets/foodKing_text_field.dart';
import 'package:foodking_admin/widgets/staff_list_item.dart';
import 'package:provider/provider.dart';
import 'package:foodking_admin/models/staff.dart';
import 'package:foodking_admin/utils/pdf_utils.dart';

class StaffListScreen extends StatefulWidget {
  const StaffListScreen({super.key});

  @override
  State<StaffListScreen> createState() => _StaffListScreenState();
}

class _StaffListScreenState extends State<StaffListScreen> {
  late StaffProvider _staffProvider;
  List<Staff> _staffs = [];
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
    _staffProvider = context.read<StaffProvider>();
    _loadStaffs();
  }

  Future<void> _loadStaffs() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final data = await _staffProvider.getStaffs(
        searchString:
            _searchController.text.isNotEmpty ? _searchController.text : null,
      );

      setState(() {
        final List<dynamic> staffsJson = data['result'] ?? [];
        _staffs = staffsJson.map((json) => Staff.fromJson(json)).toList();
        _applySorting();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error loading staffs: $e');
    }
  }

  void _applySorting() {
    if (_selectedSortBy == null) return;

    switch (_selectedSortBy) {
      case 'Naziv A-Ž':
        _staffs
            .sort((a, b) => (a.firstName ?? '').compareTo(b.firstName ?? ''));
        break;
      case 'Naziv Ž-A':
        _staffs
            .sort((a, b) => (b.firstName ?? '').compareTo(a.firstName ?? ''));
        break;
    }
  }

  void _clearFilters() {
    setState(() {
      _selectedSortBy = null;
      _selectedSortOrder = null;
      _searchController.clear();
      _loadStaffs();
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
                        labelText: 'Pretraga osoblja',
                        controller: _searchController,
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: _loadStaffs,
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
                    await generateStaffsPdf(
                      _staffs,
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
                        // TODO: Implement staff insert
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => StaffInsertScreen(),
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
                      child: const Text('Dodaj osoblje'),
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
                  "Lista osoblja",
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
                      onPressed: _loadStaffs,
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
                      : _staffs.isEmpty
                          ? const Center(child: Text('Nema osoblja'))
                          : ListView.builder(
                              itemCount: _staffs.length,
                              itemBuilder: (context, index) {
                                final staff = _staffs[index];
                                return StaffListItem(
                                  text:
                                      "${staff.firstName ?? ''} ${staff.lastName ?? ''} (${staff.email ?? ''}) ${staff.phoneNumber ?? ''}",
                                );
                              },
                            ),
                ),
              ),
            ),
          ],
        ),
      ),
      appBarTitle: "Lista osoblja",
    );
  }
}
