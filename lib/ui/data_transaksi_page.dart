import 'package:flutter/material.dart';
import 'package:film_app/models/film.dart';
import 'package:film_app/models/transaksi.dart';
import 'package:film_app/ui/kwitansi_page.dart';

class DataTransaksiPage extends StatefulWidget {
  final Film? film;

  DataTransaksiPage({
    Key? key,
    this.film,
    required this.transaksi,
    required List transakasi,
  }) : super(key: key);

  final List<Transaksi> transaksi;

  @override
  _DataTransaksiPageState createState() => _DataTransaksiPageState();
}

class _DataTransaksiPageState extends State<DataTransaksiPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _quantityController;
  List<String> selectedSeats = []; // Track selected seats

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _quantityController = TextEditingController(text: '1');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo, // Warna latar belakang AppBar
        title: const Text(
          'Pembelian Tiket',
          style: TextStyle(
            color: Colors.white, // Warna teks AppBar
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(
                controller: _nameController,
                labelText: 'Nama Pembeli',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama Pembeli tidak boleh kosong';
                  }
                  return null;
                },
              ),
              _buildTextField(
                controller: _quantityController,
                labelText: 'Jumlah Tiket',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jumlah Tiket tidak boleh kosong';
                  }
                  int? quantity = int.tryParse(value);
                  if (quantity == null || quantity <= 0) {
                    return 'Jumlah Tiket harus merupakan angka positif';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Display selected seats
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: _buildSeatButtons(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 24.0,
                  ),
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _showConfirmationDialog();
                  }
                },
                child: const Text(
                  'Beli Tiket',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Ubah warna teks tombol di sini
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSeatButtons() {
    List<Widget> seatButtons = [];
    // Example: Create 30 seats (5x6 grid)
    for (int i = 1; i <= 30; i++) {
      String seatNumber = 'Seat $i';
      seatButtons.add(
        ElevatedButton(
          onPressed: () {
            setState(() {
              if (selectedSeats.contains(seatNumber)) {
                selectedSeats.remove(seatNumber);
              } else {
                selectedSeats.add(seatNumber);
              }
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: selectedSeats.contains(seatNumber)
                ? Colors.redAccent
                : Colors.blueAccent,
            padding: const EdgeInsets.all(12.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text(
            seatNumber,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
    return seatButtons;
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        validator: validator,
      ),
    );
  }

  void _showConfirmationDialog() {
    var price2 = widget.film!.price;
    final double totalPrice = price2! * int.parse(_quantityController.text);
    final DateTime tanggalPembelian =
        DateTime.now(); // Capture the current date and time

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Pembelian'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Pembeli: ${_nameController.text}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Jumlah Tiket: ${_quantityController.text}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Kursi Dipilih:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4.0),
            Text(
              selectedSeats.isEmpty
                  ? 'Tidak ada kursi dipilih'
                  : selectedSeats.join(", "),
              style: TextStyle(
                color: selectedSeats.isEmpty ? Colors.grey : Colors.black,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Tanggal Pembelian: ${tanggalPembelian.toString()}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Total Harga: Rp ${totalPrice.toStringAsFixed(0)}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              final transaksi = Transaksi(
                namaPembeli: _nameController.text,
                jumlahTiket: int.parse(_quantityController.text),
                totalHarga: totalPrice,
                filmTitle: widget.film!.title!,
                kursiDipilih: selectedSeats.isEmpty
                    ? "Tidak ada kursi dipilih"
                    : selectedSeats.join(", "),
                tanggalPembelian: tanggalPembelian, // Add the purchase date
              );

              Navigator.pop(context);
              _showReceipt(transaksi);
              _clearForm(); // Clear form after submission
            },
            child: const Text('Konfirmasi'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  void _showReceipt(Transaksi transaksi) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => KwitansiPage(transaksi: transaksi),
      ),
    );
  }

  void _clearForm() {
    _nameController.clear();
    _quantityController.text = '1'; // Reset quantity to default value
    setState(() {
      selectedSeats.clear(); // Clear selected seats
    });
  }
}
