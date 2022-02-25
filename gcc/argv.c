#include <stdio.h>
#include <math.h>


void add(int x);


int main(int argc, char** argv){
  int x =0;
  int y =0;
  int z =0;
  int num[100];
  for (int i=0; i<10000000; i=i+1){
  

    if(*((*(argv+1))+i)!=0){
      num[i]=*((*(argv+1))+i)-'0';
    }else{  
      x=i;
      break;
    }
  }
  
  

  for(int j= x; j>0; j=j-1){
    y= y+ num[j-1] * (int)(pow(10 , z));
    z=z+1;
  }
  add(y);
 
 
    return 0;
}


void add(int x){
  for(int i=1;i<=x;i=i+1){
    int y=0;
    for(int j=1;j<=i;j=j+1){
      y=y+i;
    }
    printf ("(%d,%d)\n",i ,y);
  }
    

}







