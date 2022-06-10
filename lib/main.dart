import 'dart:io';

void main(List<String> args){
  RawDatagramSocket.bind(InternetAddress.anyIPv4, 62526).then((RawDatagramSocket socket){
    print('UDP Echo ready to receive');
    print('${socket.address.address}:${socket.port}');
    socket.listen((RawSocketEvent e){
      Datagram? d = socket.receive();
      if (d == null) return;

      String message = String.fromCharCodes(d.data);
      print('Datagram from ${d.address.address}:${d.port}: ${message.trim()} \nResending message.');

      socket.send(message.codeUnits, d.address, d.port);
    });
  });
}