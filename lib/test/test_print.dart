/// @author Acorn
/// @version
/// @company 威成亚
/// @date 2025/2/18

//${'a' * length} 这样的代码执行效果是将字符 'a' 重复 length 次
String scream(int length) => "A${'a' * length}h!";

void main() {
  final values = [4, 2, 3, 5, 1, 50];
  //遍历打印
  values.map(scream).forEach(print);

  print('--------------------------------------------');
  //skip(1) 会忽略迭代中的第一个值
  //take(3)会获取接下来的 3 个值，也就是 2，3 和 5
  values.skip(1).take(3).map(scream).forEach(print);

  print('--------------------------------------------');
  values.map((value)=>{
    'value:$value'
  }).forEach((str)=>{
    print("ha:$str")
  });
}