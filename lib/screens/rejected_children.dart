import 'package:admin_app/main.dart';
import 'package:flutter/material.dart';

class RejectedChildren extends StatefulWidget {
  const RejectedChildren({super.key});

  @override
  State<RejectedChildren> createState() => _RejectedChildrenState();
}

class _RejectedChildrenState extends State<RejectedChildren> {
  List<Map<String, dynamic>> childlist = [];
  @override
  void initState() {
    super.initState();
    fetchChild(2);
  }

  Future<void> fetchChild(int status) async {
    try {
      final response =
          await supabase.from("tbl_child").select().eq('child_status', status);

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
                    "Rejected Children",
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontFamily: 'Montserrat-Bold',
                        fontSize: 30),
                  ),
                ),
                SizedBox(height: 20),
                DataTable(
                  border: TableBorder.all(),
                  headingTextStyle: TextStyle(fontWeight: FontWeight.bold),
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
