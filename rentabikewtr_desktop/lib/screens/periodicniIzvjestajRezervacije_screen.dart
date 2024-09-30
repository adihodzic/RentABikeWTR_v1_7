import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_desktop/main.dart';
import 'package:rentabikewtr_desktop/model/rezervacijeBiciklDostupni.dart';
import 'package:rentabikewtr_desktop/model/rezervacijePregled.dart';
import 'package:rentabikewtr_desktop/model/screenArgumentsR.dart';
import 'package:rentabikewtr_desktop/model/xRezervacije.dart';
import 'package:rentabikewtr_desktop/model/xRezervacijeResult.dart';
import 'package:rentabikewtr_desktop/providers/rezervacijeBiciklDostupni_provider.dart';
import 'package:rentabikewtr_desktop/providers/rezervacijeBicikl_provider.dart';
import 'package:rentabikewtr_desktop/providers/xRezervacijeResult_provider.dart';
import 'package:rentabikewtr_desktop/screens/adminPortal_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_korisnika_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_vodica_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_korisnici_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_vodici_screen.dart';
import 'package:rentabikewtr_desktop/screens/periodicniIzvjestajRezervacije_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_korak1_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_korak2_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_listaRezervacija_screen.dart';
import 'package:rentabikewtr_desktop/utils/util.dart';
import 'package:rentabikewtr_desktop/widgets/menuAdmin.dart';
import 'package:rentabikewtr_desktop/widgets/menuRadnik.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
//import 'package:universal_html/html.dart' as html;
// ignore: depend_on_referenced_packages
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';

class PeriodicniIzvjestajRezervacijeScreen extends StatefulWidget {
  PeriodicniIzvjestajRezervacijeScreen({super.key});

  @override
  State<PeriodicniIzvjestajRezervacijeScreen> createState() =>
      _PeriodicniIzvjestajRezervacijeScreenState();
}

