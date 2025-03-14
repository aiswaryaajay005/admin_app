import 'package:admin_app/main.dart';
import 'package:flutter/material.dart';

class AcceptedChildren extends StatefulWidget {
  const AcceptedChildren({super.key});

  @override
  State<AcceptedChildren> createState() => _AcceptedChildrenState();
}

class _AcceptedChildrenState extends State<AcceptedChildren> {
  List<Map<String, dynamic>> childlist = [];
  @override
  void initState() {
    super.initState();
    fetchChild();
  }

  Future<void> fetchChild() async {
    try {
      final response =
          await supabase.from("tbl_child").select().eq('child_status', 3);

      setState(() {
        childlist = response;
      });
    } catch (e) {
      // ignore: avoid_print
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return childlist.isEmpty
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Accepted Children",
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontFamily: 'Montserrat-Bold',
                        fontSize: 30),
                  ),
                ),
                SizedBox(height: 20),
                DataTable(
                  columnSpacing: 30,
                  headingRowHeight: 50,
                  border: TableBorder(
                    top: BorderSide(color: Colors.grey[300]!, width: 1),
                    bottom: BorderSide(color: Colors.grey[300]!, width: 1),
                    left: BorderSide(color: Colors.grey[300]!, width: 1),
                    right: BorderSide(color: Colors.grey[300]!, width: 1),
                    horizontalInside: BorderSide.none, // Removes row lines
                  ),
                  headingTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  columns: [
                    DataColumn(
                        label: Text(
                      "C.No",
                      style: TextStyle(
                        fontFamily: 'Montserrat-Regular',
                      ),
                    )),
                    DataColumn(
                        label: Text(
                      "Child Name",
                      style: TextStyle(
                        fontFamily: 'Montserrat-Regular',
                      ),
                    )),
                    DataColumn(
                        label: Text(
                      "Child Gender",
                      style: TextStyle(
                        fontFamily: 'Montserrat-Regular',
                      ),
                    )),
                    DataColumn(
                        label: Text(
                      "Child DOB",
                      style: TextStyle(
                        fontFamily: 'Montserrat-Regular',
                      ),
                    )),
                    DataColumn(
                        label: Text(
                      "Child Allergy Details",
                      style: TextStyle(
                        fontFamily: 'Montserrat-Regular',
                      ),
                    )),
                  ],
                  rows: childlist.asMap().entries.map((entry) {
                    int index = entry.key + 1; // Staff index
                    Map<String, dynamic> child = entry.value;
                    return DataRow(cells: [
                      DataCell(Text(index.toString())), // Serial Number
                      DataCell(Text(
                        child['child_name'] ?? '',
                        style: TextStyle(
                          fontFamily: 'Montserrat-Regular',
                        ),
                      )),
                      DataCell(Text(
                        child['child_gender'] ?? '',
                        style: TextStyle(
                          fontFamily: 'Montserrat-Regular',
                        ),
                      )),
                      DataCell(Text(
                        child['child_dob'] ?? '',
                        style: TextStyle(
                          fontFamily: 'Montserrat-Regular',
                        ),
                      )),
                      DataCell(Text(
                        child['child_allergy'] ?? '',
                        style: TextStyle(
                          fontFamily: 'Montserrat-Regular',
                        ),
                      )),
                    ]);
                  }).toList(),
                ),
              ],
            ),
          );
  }
}
