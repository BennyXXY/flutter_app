import 'dart:convert';

import 'dart:typed_data';

void main() {
  //AscillCodec();
  //JSON();
  //Base64();
  //Utf8();
  Latin1();
}

void Latin1(){
  Latin1Codec latin1codec=new Latin1Codec();
  Uint8List uint8list=latin1codec.encode('XinXiangYu');
  print(uint8list);

  String str=latin1codec.decode(uint8list);
  print(str);
}

//void Utf8() {
//  Utf8Codec utf = new Utf8Codec();
//  Uint8List uint8list = utf.encode('XinXiangYu');
//  print(uint8list);
//
//  String str=utf.decode(uint8list);
//  print(str);
//
//  utf.decodeStream(Stream.value(uint8list)).then((value) => print(value));
//  print(utf.name);
//}

//void Base64() async {
//  AsciiCodec as = new AsciiCodec();
//  Uint8List list = await as.encode('Xin');
//  print(list);
//
//  Base64Codec bc = new Base64Codec();
//  String str = bc.encode(list);
//  print(str);
//
//  Uint8List list2 = bc.decode(str);
//  print(list2);
//
//  print(bc.normalize(str));
//}

//void AscillCodec() {
//  //创建一个AsciiCodec对象
//  AsciiCodec as = new AsciiCodec();
//
//  //将ascill字符串字符串转化成uintList类型,无法编码中文，会报错
//  Uint8List list = as.encode('XinXiangYu');
//  //等价于
//  //Uint8List list=AsciiEncoder().convert('XinXiangYu');
//  print(list);
//
//  //解码
//  String str = as.decode(list);
//  //等价于
//  // String str=AsciiDecoder().convert(list);
//  print(str);
//  //流解码 即将Stream<List<int>>类型转换成ascii字符串
//  as.decodeStream(Stream.value(list)).then((value) => print(value));
//  print(as.name);
//}

//void JSON() {
//  JsonCodec jc=new JsonCodec();
//// JS中的对象就是这里的Map
//  print({}.runtimeType);
//// 将Map转换成JSON
//  Object person=jc.encode({'name':"zs"});
//// 等价于
//// Object person=new JsonEncoder().convert({'name':"zs"});
//  print(person);
//// 将JSON转换成Map
//  Map<String,dynamic> str=jc.decode(person);
//// 等价于
//// Map<String,dynamic> str=new JsonDecoder().convert(person);
//  print(str);
//
//// 将对象或JSON字符串 转换成一个UTF-8数组(Uint8List)
//  Uint8List person2=new JsonUtf8Encoder().convert({'name':'zs'});
//  print(person2);
//}
