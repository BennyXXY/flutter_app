void main(){
  getName();
  getName2();
  getName3();
}

Future<void> getName() async{
  await getStr();
  print("Name");
}

getStr(){
  print("getStr");
}

getName2(){
  print("getrName2");
}

getName3(){
  print("getName3");
}