//
//  ProfileViewModel.swift
//  Companions
//
//  Created by Tiana Patti on 11/17/22.
//

import Foundation
import UIKit

protocol ProfileViewControllerProtocol {
	var userName: String? { get }
}

protocol ProfileViewModelProtocol {
	
	func fetchData()
	func checkCampus(email: String) -> String
	var tableViewCount: Int { get }
	var projectInfoData: [ProjectsUsersModel] { get }
	var levelProgress: Float { get }
	var stringLevel: String { get }
	var email: String { get }
	var login: String { get }
	var wallet: String { get }
	var points: String { get }
	var location: String { get }
}

class ProfileViewModel {
	var x = Dynamic("")
	
	var delegate: ProfileViewControllerProtocol?
	
	var projectInfoData: [ProjectsUsersModel] = []
	private lazy var arrayWithCellData: [ProjectInfoModel] = []
	private lazy var cursusData: [CursusModel] = []
	
	private var userData: ModelData?
	
	var userName: String {
		return delegate?.userName ?? ""
	}
	
	
}

extension ProfileViewModel: ProfileViewModelProtocol {
	
	
	var stringLevel: String {
		return "\(levelProgress) %"
	}
	
	var email: String {
		userData?.email ?? ""
	}
	
	var login: String {
		return userData?.login ?? ""
	}
	
	var wallet: String {
		return "wallet: \(userData?.wallet ?? 0)₳"
	}
	
	var points: String {
		return "evaluation points: \(userData?.correction_point ?? 0)"
	}
	
	var location: String {
		return self.checkCampus(email: userData?.email ?? "kek@student.21-school.ru")
	}
	
	var levelProgress: Float {
//		guard let level = self.cursusData[1].level else { return 0.1 }
		
		//Mock
		 let level = 10.1

		return Float(level.truncatingRemainder(dividingBy: 1))
	}

	var tableViewCount: Int {
		projectInfoData.count
	}
	
	func fetchData() {
		NetworkService.shared.loadUser(userName: self.userName) { result in
			switch result {
			case .success(let data):
				self.userData = data
				self.projectInfoData = (data.projects_users ?? []).sorted {$0.finalMark ?? 0 > $1.finalMark ?? 0}
				self.cursusData = data.cursus_users
//				self.email = data.email ?? ""
//				self.login = data.login ?? ""
//				self.wallet = "wallet: \(data.wallet ?? 0)₳"
//				self.points = "evaluation points: \(data.correction_point ?? 0)"
//				self.location = self.checkCampus(email: data.email ?? "Moscow")
//				guard let level = self.cursusData[1].level else { return }
//				self.levelProgress = level.truncatingRemainder(dividingBy: 1)
//				self.stringLevel = "\(level) %"
				
			case .failure(let error):
				print(error)
			}
		}
	}
	
	func checkCampus(email: String) -> String {
		let mail = email
		let result = String(mail.split(separator: "@")[1])
		var campusName: String {
			switch result {
			case "student.21-school.ru": return "📍Moscow"
			case "student.42.fr": return "📍Paris"
			case "student.42tokyo.jp": return "📍Tokyo"
			default: return "📍Adelaide"
			}
		}
		return campusName
	}
}
