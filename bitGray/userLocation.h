//
//  userLocation.h
//  bitGray
//
//  Created by Mario Vizcaino on 15/02/17.
//  Copyright © 2017 Mario Vizcaino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>
@interface UserLocation : NSObject

// RETORNA EL USUARIO MAS CERCANO
+(NSDictionary *) nearbyUser:(NSArray *) users Index:(int) index;

// RETORNA EL USUARIO MAS LEJANO
+(NSDictionary *) farUser:(NSArray *)users Index:(int) index;
@end
