/*
 * Author: Masahiro Itabashi <itabasi.lm@gmail.com>
 * Last modified: Sat, 02 May 2026 22:48:01 +0900
 */
#include <stdio.h>

__global__ void kernel(){

}

int main(int argc, char *argv[]){
  kernel<<<1, 1>>>();
  return 0;
}
