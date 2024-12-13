//
//  ViewController.swift
//  navigAId
//
//  Created by Christiana Georgakopoulou on 7/11/21.
//

import UIKit
import AVKit
import Vision

class ViewController: UIViewController,AVCaptureVideoDataOutputSampleBufferDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        let captureSession = AVCaptureSession()
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {return}
        guard let input =  try? AVCaptureDeviceInput(device: captureDevice) else {return}
        captureSession.addInput(input)
        captureSession.startRunning()
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
        //VNImageRequestHandler(cgImage: CGImage as! CGImage , options:[:]).perform([VNRequest])
        }
    func captureOutput(_ output: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer:  CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {return}
        let model: Navfinal = {
        do {
            let config = MLModelConfiguration()
            return try Navfinal(configuration: config)
        } catch {
            print(error)
            fatalError("Couldn't create model")
        }
        }()
        
        let request = VNCoreMLRequest(model: model) { (finishedReq, err) in
            guard let results = finishedReq.results as? [VNClassificationObservation] else {return}
            guard let firstObservation = results.first else {return}
            print(firstObservation.identifier, firstObservation.confidence)
        }
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
}






}
