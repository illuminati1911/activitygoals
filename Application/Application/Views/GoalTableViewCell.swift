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
            titleLabel.text = goalViewModel?.title
            descriptionLabel.text = goalViewModel?.description
            rewardLabel.text = goalViewModel?.rewardText
            goalTypeImageView.image = goalViewModel?.typeImage
        }
    }

    static let identifier = "goalcell"

    private let titleLabel = with(UILabel()) {
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }

    private let descriptionLabel = with(UILabel()) {
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }

    private let rewardLabel = UILabel()

     private let goalTypeImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(goalTypeImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(rewardLabel)

        goalTypeImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(10)
            make.size.equalTo(70)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(10)
            make.left.equalTo(goalTypeImageView.snp.right).offset(10)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.right.equalToSuperview().inset(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }

        rewardLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.left.equalTo(titleLabel.snp.left)
            make.bottom.right.equalToSuperview().inset(10)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
