//
//  ViewController.swift
//  Saper
//
//  Created by User on 26.07.2022.
//

// enum TypePress {
//	case wet
//	case discovery
// }

import UIKit

class ViewController: UIViewController {

	private let creatingStackView: ICreatingStackView
	private let presenter: IViewControllerPresenter
	private let router: IViewControllerRouter

	init(creatingStackView: ICreatingStackView, presenter: IViewControllerPresenter, router: IViewControllerRouter) {
		self.creatingStackView = creatingStackView
		self.presenter = presenter
		self.router = router
		super.init(nibName: nil, bundle: nil)
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private struct Subviews {
		let timer = UILabel()
		let counterBomb = UILabel()
		let typeOfPress = UIButton()
		let settings = UIButton()
		let restart = UIButton()
	}
	private let subviews = Subviews()
	private let topView = UIView()
	private let plaingView = UIView()
	private var flag = Flag()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .black
		presenter.newMatrix(cell: 77, bomb: 10)
		setupTopView()
		setupSubviews()
		setupPlaingView()
	}

// MARK: - setup all View and subview

	private func setupTopView() {
		view.addSubview(topView)
		topView.translatesAutoresizingMaskIntoConstraints = false

		topView.backgroundColor = .lightGray
		topView.layer.borderColor = UIColor.darkGray.cgColor
		topView.layer.borderWidth = 5
		topView.layer.cornerRadius = 20

		topView.addSubview(subviews.settings)
		topView.addSubview(subviews.counterBomb)
		topView.addSubview(subviews.restart)
		topView.addSubview(subviews.timer)
		topView.addSubview(subviews.typeOfPress)
	}

	private func setupSubviews() {
		subviews.settings.translatesAutoresizingMaskIntoConstraints = false
		subviews.counterBomb.translatesAutoresizingMaskIntoConstraints = false
		subviews.restart.translatesAutoresizingMaskIntoConstraints = false
		subviews.timer.translatesAutoresizingMaskIntoConstraints = false
		subviews.typeOfPress.translatesAutoresizingMaskIntoConstraints = false

		subviews.settings.layer.addSublayer(Settings().setings())
		subviews.settings.addTarget(self, action: #selector(settingsScreen), for: .touchUpInside)

		subviews.restart.layer.addSublayer(Play().play())
		subviews.restart.backgroundColor = .darkGray
		subviews.restart.addTarget(self, action: #selector(newField), for: .touchUpInside)

		subviews.counterBomb.backgroundColor = .darkGray
		subviews.counterBomb.textColor = .green
		subviews.counterBomb.text = "010"
		subviews.counterBomb.textAlignment = .right
		subviews.counterBomb.font = UIFont.systemFont(ofSize: 45)

		subviews.timer.backgroundColor = .darkGray
		subviews.timer.textColor = .green
		subviews.timer.text = "000"
		subviews.timer.textAlignment = .left
		subviews.timer.font = UIFont.systemFont(ofSize: 45)

		subviews.typeOfPress.layer.addSublayer(flag.flag(color: .red))
		subviews.typeOfPress.addTarget(self, action: #selector(typeBomb), for: .touchUpInside)
	}

	private func setupPlaingView() {
		view.addSubview(plaingView)
		plaingView.translatesAutoresizingMaskIntoConstraints = false
		plaingView.backgroundColor = .lightGray
	}

	@objc func settingsScreen() {
		router.pushSettingsScreen(screen: presenter)
	}

	@objc
	private func newField() {
		presenter.newField()
		updateTime(time: 0)
	}

	@objc
	private func typeBomb() {
		let typePress = presenter.changeType()
		if typePress {
			flag.setColor(color: .white)
		} else {
			flag.setColor(color: .red)
		}
	}

// MARK: - setup Layout

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		setupTopViewLayout()
		setupPlaingViewLayout()
	}

	private func setupTopViewLayout() {
		NSLayoutConstraint.activate([
			topView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
			topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
			topView.heightAnchor.constraint(equalToConstant: 60),
			topView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
		NSLayoutConstraint.activate([
			subviews.settings.widthAnchor.constraint(equalToConstant: 45),
			subviews.settings.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
			subviews.settings.heightAnchor.constraint(equalToConstant: 45),
			subviews.settings.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 10)
		])
		NSLayoutConstraint.activate([
			subviews.restart.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
			subviews.restart.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
			subviews.restart.heightAnchor.constraint(equalToConstant: 45),
			subviews.restart.widthAnchor.constraint(equalToConstant: 45)
		])
		NSLayoutConstraint.activate([
			subviews.typeOfPress.widthAnchor.constraint(equalToConstant: 45),
			subviews.typeOfPress.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
			subviews.typeOfPress.heightAnchor.constraint(equalToConstant: 45),
			subviews.typeOfPress.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: -10)
		])
		NSLayoutConstraint.activate([
			subviews.counterBomb.rightAnchor.constraint(equalTo: subviews.restart.leftAnchor, constant: -4),
			subviews.counterBomb.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
			subviews.counterBomb.heightAnchor.constraint(equalToConstant: 45),
			subviews.counterBomb.leftAnchor.constraint(equalTo: subviews.settings.rightAnchor, constant: 4)
		])
		NSLayoutConstraint.activate([
			subviews.timer.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
			subviews.timer.heightAnchor.constraint(equalToConstant: 45),
			subviews.timer.leftAnchor.constraint(lessThanOrEqualTo: subviews.restart.rightAnchor, constant: 4),
			subviews.timer.rightAnchor.constraint(equalTo: subviews.typeOfPress.leftAnchor, constant: -4)
		])
	}

	private func setupPlaingViewLayout() {
		NSLayoutConstraint.activate([
			plaingView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 15),
			plaingView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
			plaingView.heightAnchor.constraint(equalToConstant: getHeight(width: view.frame.size.width)),
			plaingView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
		])
	}
}

private extension ViewController {
	func getHeight(width: CGFloat) -> CGFloat {
		let xFactor = (width - 24) / 7
		return (33 + 11*xFactor)
	}
}

extension ViewController: IPresenterView {
	func updateCounterBomb(count: Int) {
		var text = "\(count)"
		if count < 100 {
			text = "0\(count)"
		}
		if count < 10 {
			text = "00\(count)"
		}
		if count < 0 {
			text = "\(count)"
		}
		subviews.counterBomb.text = text
	}

	func updateTime(time: Int) {
		var timeString = "\(time)"
		if time < 100 {
			timeString = "0\(time)"
		}
		if time < 10 {
			timeString = "00\(time)"
		}
		self.subviews.timer.text = timeString
	}

	func updatePlaingView(countCell: Int) {
		creatingStackView.creatingHoririsontalyStacks(view: plaingView, count: countCell)
	}
}
