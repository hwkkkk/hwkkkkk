import 'dart:convert';
import 'dart:io';

void main() async {
  final socket = await Socket.connect('localhost', 5000);
  print('Connected to server');

  var imagePath  = 'images/eye.jpg';

  File imageFile = File(imagePath);
  List<int> imageBytes = imageFile.readAsBytesSync();
  String base64Image = base64Encode(imageBytes);



  // Send the length of the base64 encoded image with padding
  socket.write(base64Image.length.toString().padLeft(16, '0'));

  // Listen for server response
  socket.listen(

        (List<int> data) {
      print('Received: ${String.fromCharCodes(data)}');
      print('deug');
    },
    onError: (error) {
      print('Error: $error');
      socket.destroy();
    },
    onDone: () {
      print('Connection closed');
      socket.destroy();
    },
  );

  // Send the actual base64 encoded image data
  socket.write(base64Image);
}
