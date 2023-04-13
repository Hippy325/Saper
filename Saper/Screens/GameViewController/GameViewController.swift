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

class GameViewController: UIViewController {
	private struct Subviews {
		let timer = UILabel()
		let counterBomb = UILabel()
		let typeOfPress = UIButton()
		let settings = UIButton()
		let restart = UIButton()
	}

	private let factoryStackView: IFactoryStackView
	private let presenter: IGamePresenter

	private let subviews = Subviews()
	private let topView = UIView()
	private var plaingView = UIView()
	private var flag = Flag()

	init(
		factoryStackView: IFactoryStackView,
		presenter: IGamePresenter
	) {
		self.factoryStackView = factoryStackView
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .black
		presenter.newMatrix()
		setupTopView()
		setupSubviews()
		setupPlaingView()

		setupTopViewLayout()
		setupPlaingViewLayout()
	}

// MARK: - setup all View and subview

	private func setupTopView() {
		view.addSubview(topView)

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
		setupPlaingViewLayout()
	}

	@objc func settingsScreen() {
		presenter.goToSettingsScreen()
	}

	@objc
	private func newField() {
		presenter.newField()
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

	private func setupTopViewLayout() {
		topView.translatesAutoresizingMaskIntoConstraints = false
		subviews.settings.translatesAutoresizingMaskIntoConstraints = false
		subviews.counterBomb.translatesAutoresizingMaskIntoConstraints = false
		subviews.restart.translatesAutoresizingMaskIntoConstraints = false
		subviews.timer.translatesAutoresizingMaskIntoConstraints = false
		subviews.typeOfPress.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			topView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
			topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
			topView.heightAnchor.constraint(equalToConstant: 60),
			topView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

			subviews.settings.widthAnchor.constraint(equalToConstant: 45),
			subviews.settings.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
			subviews.settings.heightAnchor.constraint(equalToConstant: 45),
			subviews.settings.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 10),

			subviews.restart.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
			subviews.restart.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
			subviews.restart.heightAnchor.constraint(equalToConstant: 45),
			subviews.restart.widthAnchor.constraint(equalToConstant: 45),

			subviews.typeOfPress.widthAnchor.constraint(equalToConstant: 45),
			subviews.typeOfPress.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
			subviews.typeOfPress.heightAnchor.constraint(equalToConstant: 45),
			subviews.typeOfPress.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: -10),

			subviews.counterBomb.rightAnchor.constraint(equalTo: subviews.restart.leftAnchor, constant: -4),
			subviews.counterBomb.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
			subviews.counterBomb.heightAnchor.constraint(equalToConstant: 45),
			subviews.counterBomb.leftAnchor.constraint(equalTo: subviews.settings.rightAnchor, constant: 4),

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

private extension GameViewController {
	func getHeight(width: CGFloat) -> CGFloat {
		let xFactor = (width - 24) / 7
		return (33 + 11*xFactor)
	}
}

extension GameViewController: IGameView {

	func updateCounterBomb(bomb: String) {
		subviews.counterBomb.text = bomb
	}

	func updateTime(time: String) {
		self.subviews.timer.text = time
	}

	func updatePlaingView(countCell: Int, countCollumn: Int, countRow: Int) {
		factoryStackView.makeHorisontalStack(
			playingView: plaingView,
			countCell: countCell,
			countCollumn: countCollumn,
			countRow: countRow
		)
	}
}

extension UIView {
	func pin(to view: UIView, edges: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
		[
			topAnchor.constraint(equalTo: view.topAnchor, constant: edges.top),
			leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: edges.left),
			trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: edges.right),
			bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: edges.bottom)
		]
	}
}
