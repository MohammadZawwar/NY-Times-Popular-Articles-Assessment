//
//  ArticleDetailView.swift
//  NY Times Most Popular Articles
//
//  Created by Mohammad Zawwar on 12/08/2025.
//

import UIKit
import SafariServices

class ArticleDetailView: UIViewController {
    
    // MARK: - Properties
    private let article: Article
    
    // MARK: - UI Elements
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bylineLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .systemBlue
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sectionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemGreen
        label.backgroundColor = .systemGreen.withAlphaComponent(0.1)
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let abstractLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let readFullArticleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Read Full Article", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initialization
    init(article: Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureWithArticle()
        setupConstraints()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Article Details"
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(bylineLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(sectionLabel)
        contentView.addSubview(abstractLabel)
        contentView.addSubview(readFullArticleButton)
        
        readFullArticleButton.addTarget(self, action: #selector(readFullArticleTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            bylineLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            bylineLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            bylineLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: bylineLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            sectionLabel.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            sectionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            sectionLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 80),
            sectionLabel.heightAnchor.constraint(equalToConstant: 24),
            
            abstractLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 24),
            abstractLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            abstractLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            readFullArticleButton.topAnchor.constraint(equalTo: abstractLabel.bottomAnchor, constant: 32),
            readFullArticleButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            readFullArticleButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            readFullArticleButton.heightAnchor.constraint(equalToConstant: 50),
            readFullArticleButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func configureWithArticle() {
        titleLabel.text = article.title
        bylineLabel.text = article.byline
        sectionLabel.text = article.section
        abstractLabel.text = article.abstract
        
        // Format the date
        if let date = formatDate(article.publishedDate) {
            dateLabel.text = date
        } else {
            dateLabel.text = article.publishedDate
        }
    }
    
    private func formatDate(_ dateString: String) -> String? {
        return DateFormatterUtility.formatToFullDate(dateString)
    }
    
    // MARK: - Actions
    @objc private func readFullArticleTapped() {
        guard let url = URL(string: article.url) else { return }
        
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true)
    }
}
