int main() {
  int a = 1;
  int d = 10000;
  int b = d * a;
  int c = d - a / b;

  if(a < 3){
    a = 4;
    if(a == 4){
      a = 2+a;
    }
    else{
      a = 1;
    }
  }
  else{
    a = 3;
  }
  while(a <5){
    a= a+1;
  }

}
