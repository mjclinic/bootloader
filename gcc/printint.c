#include <stdio.h>


void printint(int x){
  for( int i=1; i<= x; i=i+1 ){
   if(i==x){
      printf("%d",i);
   }else{
      printf("%d,",i);
   }
  }
}
