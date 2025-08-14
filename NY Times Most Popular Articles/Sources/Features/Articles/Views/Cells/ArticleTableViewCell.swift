//
//  ArticleTableViewCell.swift
//  NY Times Most Popular Articles
//
//  Created by Mohammad Zawwar on 12/08/2025.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    static let identifier = "ArticleTableViewCell"
    
    // MARK: - UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let abstractLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 3
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bylineLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .tertiaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sectionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        label.textColor = .systemGreen
        label.backgroundColor = .systemGreen.withAlphaComponent(0.1)
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(abstractLabel)
        contentView.addSubview(bylineLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(sectionLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            abstractLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            abstractLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            abstractLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            bylineLabel.topAnchor.constraint(equalTo: abstractLabel.bottomAnchor, constant: 8),
            bylineLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            bylineLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: bylineLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            sectionLabel.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            sectionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            sectionLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 60),
            sectionLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    // MARK: - Configuration
    func configure(with article: Article) {
        titleLabel.text = article.title
        abstractLabel.text = article.abstract
        bylineLabel.text = article.byline
        sectionLabel.text = article.section
        
        // Format the date
        if let date = formatDate(article.publishedDate) {
            dateLabel.text = date
        } else {
            dateLabel.text = article.publishedDate
        }
    }
    
    private func formatDate(_ dateString: String) -> String? {
        return DateFormatterUtility.formatToMediumDate(dateString)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        abstractLabel.text = nil
        bylineLabel.text = nil
        dateLabel.text = nil
        sectionLabel.text = nil
    }
}
