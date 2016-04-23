//
//  ViewController.swift
//  SimpleCamera
//
//  Created by Rocoo on 2016/4/23.
//  Copyright (c) 2016 Rocoo. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
  
  @IBOutlet weak var cameraButton:UIButton!
  
  let captureSession  = AVCaptureSession()
  var backFacingCamera : AVCaptureDevice?
  var frontFacingCamera : AVCaptureDevice?
  var currentDevice : AVCaptureDevice?
  
  var stillImageOutput : AVCaptureStillImageOutput?
  var stillImage : UIImage?
  
  var cameraPreviewLayer : AVCaptureVideoPreviewLayer?
  
  var toggleCameraGestureRecognizer = UISwipeGestureRecognizer()
  var zoomInGestureRecongnizer = UISwipeGestureRecognizer()
  var zoomOutGestureRecongnizer = UISwipeGestureRecognizer()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    captureSession.sessionPreset = AVCaptureSessionPresetPhoto
    
    // Get All of devices
    let devices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo) as! [AVCaptureDevice]
    
    for device in devices{
      if device.position == AVCaptureDevicePosition.Back{
        backFacingCamera = device
      }else if device.position == AVCaptureDevicePosition.Front{
        frontFacingCamera = device
      }
    }
    
    // Default camera is rear shot
    currentDevice = backFacingCamera
    
    do{
      // Set input device
      let captureDeviceInput = try AVCaptureDeviceInput(device: currentDevice)
      captureSession.addInput(captureDeviceInput)
      
      // Set output device
      stillImageOutput = AVCaptureStillImageOutput()
      stillImageOutput?.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
      captureSession.addOutput(stillImageOutput)
      
      // Set camera preview layer
      cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
      view.layer.addSublayer(cameraPreviewLayer!)
      cameraPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
      cameraPreviewLayer?.frame = view.layer.frame
      view.bringSubviewToFront(cameraButton)
      captureSession.startRunning()
      
    }catch let error as NSError{
      assert(false, error.localizedDescription)
    }
    
    // Set up gesture to toggle camera
    toggleCameraGestureRecognizer.direction = .Up
    toggleCameraGestureRecognizer.addTarget(self, action: "toggleCamera")
    view.addGestureRecognizer(toggleCameraGestureRecognizer)
    
    // Set right gesture to zoom in preview layer
    zoomInGestureRecongnizer.direction = .Right
    zoomInGestureRecongnizer.addTarget(self, action: "zoomIn")
    view.addGestureRecognizer(zoomInGestureRecongnizer)
    
    // Set Left gesture to zoom out preview layer
    zoomOutGestureRecongnizer.direction = .Left
    zoomOutGestureRecongnizer.addTarget(self, action: "zoomOut")
    view.addGestureRecognizer(zoomOutGestureRecongnizer)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showPhoto"{
      let photoViewController = segue.destinationViewController as! PhotoViewController
      photoViewController.image = stillImage
    }
  }
  
  
  
  @IBAction func capture(sender: AnyObject) {
    let videoConnection = stillImageOutput?.connectionWithMediaType(AVMediaTypeVideo)
    stillImageOutput?.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: { (imageDataSampleBuffer, error) -> Void in
      let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer)
      self.stillImage = UIImage(data: imageData)
      self.performSegueWithIdentifier("showPhoto", sender: self)
    })
  }
  
  func toggleCamera(){
    
    captureSession.beginConfiguration()
    
    // Toggle Camera
    let newDevice = (currentDevice?.position == AVCaptureDevicePosition.Back) ? frontFacingCamera : backFacingCamera
    
    // Remove all of session inputs
    for input in captureSession.inputs{
      captureSession.removeInput(input as! AVCaptureDeviceInput)
    }
    
    //Reset input
    do{
      let cameraInput = try AVCaptureDeviceInput(device: newDevice)
      if captureSession.canAddInput(cameraInput){
        captureSession.addInput(cameraInput)
      }
      currentDevice = newDevice
      captureSession.commitConfiguration()
      
    }catch let error as NSError{
      assert(false, error.localizedDescription)
    }
  }
  
  func zoomIn(){
    if let zoomFactor = currentDevice?.videoZoomFactor{
      if zoomFactor < 5.0{
        let newZoomFactor = min(zoomFactor + 1.0 , 5.0)
        do{
          try currentDevice?.lockForConfiguration()
          currentDevice?.rampToVideoZoomFactor(newZoomFactor, withRate: 1.0)
          currentDevice?.unlockForConfiguration()
        }catch let error as NSError{
          assert(false, error.localizedDescription)
        }
      }
    }
  }
  
  func zoomOut(){
    if let zoomFactor = currentDevice?.videoZoomFactor{
      if zoomFactor > 1.0{
        let newZoomFactor = max(zoomFactor - 1.0 , 1.0)
        do{
          try currentDevice?.lockForConfiguration()
          currentDevice?.rampToVideoZoomFactor(newZoomFactor, withRate: 1.0)
          currentDevice?.unlockForConfiguration()
        }catch let error as NSError{
          assert(false, error.localizedDescription)
        }
      }
    }
  }
  
}

    