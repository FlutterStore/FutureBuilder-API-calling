import 'package:flutter/material.dart';
import 'package:futurebuilder/api_respons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text('FutureBuilder Api Calling',style: TextStyle(fontSize: 15),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Apicalling(),));
              }, 
              child: const Text("FutureBuilder Api")
            ),
          ],
        ),
      ),
    );
  }
}


class Apicalling extends StatefulWidget {
  const Apicalling({super.key});

  @override
  State<Apicalling> createState() => _ApicallingState();
}

class _ApicallingState extends State<Apicalling> {
  late Future<Usdrate> _futureusdrate;
  var usd = [];
  var rate = [];

  @override
  void initState() {
    _futureusdrate = fetchUsdrate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('USD Rates',style: TextStyle(fontSize: 15),),
        backgroundColor: Colors.green,
      ),
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<Usdrate>(
            future: _futureusdrate,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                snapshot.data!.rates.forEach((key, value) {
                  usd.add(key);
                  rate.add(value);
                });

                if (snapshot.hasData) {
                  return   Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: usd.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.green.withOpacity(0.5),
                                child: Text("${index+1}",style: const TextStyle(color: Colors.black),),
                              ),
                              title: Text(usd[index]),
                              trailing: Text(rate[index].toString()),
                            );
                          }, 
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
    );
  }
}