class _PeriodicniIzvjestajRezervacijeScreenState
    extends State<PeriodicniIzvjestajRezervacijeScreen> {
  TextEditingController _dateOdController = TextEditingController();
  TextEditingController _dateDoController = TextEditingController();
  TextEditingController _ukupnaSumaController = TextEditingController();
  XRezervacijeResultProvider? _xRezervacijeResultProvider;
  List<XRezervacije> data = [];
  XRezervacijeResult? dataResult;
  List<XRezervacije> _dataList = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime dateTime = DateTime.now();
  DateTime dateTime2 = DateTime.now();
  ScreenArgumentsR? argumentsR;
  RezervacijeBiciklDostupni? argumentsB;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _xRezervacijeResultProvider = context.read<XRezervacijeResultProvider>();
    // _cartProvider = context.read<CartProvider>();
    print("called initState");
    //loadData();
  }

  // Future loadData() async {
  //   var tmpData = await _rezervacijeBiciklDostupniProvider?.get(null);
  //   setState(() {
  //     data = tmpData!;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: MenuAdmin(),
                ),
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.white,
                      constraints:
                          BoxConstraints(maxWidth: 800, maxHeight: 800),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(children: [
                            Image.asset(
                              "assets/images/logo.jpg",
                              height: 50,
                              width: 500,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "RentABikeWTR -Periodični izvještaj",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Color.fromARGB(255, 11, 7, 255)),
                            ),
                            Flexible(
                              child: Container(
                                constraints: BoxConstraints(
                                    minWidth: 100,
                                    maxWidth: 800,
                                    minHeight: 100,
                                    maxHeight: 120),
                                // width: 300,
                                // height: 450,
                                child: Card(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  color: Color.fromARGB(255, 246, 249, 252),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        16, 30, 16, 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 150,
                                          width: 180,
                                          child: TextFormField(
                                            readOnly: true,
                                            controller: _dateOdController,
                                            onTap: _selectDateOd,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Datum početni",
                                                hintText: 'Odaberite datum'),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Ovo je obavezno polje.';
                                              } else {
                                                return null;
                                              }
                                            },
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 100,
                                        ),
                                        Container(
                                          height: 150,
                                          width: 180,
                                          child: TextFormField(
                                            readOnly: true,
                                            controller: _dateDoController,
                                            onTap: _selectDateDo,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Datum krajnji",
                                                hintText: 'Odaberite datum'),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Ovo je obavezno polje.';
                                              } else {
                                                return null;
                                              }
                                            },
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 100,
                                        ),
                                        Container(
                                          width: 200,
                                          height: 50,
                                          child: ElevatedButton(
                                            child: Text("Izlistaj rezervacije"),
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                try {
                                                  await _handleFormSubmission();

                                                  await _showDialog(
                                                      context,
                                                      'Success',
                                                      'Izvještaj se kreira...');
                                                } catch (e) {
                                                  await _handleSubmissionError(
                                                      e);
                                                }
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            _buildDataListView(),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: 50,
                                  width: 180,
                                  child: TextFormField(
                                    textAlign: TextAlign.right,
                                    readOnly: true,
                                    initialValue: "Ukupna suma (KM): ",
                                    //onTap: _selectDateOd,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        labelText: "",
                                        hintText: ''),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 100,
                                  child: TextFormField(
                                    textAlign: TextAlign.left,
                                    readOnly: true,
                                    controller: _ukupnaSumaController,
                                    //onTap: _selectDateOd,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        labelText: "",
                                        hintText: ''),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 150,
                                  height: 50,
                                  child: ElevatedButton(
                                    child: Text("PRINT"),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        try {
                                          await _handleFormSubmission2();

                                          await _showDialog(context, 'Success',
                                              'Izvještaj je uspješno kreiran');
                                        } catch (e) {
                                          await _handleSubmissionError(e);
                                        }
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.white,

                      //constraints: BoxConstraints(maxWidth: 400, maxHeight: 400),
                      child: Center(
                        child: Card(
                          color: Color.fromARGB(255, 78, 11, 212),
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(100, 16, 100, 30),
                            child: Column(children: [
                              Image.asset(
                                "assets/images/logo6.jpg",
                                height: 400,
                                width: 400,
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataListView() {
    //KorisniciProvider? _korProvider = null;
    //List<Korisnici> data1 = [];

    return Expanded(
        child: SingleChildScrollView(
      child: DataTable(
          columns: [
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Datum',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Cijena usluge',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Korisnicko ime',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Naziv bicikla',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Naziv rute',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
          rows: _dataList
                  .map((XRezervacije e) => DataRow(cells: [
                        DataCell(
                            Text(DateFormat('dd-MM-yyyy').format(e.datum!))),
                        // DataCell(Text(DateFormat('dd-MM-yyyy')
                        //     .format(e.datumIzdavanja as DateTime))),
                        DataCell(Text(formatNumber(e.cijenaUsluge))),
                        DataCell(Text(e.korisnickoIme?.toString() ?? "")),
                        DataCell(Text(e.nazivBicikla?.toString() ?? "")),
                        DataCell(Text(e.naziv?.toString() ?? "")),
                      ]))
                  .toList() ??
              []),
    ));
  }

/////////////////////////////////////////////////////////////////////////////////
  Future<void> _handleFormSubmission() async {
    try {
      var tmpDataResult = null;

      DateFormat format = DateFormat("yyyy-MM-dd");

      DateTime datum = format.parse(dateTime.toIso8601String());
      DateTime datum2 = format.parse(dateTime2.toIso8601String());
      if (datum2.isAfter(datum)) {
        tmpDataResult =
            await _xRezervacijeResultProvider!.getXRezervacije(datum, datum2);
      }

//var bicikli= await _bicikliDostupniProvider.getByIds
      print('Fetched data: $data'); // Debugging line

      setState(() {
        dataResult = tmpDataResult!;
        data = tmpDataResult!.xRezervacijeLista!;
        _dataList = data as List<XRezervacije>;
        //var suma = dataResult!.ukupnaSuma;
        _ukupnaSumaController.text = dataResult!.ukupnaSuma!.toString();
        _buildDataListView();
      });
    } catch (e) {
      print('Error fetching data: $e');
      _showDialog(context, "Error", "Došlo je do greške!"); // Debugging line
    }
  }

  Future<void> _handleSubmissionError(e) async {
    await _showDialog(context, 'Error', 'Došlo je do greške!');
  }

  Future<void> _handleFormSubmission2() async {
    try {
      generatePdf(dataResult!);
      // await savePdf(bytes);

      //_buildDataListView();
    } catch (e) {
      // Handle the error here if needed
      print('Error fetching data2: $e');
      _showDialog(context, "Error", "Došlo je do greške"); // Debugging line
    }
  }

  _selectDateOd() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateTime,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2020),
        lastDate: DateTime(2101));
    if (picked != null) {
      dateTime = picked;
      //assign the chosen date to the controller
      _dateOdController.text = DateFormat('dd-MM-yyyy').format(dateTime);
    }
  }

  _selectDateDo() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateTime2,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2020),
        lastDate: DateTime(2101));
    if (picked != null) {
      dateTime2 = picked;
      //assign the chosen date to the controller
      _dateDoController.text = DateFormat('dd-MM-yyyy').format(dateTime2);
    }
  }

  Future<void> _showDialog(
      BuildContext context, String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to dismiss the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
/////////////////////PDF formatiranje ////////////////////

  void generatePdf(XRezervacijeResult result) async {
    final PdfDocument document = PdfDocument();
    final PdfPage page = document.pages.add();

    page.graphics.drawString(
      'Izvjestaj za period od ${_dateOdController.text} do ${_dateDoController.text}',
      PdfStandardFont(PdfFontFamily.helvetica, 18),
      bounds: Rect.fromLTWH(50, 20, page.getClientSize().width - 100, 40),
    );

    final PdfGrid grid = PdfGrid();
    grid.columns
        .add(count: 5); //umjesto 5 jer smo izbrisali rezervacijaId i kupacID
    grid.headers.add(1);

    final PdfGridRow header = grid.headers[0];
    header.cells[0].value = 'Korisnicko ime';
    header.cells[1].value = 'Cijena usluge';
    header.cells[2].value = 'Datum';
    header.cells[3].value = 'Bicikl';
    header.cells[4].value = 'Turist ruta';

    header.style.backgroundBrush =
        PdfSolidBrush(PdfColor(173, 216, 230)); // dodatni design

    grid.style = PdfGridStyle(
      cellPadding: PdfPaddings(left: 5, right: 5, top: 3, bottom: 3),
      backgroundBrush: PdfBrushes.azure,
      font: PdfStandardFont(PdfFontFamily.helvetica, 10),
    );

    for (var rez in result.xRezervacijeLista!) {
      final PdfGridRow row = grid.rows.add();

      row.cells[0].value = rez.korisnickoIme;
      row.cells[1].value = rez.cijenaUsluge.toString();
      row.cells[2].value = DateFormat('dd-MM-yyyy').format(rez.datum!);
      row.cells[3].value = rez.nazivBicikla;
      row.cells[4].value = rez.naziv ?? "Nema podataka";

      if (grid.rows.count % 2 == 0) {
        row.style.backgroundBrush =
            PdfSolidBrush(PdfColor(240, 255, 255)); //dodatni design
      }
    }

    final PdfLayoutResult layoutResult = grid.draw(
      page: page,
      bounds: const Rect.fromLTWH(0, 100, 0, 0),
    )!;

    page.graphics.drawString(
      'Ukupna Suma: ${result.ukupnaSuma}',
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      bounds: Rect.fromLTWH(400, layoutResult.bounds.bottom + 10, 0, 0),
    );

    List<int> bytes = await document.save();
    document.dispose();
    SaveFile.saveAndLaunchFile(bytes, 'output.pdf');
    // return bytes;
  }
}

class SaveFile {
  static Future<void> saveAndLaunchFile(
      List<int> bytes, String fileName) async {
    //Get external storage directory
    Directory directory = await getApplicationSupportDirectory();
    //Get directory path
    String path = directory.path;
    //Create an empty file to write PDF data
    File file = File('$path/$fileName');
    //Write PDF data
    await file.writeAsBytes(bytes, flush: true);
    //Open the PDF document in mobile
    OpenFile.open('$path/$fileName');
  }
}
