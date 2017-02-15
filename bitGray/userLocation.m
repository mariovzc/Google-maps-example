//
//  userLocation.m
//  bitGray
//
//  Created by Mario Vizcaino on 15/02/17.
//  Copyright © 2017 Mario Vizcaino. All rights reserved.
//

#import "userLocation.h"

@implementation UserLocation


+(NSDictionary * ) nearbyUser:(NSArray *) users Index:(int) index{
    
    NSDictionary * near = [[NSDictionary alloc] init];
    
    float nearestDistance = MAXFLOAT;
    
    NSDictionary * user = [[NSDictionary alloc] initWithDictionary:[users objectAtIndex:index]];
    
    float latUser = [user[@"address"][@"geo"][@"lat"] floatValue];
    float lngUser = [user[@"address"][@"geo"][@"lng"] floatValue];
    
    for( NSDictionary * currentUser in users ){
        
        NSDictionary * address = [[NSDictionary alloc] initWithDictionary:[currentUser objectForKey:@"address"]];
        
        NSDictionary * geo = [[NSDictionary alloc] initWithDictionary:[address objectForKey:@"geo"]];
        
        float currentLat = [[geo objectForKey:@"lat"] floatValue];
        float currentLng = [[geo objectForKey:@"lng"] floatValue];
        
        CLLocation * location1 = [[CLLocation alloc] initWithLatitude:latUser longitude:lngUser];
        
        CLLocation * location2 = [[CLLocation alloc] initWithLatitude:currentLat longitude:currentLng];
        
        CLLocationDistance distance = [location1 distanceFromLocation:location2];
        
        
        if( distance < nearestDistance && distance > 0  ) {
            
            nearestDistance = distance;
            
            near = [[NSDictionary alloc] initWithDictionary:currentUser];
            
        }
        
    }
    
    
    return near;
}

+(NSDictionary *) farUser:(NSArray *)users Index:(int) index{
    
    NSDictionary * far = [[NSDictionary alloc] init];
    
    float farestDistance = 0;
    
    NSDictionary * user = [[NSDictionary alloc] initWithDictionary:[users objectAtIndex:index]];
    
    float latUser = [user[@"address"][@"geo"][@"lat"] floatValue];
    float lngUser = [user[@"address"][@"geo"][@"lng"] floatValue];
    
    for( NSDictionary * currentUser in users ){
        
        NSDictionary * address = [[NSDictionary alloc] initWithDictionary:[currentUser objectForKey:@"address"]];
        
        NSDictionary * geo = [[NSDictionary alloc] initWithDictionary:[address objectForKey:@"geo"]];
        
        float currentLat = [[geo objectForKey:@"lat"] floatValue];
        float currentLng = [[geo objectForKey:@"lng"] floatValue];
        
        CLLocation * location1 = [[CLLocation alloc] initWithLatitude:latUser longitude:lngUser];
        
        CLLocation * location2 = [[CLLocation alloc] initWithLatitude:currentLat longitude:currentLng];
        
        CLLocationDistance distance = [location1 distanceFromLocation:location2];
        
        
        if( distance > farestDistance ) {
            farestDistance = distance;
            far = [[NSDictionary alloc] initWithDictionary:currentUser];
        }
        
    }
    
    return far;
    
}


@end
