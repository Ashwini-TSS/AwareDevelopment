//
//  AutoRecordingVC.swift
//  Aware360
//
//  Created by Tecnovators on 19/05/21.
//

import UIKit
import AVFoundation
import AVKit



//class AutoRecordingVC : UIViewController,AVCaptureFileOutputRecordingDelegate {
//
//
//
//    var tempImage: UIImageView?
//
//    var captureSession: AVCaptureSession?
//    var stillImageOutput: AVCaptureStillImageOutput?
//    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
//    var currentCaptureDevice: AVCaptureDevice?
//        @IBOutlet weak var camPreview: UIView!
//           let movieOutput = AVCaptureMovieFileOutput()
//
//    @IBOutlet weak var camerabtn: UIButton!
//    @IBOutlet weak var flipbtn: UIButton!
//    var usingFrontCamera = false
//           var outputURL: URL!
//    var isfirst : Bool = true
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//        loadCamera()
//
//
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        videoPreviewLayer!.frame = self.camPreview.bounds
//    }
//
//    @IBAction func switchButtonAction(_ sender: Any) {
//        usingFrontCamera = !usingFrontCamera
//        loadCamera()
//    }
//
//
//    func getFrontCamera() -> AVCaptureDevice?{
//        let videoDevices = AVCaptureDevice.devices(for: AVMediaType.video)
//
//
//        for device in videoDevices{
//            let device = device as! AVCaptureDevice
//            if device.position == AVCaptureDevice.Position.front {
//                return device
//            }
//        }
//        return nil
//    }
//
//    func getBackCamera() -> AVCaptureDevice{
//        return AVCaptureDevice.default(for: AVMediaType.video)!
//    }
//
//
//
//    func loadCamera() {
//        if(captureSession == nil){
//            captureSession = AVCaptureSession()
//            captureSession!.sessionPreset = AVCaptureSession.Preset.photo
//        }
//        var error: NSError?
//        var input: AVCaptureDeviceInput!
//
//        currentCaptureDevice = (usingFrontCamera ? getFrontCamera() : getBackCamera())
//
//        do {
//            input = try AVCaptureDeviceInput(device: currentCaptureDevice!)
//        } catch let error1 as NSError {
//            error = error1
//            input = nil
//            print(error!.localizedDescription)
//        }
//
//        for i : AVCaptureDeviceInput in (self.captureSession?.inputs as! [AVCaptureDeviceInput]){
//            self.captureSession?.removeInput(i)
//        }
//        if(isfirst){
//
//        if error == nil && captureSession!.canAddInput(input) {
//            captureSession!.addInput(input)
//            stillImageOutput = AVCaptureStillImageOutput()
//            stillImageOutput?.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
//            if captureSession!.canAddOutput(stillImageOutput!) {
//                captureSession!.addOutput(stillImageOutput!)
//                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
//                videoPreviewLayer!.videoGravity = AVLayerVideoGravity.resizeAspectFill
//                videoPreviewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
//                //self.cameraPreviewSurface.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
//                self.camPreview.layer.addSublayer(videoPreviewLayer!)
//                self.camPreview.bringSubviewToFront(self.flipbtn)
//                self.camPreview.bringSubviewToFront(self.camerabtn)
//                //movie output
//                if ((self.captureSession?.canAddOutput(movieOutput)) != nil) {
//                    self.captureSession?.addOutput(movieOutput)
//                }}
//                DispatchQueue.main.async { [self] in
//                    self.captureSession!.startRunning()
//                    if(isfirst){
//                    self.outputURL = self.tempURL()
//                    movieOutput.startRecording(to: self.outputURL, recordingDelegate: self)
//                    }
//                    isfirst = false
//
//                }
//
//
//            }
//        }
//
//
//
//    }
//            func capture(_ captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!) {
//
//            }
//    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
//        if (error != nil) {
//
//                        print("Error recording movie: \(error!.localizedDescription)")
//
//                    } else {
//
//                        let videoRecorded = outputURL! as URL
//
//        //                let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
//                        let player = AVPlayer(url: videoRecorded)
//                        let playerViewController = AVPlayerViewController()
//                        playerViewController.player = player
//                        self.present(playerViewController, animated: true) {
//                            playerViewController.player!.play()
//                        }
//        //                performSegue(withIdentifier: "showVideo", sender: videoRecorded)
//
//                    }
//
//                }
//            func tempURL() -> URL? {
//                let directory = NSTemporaryDirectory() as NSString
//
//                if directory != "" {
//                    let path = directory.appendingPathComponent(NSUUID().uuidString + ".mp4")
//                    return URL(fileURLWithPath: path)
//                }
//
//                return nil
//            }
//
//    @IBAction func stopRecording(_ sender: UIButton) {
//        self.stopRecording()
//    }
//    func stopRecording() {
////              if movieOutput.isRecording == true {
//                  movieOutput.stopRecording()
////               }
//          }
//}


  

class AutoRecordingVC: UIViewController,AVCaptureFileOutputRecordingDelegate {

    @IBOutlet weak var camPreview: UIView!

    @IBOutlet weak var cameraButton: UIButton!

       let captureSession = AVCaptureSession()

       let movieOutput = AVCaptureMovieFileOutput()

       var previewLayer: AVCaptureVideoPreviewLayer!

       var activeInput: AVCaptureDeviceInput!

       var outputURL: URL!

