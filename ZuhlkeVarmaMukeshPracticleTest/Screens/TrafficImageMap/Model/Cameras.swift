//
//  Cameras.swift
//  ZuhlkeVarmaMukeshPracticleTest
//
//  Created by verma mukesh on 8/1/21.
//

import Foundation

struct Cameras : Codable {
	let timestamp : String?
	let image : String?
	let location : Location?
	let camera_id : String?
	let image_metadata : Image_metadata?

	enum CodingKeys: String, CodingKey {

		case timestamp = "timestamp"
		case image = "image"
		case location = "location"
		case camera_id = "camera_id"
		case image_metadata = "image_metadata"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		timestamp = try values.decodeIfPresent(String.self, forKey: .timestamp)
		image = try values.decodeIfPresent(String.self, forKey: .image)
		location = try values.decodeIfPresent(Location.self, forKey: .location)
		camera_id = try values.decodeIfPresent(String.self, forKey: .camera_id)
		image_metadata = try values.decodeIfPresent(Image_metadata.self, forKey: .image_metadata)
	}

}
