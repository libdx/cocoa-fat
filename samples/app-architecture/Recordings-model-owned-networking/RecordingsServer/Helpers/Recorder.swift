import Foundation
import AVFoundation

final class Recorder: NSObject, AVAudioRecorderDelegate {
	private var audioRecorder: AVAudioRecorder?
	private var timer: Timer?
	private var update: (TimeInterval?) -> ()
	let url: URL
	
	init?(url: URL, update: @escaping (TimeInterval?) -> ()) {
		self.update = update
		self.url = url
		
		super.init()
		
		self.start(url)
	}
	
	private func start(_ url: URL) {
		// Audio will be 32kbps HE-AAC mono.
		let settings: [String: Any] = [
			AVFormatIDKey: kAudioFormatMPEG4AAC_HE,
			AVSampleRateKey: 44100.0 as Float,
			AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue,
			AVNumberOfChannelsKey: 1
		]
		if let recorder = try? AVAudioRecorder(url: url, settings: settings) {
			recorder.delegate = self
			audioRecorder = recorder
			recorder.record()
			timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
				self.update(self.audioRecorder?.currentTime)
			}
		} else {
			update(nil)
		}
	}
	
	func stop() {
		audioRecorder?.stop()
		timer?.invalidate()
	}
	
	func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
		if flag {
			stop()
		} else {
			update(nil)
		}
	}
}
