//
//  TrafficImageData.swift
//  ZuhlkeVarmaMukeshPracticleTest
//
//  Created by verma mukesh on 8/1/21.
//

import Foundation

struct TrafficImageData : Codable {
	let items : [Items]?
	let apiInfo : ApiInfo?

	enum CodingKeys: String, CodingKey {

		case items = "items"
		case apiInfo = "api_info"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		items = try values.decodeIfPresent([Items].self, forKey: .items)
        apiInfo = try values.decodeIfPresent(ApiInfo.self, forKey: .apiInfo)
	}
}
