//
//  GoalTableViewCell.swift
//  Application
//
//  Created by Ville Välimaa on 2020/6/8.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import UIKit
import Core

class GoalTableViewCell: UITableViewCell {

    var goalViewModel: GoalViewModel? {
        didSet {
            titleLabel.text = goalViewModel?.displayText
            rewardLabel.text = goalViewModel?.rewardText
        }
    }

    static let identifier = "goalcell"

    let titleLabel = with(UILabel()) {
        $0.text = "Simple walk -  walk 5000 steps"
    }

    let rewardLabel = with(UILabel()) {
        $0.text = "Reward: 1000 points"
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .green

        addSubview(titleLabel)
        addSubview(rewardLabel)

        titleLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(10)
        }

        rewardLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.bottom.right.equalToSuperview().inset(10)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
