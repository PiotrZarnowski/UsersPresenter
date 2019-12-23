//
//  GenericTableViewDataSource.swift
//  UsersPresenter
//
//  Created by Piotr Żarnowski on 21/12/2019.
//  Copyright © 2019 Piotr Żarnowski. All rights reserved.
//

import UIKit

protocol ConfigurableCell {
    associatedtype ViewModel
    func configureCell(viewModel: ViewModel)
}


class GenericTableViewDataSource<W: ConfigurableCell>: NSObject, UITableViewDataSource where W: UITableViewCell {
    
    var models: [W.ViewModel]?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let models = models else {return 0}
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let models = models else {return UITableViewCell()}
        let cell = tableView.dequeueReusableCell(withIdentifier: W.description()) as! W
        cell.configureCell(viewModel: models[indexPath.row])
        return cell
    }
}

