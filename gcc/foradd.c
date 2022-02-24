#include <stdio.h>


void add(){
  for(int i=1; i<=9; i=i+1){
    int y=0;
    for(int j=1; j<=i; j=j+1){
    y=y+i;
    }
    printf("%d, %d\n", i, y);
  }

}

