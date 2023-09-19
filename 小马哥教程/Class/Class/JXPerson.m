//
//  JXPerson.m
//  Class
//
//  Created by wjx on 2023/9/19.
//

#import "JXPerson.h"
#import "Class-Swift.h"
sum(int a, int b){
    return  a+b;
}
void testSwift(){
    JXCar *car = [[JXCar alloc] initWithPrice:20 band:@""];
    car.name = @"qwe";
    [car drive];
    [car exec:29 v2:@"qwe"];
    [JXCar run];
    
    
}
@implementation JXPerson

@end
