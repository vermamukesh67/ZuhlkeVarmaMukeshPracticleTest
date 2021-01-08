//
//  Items.swift
//  ZuhlkeVarmaMukeshPracticleTest
//
//  Created by verma mukesh on 8/1/21.
//

import Foundation

struct Items : Codable {
	let timestamp : String?
	let cameras : [Cameras]?

	enum CodingKeys: String, CodingKey {

		case timestamp = "timestamp"
		case cameras = "cameras"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		timestamp = try values.decodeIfPresent(String.self, forKey: .timestamp)
		cameras = try values.decodeIfPresent([Cameras].self, forKey: .cameras)
	}

}
