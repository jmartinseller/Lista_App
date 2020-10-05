import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Lista',
    debugShowCheckedModeBanner: false,
    home: MainApp(),
      theme: ThemeData(
          primaryColor: Colors.brown[800],
          primaryColorDark: Colors.brown[900],
          cursorColor: Colors.brown[400]),
  ));
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _formKey = GlobalKey<FormState>();
  var _itemController = TextEditingController();
  List _lista = [];

  @override
  Widget build(BuildContext contexT) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ITENS'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () async {
              var itens =
              _lista.reduce((value, element) => value + '\n' + element)
                  .then((data) {
                //print(data);
              });
            },
          )
        ],
      ),
      body: Scrollbar(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            for (int i = 0; i < _lista.length; i++)
              ListTile(
                  leading: ExcludeSemantics(
                    child: CircleAvatar(child: Text('${i + 1}')),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          _lista[i].toString(),
                          style: TextStyle(
                          color: Colors.brown[400],
                          fontSize: 24,
                          ),
                          ),
                        ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          size: 24.0,
                          color: Colors.brown[600],
                        ),
                        onPressed: () {
                          setState(() {
                            _lista.removeAt(i);
                          });
                        },
                      ),
                    ],
                  )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _displayDialog(context),
      ),
    );
  }

  _displayDialog(context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content: Form(
              key: _formKey,
              child: TextFormField(
                controller: _itemController,
                validator: (s) {
                  if (s.isEmpty)
                    return "LISTAR.";
                  else
                    return null;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "LISTAR"
                ),
              ),
            ),
            actions: <Widget>[
        FlatButton(
        child: new Text('ESC',
        style: TextStyle(
        color: Colors.brown[600],
          fontSize: 22,
        ),
        ),
        onPressed: (){
        Navigator.of(context).pop();
      },
    ),
    FlatButton(
    child: new Text('ADICIONAR',
        style: TextStyle(
        color: Colors.brown[600],
        fontSize: 22,)),
    onPressed: () {
    if (_formKey.currentState.validate()) {
    setState(() {
    _lista.add(_itemController.text);
    _itemController.text = "";
    });
    Navigator.of(context).pop();
    }
    },
    )
    ],
    );
  }
  );

}
}
