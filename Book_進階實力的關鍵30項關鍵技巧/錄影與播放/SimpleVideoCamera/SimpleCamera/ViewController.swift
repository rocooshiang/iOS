//
//  ViewController.swift
//  SimpleCamera
//
//  Created by Simon Ng on 25/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit


class ViewController: UIViewController {
  
  @IBOutlet weak var cameraButton:UIButton!
  
  let captureSession = AVCaptureSession()
  var currentDevice: AVCaptureDevice?
  var captureDeviceInput : AVCaptureDeviceInput?
  var videoFileOutput: AVCaptureMovieFileOutput?
  var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
  
  var isRecording = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Set high quality
    captureSession.sessionPreset = AVCaptureSessionPresetHigh
    
    let devices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo) as! [AVCaptureDevice]
    
    // Select input device
    for device in devices{
      if device.position == AVCaptureDevicePosition.Back{
        currentDevice = device
      }
    }
    do{
      captureDeviceInput = try AVCaptureDeviceInput(device: currentDevice)
    }catch{
      print("error: \(error)")
    }
    
    //Set output device
    videoFileOutput = AVCaptureMovieFileOutput()
    
    //Session coordinated use of input and output
    captureSession.addInput(captureDeviceInput)
    captureSession.addOutput(videoFileOutput)
    
    //Build a preview layer and start session
    //Support camera preview
    cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    view.layer.addSublayer(cameraPreviewLayer!)
    cameraPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
    cameraPreviewLayer?.frame = view.layer.frame
    view.bringSubviewToFront(cameraButton)
    captureSession.startRunning()
    
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if segue.identifier == "playVideo"{
      //Get the destination viewcontroller
      let videoPlayerViewController = segue.destinationViewController as! AVPlayerViewController
      
      let videoFileURL = sender as! NSURL
      videoPlayerViewController.player = AVPlayer(URL: videoFileURL)
    }
  }
  
  @IBAction func capture(sender: AnyObject) {
    if !isRecording{
      isRecording = true
      
      UIView.animateWithDuration(0.5, delay: 0.0, options: [.Repeat, .Autoreverse, .AllowUserInteraction], animations: { () -> Void in
        self.cameraButton.transform = CGAffineTransformMakeScale(0.5, 0.5)
        }, completion: nil)
      
      let outputPath = "\(NSTemporaryDirectory())output.mov"
      let outputFileURL = NSURL(fileURLWithPath: outputPath)
      videoFileOutput?.startRecordingToOutputFileURL(outputFileURL, recordingDelegate: self)
      
    }else{
      isRecording = false
      UIView.animateWithDuration(0.5, delay: 1.0, options: [], animations: { () -> Void in
        self.cameraButton.transform = CGAffineTransformMakeScale(1.0, 1.0)
        }, completion: nil)
      cameraButton.layer.removeAllAnimations()
      videoFileOutput?.stopRecording()
    }
  }
}

// MARK - AVCaptureFileOutputRecordingDelegate
extension ViewController : AVCaptureFileOutputRecordingDelegate{
  
  // Play the video after finish recording
  func captureOutput(captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!, fromConnections connections: [AnyObject]!, error: NSError!) {
    if error != nil{
      print("\(error.localizedDescription)")
      return
    }
    self.performSegueWithIdentifier("playVideo", sender: outputFileURL)
  }
  
}
    