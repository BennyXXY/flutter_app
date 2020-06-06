main(){//返回类型可以省略
//  print(add(1,2));
  //命名参数
//  int add2({int a=1,int b=3}){
//    return a+b;
//  }
//  print(add2(a:1, b:2));

    //可选位置参数
//   int add3(int a,[int b=1,int c=3]){
//     return a+b;
//   }
//   print(add3(1));

//    //无参匿名
//  var pname = () => print("mabiuasuidas");
//  //有参匿名
//  var pname1 = (name) => ("${name}");
//  print(pname1("xinxy"));

//  List test(List list,String func(Str)){
//    for(var i=0;i<list.length;i++){
//      list[i]=func(list[i]);
//    }
//    return list;
//  }

//  var ls=["aaa","bbb","ccc"];
//  //print(test(ls, (Str) => Str*2));
//
//  ls.forEach((ele)=>print(ele));

//闭包
//  Function makeAddFunc(int a){
//    return (int y)=>a+y;
//  }
//  var addFunc=makeAddFunc(12);
//  print(addFunc(22));

//别名函数
//myFunc m=addfunc(11, 22);
//m=dividefunc(10, 5);

calc(1,32,addfunc);
}
typedef myFunc(int a,int b);
addfunc(int a,int b){
  print("${a+b}");
}
dividefunc(int a,int b){
  print("${a/b}");
}
calc(int a,int b,myFunc cf){
  cf(a,b);
}
//int add(int a,int b){
//  return a+b;
//}

int add(int a,int b)=>a+b;