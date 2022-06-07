import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InputEvaluasi extends StatefulWidget {
  const InputEvaluasi({Key? key}) : super(key: key);

  @override
  State<InputEvaluasi> createState() => _InputEvaluasiState();
}

class _InputEvaluasiState extends State<InputEvaluasi> {
  final _tampilNamaUser = FirebaseFirestore.instance.collection('users');
  final List<Map<String, dynamic>> _wadahNama = [];
  bool _cekTerisi(Map<String, dynamic> data) {
    return _wadahNama.where((element) => element['id'] == data['id']).isNotEmpty;
  }

  final TextEditingController evaluasiController = TextEditingController();

  CollectionReference evaluasi = FirebaseFirestore.instance.collection('evaluasi');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.amber,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('pilih pegawai'),
                  OutlinedButton(
                      onPressed: () {
                        String? queryText;
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Pilih Pegawai"),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(Icons.close))
                                  ],
                                ),
                                content: StatefulBuilder(builder: (context, state) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        onChanged: (value) {
                                          queryText = value.isEmpty ? null : value;
                                          state(() {});
                                        },
                                      ),
                                      Flexible(
                                        child: SizedBox(
                                            height: 350,
                                            width: double.maxFinite,
                                            child:
                                                // queryText != null
                                                //     ?
                                                StreamBuilder<QuerySnapshot>(
                                              stream: _tampilNamaUser
                                                  .where('name', isGreaterThan: queryText)
                                                  .where('name', isLessThan: queryText == null ? null : (queryText! + '\uf8ff'))
                                                  .snapshots(),
                                              builder: (BuildContext context, snapshot) {
                                                if (snapshot.hasError) {
                                                  return const Text("Something went wrong");
                                                }
                                                if (snapshot.hasData) {
                                                  return ListView.builder(
                                                    itemCount: snapshot.data!.docs.length,
                                                    itemBuilder: (BuildContext context, int index) {
                                                      Map<String, dynamic> data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                                                      final hasil = {
                                                        "name": data['name'],
                                                        "id": snapshot.data!.docs[index].id,
                                                      };
                                                      return Container(
                                                          child: ListTile(
                                                        title: Text(
                                                          '${data['name']}',
                                                        ),
                                                        trailing: _cekTerisi(hasil)
                                                            ? const Icon(Icons.check_circle)
                                                            : const Icon(Icons.radio_button_checked_sharp),
                                                        onTap: !_cekTerisi(hasil)
                                                            ? () {
                                                                _wadahNama.add(hasil);
                                                                setState(() {});
                                                                print(_wadahNama);
                                                                state(() {});
                                                              }
                                                            : null,
                                                      )

                                                          // Text(
                                                          //     '${data['name']}'
                                                          // ),
                                                          );
                                                    },
                                                  );
                                                }
                                                return Text("Loading");
                                              },
                                            )
                                            // : Center(
                                            //     child: Text(
                                            //         "Ketik untuk mencari")),
                                            ),
                                      )
                                    ],
                                  );
                                }),
                              );
                            });
                      },
                      child: Text("pilih"))
                ],
              ),
              Container(
                width: double.infinity,
                height: 300,
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Wrap(
                      children: List.generate(
                          _wadahNama.length,
                          (index) => InputChip(
                                label: Text(_wadahNama.elementAt(index)['name']),
                                onPressed: () {
                                  debugPrint('input chip tapped');
                                },
                                onDeleted: () {
                                  debugPrint('input chip when onDeleted');
                                  _wadahNama.removeAt(index);
                                  setState(() {});
                                },
                                deleteIcon: Icon(Icons.delete_forever),
                              )).toList()),
                ),
                // child: ListView.builder(
                //   scrollDirection: Axis.horizontal,
                //   shrinkWrap: true,
                //   itemCount: 10,
                //   itemBuilder: (BuildContext context, int index) {
                // return InputChip(
                //   label: Text('coderkotlin@gmail.com'),
                //   onPressed: () {
                //     debugPrint('input chip tapped');
                //   },
                //   avatar: CircleAvatar(
                //     backgroundImage: NetworkImage(
                //         'http://api.bengkelrobot.net:8001/assets/images/yudi.jpeg'),
                //   ),
                //   onDeleted: () {
                //     debugPrint('input chip when onDeleted');
                //   },
                //   deleteIcon: Icon(Icons.delete_forever),
                // );
                //   },
                // ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  width: double.infinity,
                  height: 200,
                  color: Colors.white,
                  child: TextField(
                    controller: evaluasiController,
                    maxLines: 9,
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    evaluasi
                        .add({'evaluasi': evaluasiController.text, 'dibuatPada': DateTime.now(), 'tujuan': _wadahNama.map((e) => e['id']).toList()});
                    evaluasiController.text = '';
                    print(_wadahNama);
                  },
                  child: Text("post"))
            ],
          ),
        )));
  }
}
