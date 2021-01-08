//
//  Location.swift
//  ZuhlkeVarmaMukeshPracticleTest
//
//  Created by verma mukesh on 8/1/21.
//

import Foundation

struct Location : Codable {
	let latitude : Double?
	let longitude : Double?

	enum CodingKeys: String, CodingKey {

		case latitude = "latitude"
		case longitude = "longitude"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
		longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
	}

}
