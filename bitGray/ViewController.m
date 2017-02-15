//
//  ViewController.m
//  bitGray
//
//  Created by Mario Vizcaino on 15/02/17.
//  Copyright © 2017 Mario Vizcaino. All rights reserved.
//

#import "ViewController.h"
#import "userLocation.h"
#import "fetchData.h"
@import GoogleMaps;

#define APIURL @"http://jsonplaceholder.typicode.com/users"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *otherUserButton;
@property (weak, nonatomic) IBOutlet UIView *mapView;

@end

@implementation ViewController{
    GMSMapView *mapView_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self displayMap];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)refreshButtonAction {
    [self displayMap];
}

-(void)displayMap{
    
    [mapView_ removeFromSuperview];
    
    mapView_ = [[GMSMapView alloc] init];
    
    [FetchData getUsers:APIURL completionHandler:^(NSArray *responseArray, NSError *error) {
        
        if(responseArray != nil){
            
            int numberUsers = (int)[responseArray count];
            
            if( numberUsers > 0 )numberUsers--;
            
            int randomUser = arc4random_uniform(numberUsers);
            
            NSDictionary * farest = [UserLocation farUser:responseArray Index:randomUser];

            NSDictionary * nearest = [UserLocation nearbyUser:responseArray Index:randomUser];
            
            
            NSDictionary * user = [[NSDictionary alloc] initWithDictionary:[responseArray objectAtIndex:randomUser]];
            
            NSDictionary * address = [[NSDictionary alloc] initWithDictionary:[user objectForKey:@"address"]];
            
            NSDictionary * dLocation = [[NSDictionary alloc] initWithDictionary:[address objectForKey:@"geo"]];
            
            float lng = [[dLocation objectForKey:@"lng"] floatValue];
            float lat = [[dLocation objectForKey:@"lat"] floatValue];
            
            
            GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:lng
                                                                    longitude:lng zoom:2];
            
            mapView_ = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
            
            mapView_.myLocationEnabled = YES;
            
            // Creates a marker in the center of the map.
            GMSMarker *marker = [[GMSMarker alloc] init];
            
            marker.position = CLLocationCoordinate2DMake(lat, lng);
            
            marker.title = [NSString stringWithFormat:@"%@", [user objectForKey:@"name"]];
            
            marker.snippet = [NSString stringWithFormat:@"%@ - %@", [address objectForKey:@"street"] ,[address objectForKey:@"city"]];
            marker.icon = [UIImage imageNamed:@"redMark"];
            marker.map = mapView_;
            
            CLLocationCoordinate2D positionFarest = CLLocationCoordinate2DMake([farest[@"address"][@"geo"][@"lat"] floatValue], [farest[@"address"][@"geo"][@"lng"]floatValue]);
            
            GMSMarker *markerFarest = [GMSMarker markerWithPosition:positionFarest];
            
            markerFarest.title = [NSString stringWithFormat:@"%@", [farest objectForKey:@"name"]];
            
            markerFarest.snippet = [NSString stringWithFormat:@"%@ - %@", farest[@"address"][@"city"] , farest[@"address"][@"street"]];
            
            markerFarest.icon = [UIImage imageNamed:@"yellowMark"];
            
            markerFarest.map = mapView_;
            
            
            CLLocationCoordinate2D positionNearest = CLLocationCoordinate2DMake([nearest[@"address"][@"geo"][@"lat"] floatValue], [nearest[@"address"][@"geo"][@"lng"]floatValue]);
            
            GMSMarker *markerNearest = [GMSMarker markerWithPosition:positionNearest];
            
            markerNearest.title = [NSString stringWithFormat:@"%@", [nearest objectForKey:@"name"]];
            
            markerNearest.snippet = [NSString stringWithFormat:@"%@ - %@ ", nearest[@"address"][@"city"] , nearest[@"address"][@"street"]];
            
            markerNearest.icon = [UIImage imageNamed:@"blueMark"];;
            
            markerNearest.map = mapView_;
            
            [self.mapView addSubview:mapView_];
            
        }
        
    }];

}



- (UIImage *)imageFromView:(UIView *) view
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, [[UIScreen mainScreen] scale]);
    } else {
        UIGraphicsBeginImageContext(view.frame.size);
    }
    [view.layer renderInContext: UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