    override func viewDidLoad() {
        super.viewDidLoad()
        if setupSession(post: "front") {
                  setupPreview()
                  startSession()
              }

              cameraButton.isUserInteractionEnabled = true
              let cameraButtonRecognizer = UITapGestureRecognizer(target: self, action: #selector(AutoRecordingVC.startCapture))
              cameraButton.addGestureRecognizer(cameraButtonRecognizer)

//              cameraButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//
//              cameraButton.backgroundColor = UIColor.red
//
//              camPreview.addSubview(cameraButton)
    }


    func setupPreview() {
        // Configure previewLayer
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = camPreview.bounds
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
//        camPreview.layer.addSublayer(previewLayer)
        camPreview.layer.insertSublayer(previewLayer, at: 0)
        camPreview.bringSubviewToFront(self.cameraButton)

    }
    //MARK:- Setup Camera

    func setupSession(post : String) -> Bool {

          captureSession.sessionPreset = AVCaptureSession.Preset.high
          // Setup Camera
//          var camera = AVCaptureDevice.default(for: AVMediaType.video)!
        var camera : AVCaptureDevice!
        if(post == "front")
        {
             camera = getDevice(position: .front)!

        }else
        {
             camera = getDevice(position: .back)!

        }
          do {
            let input = try AVCaptureDeviceInput(device: camera)

              if captureSession.canAddInput(input) {
                  captureSession.addInput(input)
                  activeInput = input
              }
          } catch {
              print("Error setting device video input: \(error)")
              return false
          }

          // Setup Microphone
          let microphone = AVCaptureDevice.default(for: AVMediaType.audio)!

          do {
              let micInput = try AVCaptureDeviceInput(device: microphone)
              if captureSession.canAddInput(micInput) {
                  captureSession.addInput(micInput)
              }
          } catch {
              print("Error setting device audio input: \(error)")
              return false
          }


          // Movie output
          if captureSession.canAddOutput(movieOutput) {
              captureSession.addOutput(movieOutput)
          }

          return true
      }

    func getDevice(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let devices: NSArray = AVCaptureDevice.devices() as NSArray
       for de in devices {
          let deviceConverted = de as! AVCaptureDevice
          if(deviceConverted.position == position){
             return deviceConverted
          }
       }
       return nil
    }

      func setupCaptureMode(_ mode: Int) {
          // Video Mode

      }
    //MARK:- Camera Session
       func startSession() {

           if !captureSession.isRunning {
               videoQueue().async {
                   self.captureSession.startRunning()
               }
           }
       }

       func stopSession() {
           if captureSession.isRunning {
               videoQueue().async {
                   self.captureSession.stopRunning()
               }
           }
       }
    func videoQueue() -> DispatchQueue {
            return DispatchQueue.main
        }

        func currentVideoOrientation() -> AVCaptureVideoOrientation {
            var orientation: AVCaptureVideoOrientation

            switch UIDevice.current.orientation {
                case .portrait:
                    orientation = AVCaptureVideoOrientation.portrait
                case .landscapeRight:
                    orientation = AVCaptureVideoOrientation.landscapeLeft
                case .portraitUpsideDown:
                    orientation = AVCaptureVideoOrientation.portraitUpsideDown
                default:
                     orientation = AVCaptureVideoOrientation.landscapeRight
             }
             return orientation
         }

        @objc func startCapture() {

            startRecording()

        }
    //EDIT 1: I FORGOT THIS AT FIRST
        func tempURL() -> URL? {
            let directory = NSTemporaryDirectory() as NSString

            if directory != "" {
                let path = directory.appendingPathComponent(NSUUID().uuidString + ".mp4")
                return URL(fileURLWithPath: path)
            }

            return nil
        }

//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//            let vc = segue.destination as! VideoPlaybackViewController
//
//            vc.videoURL = sender as? URL
//
//        }

        func startRecording() {

            if movieOutput.isRecording == false {

                let connection = movieOutput.connection(with: AVMediaType.video)
                self.cameraButton.setImage(UIImage(named: "record"), for: .normal)
                if (connection?.isVideoOrientationSupported)! {
                    connection?.videoOrientation = currentVideoOrientation()
                }

                if (connection?.isVideoStabilizationSupported)! {
                    connection?.preferredVideoStabilizationMode = AVCaptureVideoStabilizationMode.auto
                }

                let device = activeInput.device

                if (device.isSmoothAutoFocusSupported) {

                    do {
                        try device.lockForConfiguration()
                        device.isSmoothAutoFocusEnabled = false
                        device.unlockForConfiguration()
                    } catch {
                       print("Error setting configuration: \(error)")
                    }

                }

                //EDIT2: And I forgot this
                outputURL = tempURL()
                movieOutput.startRecording(to: outputURL, recordingDelegate: self)

                }
                else {
                    self.cameraButton.setImage(UIImage(named: "stoprecord"), for: .normal)
                    stopRecording()
                }

           }

       func stopRecording() {

           if movieOutput.isRecording == true {
               movieOutput.stopRecording()
            }
       }

        func capture(_ captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!) {

        }

        func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {

            if (error != nil) {

                print("Error recording movie: \(error!.localizedDescription)")

            } else {

                let videoRecorded = outputURL! as URL

//                let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
                let player = AVPlayer(url: videoRecorded)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                self.present(playerViewController, animated: true) {
                    playerViewController.player!.play()
                }
//                performSegue(withIdentifier: "showVideo", sender: videoRecorded)

            }

        }


}
