// module Style
protocol Text {
	var fontSize: Float { get }
	var textColor: UIColor { get }
}

protocol Shape /*Boundary*/ {
	var cornerRadius: CGFloat { get }
	var borderColor: UIColor { get }
	var borderWidth: CGFloat { get }
	var clipToBounds: Bool { get }
}

class P1: Text {
	let fontSize: Float = 25
	let textColor: UIColor = UIColor.black
}

class P4: Text {
	let fontSize: Float = 14
	let textColor: UIColor = UIColor.black
}

class ThinRoundRect: Shape {
	let cornerRadius: CGFloat = 5
	let borderColor: UIColor = UIColor.red
	let borderWidth: CGFloat = 1
}

class ClippedRoundRect: ThinRoundRect {
	let clipToBounds: Bool = true
}

// module main

// struct LabelState {
// 	let title: String
// 	let textStyle: Style.Text = P1()
// }

extension UIView {
	func accept(state: Style.Shape) {
		layer.cornerRadius = state.cornerRadius
		layer.borderColor = state.borderColor
		layer.borderWidth = state.borderWidth
		clipToBounds = clipToBounds
	}
}

extension UILabel {
	func accept(state: Style.Text) {
		textColor = state.textColor
		fontSize = state.fontSize
	}
}

protocol Component {
	associatedtype Model
	associatedtype ViewState
	
	func viewState(for model: Model) -> ViewState
}

extension SomeView {
	func accept(state: SomeViewController.State) {
		label.accept(state: state.style.titleLabel.$0)

		button.accept(state: state.style.doneButton.$0)
		button.accept(state: state.style.doneButton.$1)
	}
}

class SomeViewController: UIViewController, Component {
	enum SomeState {
		case waiting
		case info(value: SomeSubstate)
		
		struct SomeSubstate {
			let title: String
		}
	}
	
	struct ViewState {
		let style = ( 
			titleLabel = (Style.P1()),
			doneButton = (Style.P4(), ThinRoundRect())
		)
	}
	
	func viewState(for model: SomeState) -> ViewState {
		return ViewState(title: "")
	}

	func apply(state: SomeState) {
		
	}
}