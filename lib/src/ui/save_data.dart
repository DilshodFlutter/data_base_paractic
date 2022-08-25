import 'package:data_base_paractic/src/block/data_block.dart';
import 'package:data_base_paractic/src/model/data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SaveData extends StatefulWidget {
  const SaveData({Key? key}) : super(key: key);

  @override
  State<SaveData> createState() => _SaveDataState();
}

class _SaveDataState extends State<SaveData> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerKritName = TextEditingController();
  final TextEditingController _controllerUpdateName = TextEditingController();

  @override
  void initState() {
    super.initState();
    dataBlock.allDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<List<DataModel>>(
          stream: dataBlock.getData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<DataModel> data = snapshot.data!;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 4.0,
                          ),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  data[index].kritName,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return CupertinoAlertDialog(
                                            title: TextField(
                                              controller: _controllerUpdateName,
                                              decoration: InputDecoration(
                                                  hintText:
                                                      data[index].kritName),
                                            ),
                                            actions: [
                                              GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Cancel")),
                                              GestureDetector(
                                                onTap: () {
                                                  dataBlock.updateData(
                                                    DataModel(
                                                      name:
                                                          _controllerName.text,
                                                      kritName:
                                                          _controllerUpdateName
                                                              .text,
                                                    ),
                                                  );
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Done"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      size: 15.0,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      dataBlock.deleteData(data[index].id);
                                    },
                                    child: const Icon(
                                      Icons.remove,
                                      size: 20.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return Container();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return Container(
                height: 450,
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25.0),
                    topLeft: Radius.circular(25.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () => null,
                      child: SizedBox(
                        height: 60,
                        //  padding: EdgeInsets.all(15.0),
                        width: MediaQuery.of(context).size.width - 80,
                        child: TextField(
                          controller: _controllerKritName,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Name",
                              hintStyle: TextStyle(color: Colors.black45)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    Align(
                      alignment: const FractionalOffset(0.94, 0.1),
                      child: ElevatedButton(
                        onPressed: () async {
                          dataBlock.saveData(
                            DataModel(
                              name: _controllerName.text,
                              kritName: _controllerKritName.text,
                            ),
                          );
                          _controllerName.text = "";
                          _controllerKritName.text = "";
                          Navigator.pop(this.context);
                        },
                        child: const SizedBox(
                          height: 40.0,
                          width: 40.0,
                          child: Center(
                            child: Icon(
                              Icons.done,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            backgroundColor: Colors.transparent,
          );
        },
        child: const Center(
          child: Icon(
            Icons.edit_note,
            size: 30,
          ),
        ),
      ),
    );
  }
}
