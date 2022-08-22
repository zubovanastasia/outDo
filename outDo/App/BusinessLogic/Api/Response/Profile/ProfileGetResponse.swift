//
//  ProfileGetResponse.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

struct ProfileGetResponse: Codable {
    
    var result: ProfileGetResponseResult?
    var error: ApiResponseError?
}

struct ProfileGetResponseResult: Codable {
    
    var profile: Profile
}
