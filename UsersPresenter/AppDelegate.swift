//
//  AppDelegate.swift
//  UsersPresenter
//
//  Created by Piotr Żarnowski on 17/12/2019.
//  Copyright © 2019 Piotr Żarnowski. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


            var window: UIWindow?

            func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
                window = UIWindow(frame: UIScreen.main.bounds)
                let fetchUsersUseCase = DefaultFetchUsersUseCase(usersRepository: DefaultUsersRepository(dataTransferService: WebService()))
                let rootViewController = UsersListTableViewController()
                rootViewController.viewModel = DefaultUsersListViewModel(fetchUsersUseCase: fetchUsersUseCase)
                let nc = UINavigationController(rootViewController: rootViewController)
                if #available(iOS 11.0, *) {
                    nc.navigationBar.prefersLargeTitles = true
                }
                window?.rootViewController = nc
                window?.makeKeyAndVisible()

                            
                return true
            }
        }

