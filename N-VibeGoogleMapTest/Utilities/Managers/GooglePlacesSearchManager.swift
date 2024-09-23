//
//  GooglePlacesSearchManager.swift
//  N-VibeGoogleMapTest
//
//  Created by Applications Team on 9/23/24.
//

import GooglePlaces
import GoogleMaps

public class GooglePlacesSearchManager {
    public static let shared = GooglePlacesSearchManager()
    private let placesClient = GMSPlacesClient.shared()
    
    func searchPlaces(with query: String, completion: @escaping ([GMSAutocompletePrediction]?) -> Void) {
        let token = GMSAutocompleteSessionToken.init()
        
        let filter = GMSAutocompleteFilter()
        filter.types = ["geocode"]
        
        placesClient.findAutocompletePredictions(fromQuery: query, filter: filter, sessionToken: token) { (results, error) in
            if let error = error {
                print("Autocomplete error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let results = results else {
                completion(nil)
                return
            }
            
            completion(results)
        }
    }
    
    func getCoordinates(for prediction: GMSAutocompletePrediction, completion: @escaping (GMSPlace?) -> Void) {
        let placeID = prediction.placeID
        let sessionToken = GMSAutocompleteSessionToken.init()

        // Define the place properties you are interested in, such as name and coordinates
        let placeProperties: [GMSPlaceProperty] = [.name, .coordinate]

        // Initialize the request with placeID, properties, and session token
        let request = GMSFetchPlaceRequest(placeID: placeID, placeProperties: placeProperties.map({$0.rawValue}), sessionToken: sessionToken)

        placesClient.fetchPlace(with: request) { (place, error) in
            if let error = error {
                print("An error occurred: \(error.localizedDescription)")
            }
            if let place = place {
                completion(place)
                return
            }
            completion(nil);
        }
    }

    func getWalkingRoute(start: CLLocationCoordinate2D, destination: CLLocationCoordinate2D, completion: @escaping (GMSPolyline?, String?) -> Void) {
        let baseURL = "https://maps.googleapis.com/maps/api/directions/json?"
        
        let origin = "\(start.latitude),\(start.longitude)"
        let destination = "\(destination.latitude),\(destination.longitude)"
        
        let apiKey = Constants.SecretKeys.GoogleMapsSecretKey
        
        let mode = "walking"
        
        let urlString = "\(baseURL)origin=\(origin)&destination=\(destination)&mode=\(mode)&key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL.")
            completion(nil, "Invalid URL.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(String(describing: error?.localizedDescription))")
                completion(nil, "Error: \(String(describing: error?.localizedDescription))")
                return
            }
            print(String(decoding: data, as: UTF8.self))
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let routes = json["routes"] as? [[String: Any]],
                   let firstRoute = routes.first,
                   let overviewPolyline = firstRoute["overview_polyline"] as? [String: Any],
                   let polylineString = overviewPolyline["points"] as? String {
                    
                    // Decode polyline string to get path
                    let path = GMSPath(fromEncodedPath: polylineString)
                    let polyline = GMSPolyline(path: path)
                    completion(polyline, nil)
                } else {
                    print("No routes found.")
                    completion(nil, "No routes found.")
                }
            } catch {
                print("Error parsing JSON: \(error)")
                completion(nil, "Error parsing JSON: \(error)")
            }
        }
        task.resume()
    }

}
