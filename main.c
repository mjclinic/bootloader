#include <stdio.h>

void add(int x);


//argv: dq [argv+0], [argv+1], [argv+2]
//argv+1: dq [argv+1+0], 
//argv+1+0: f , i




int main(int argc, char** argv){
  for(int i=0; i<argc; i=i+1){
    for(int j=0; j<=1000000; j=j+1){
      if(*((*(argv+i))+j)!=0){
        printf("%c",*((*(argv+i))+j));
      }else{
        printf("\n");
        break;
      }
    }
  }
  return 0;
}

