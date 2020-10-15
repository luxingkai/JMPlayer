# JMPlayer 视频播放器 (CoreMIDI:与MIDI设备通信，如硬件键盘和合成器。)
基于AVFoundation框架创建的简易播放器        
AVFoundation框架主要包含以下六个方面的技术      
<1>.加载、检查和导出媒体资源和元数据，并执行媒体样本数据的低层读写。
<2>.获取并检查媒体资源;用于回放和自定义回放行为的队列媒体;编辑和合并资产;导入和导出原始媒体流。   
<3>.拍摄照片，录制视频和音频;配置内置摄像头和麦克风或外部捕获设备。
<4>.在一个组合中合并、编辑和混合来自多个来源的音频和视频轨道。
<5>. 

在创建一个通用播放器时，更多依赖的是第一个技术的应用。

#资源类    
AVAsset    
AVFragmentedAsset   
AVURLAsset    
AVAssetTrack    
#播放类    
AVPlayerItem    
AVPlayer    
AVQueuePlayer   
AVPlayerItemTrack   
#展示层    
AVPlayerLayer   
#元数据操作    
AVMetadataItem    
AVMetadataGroup      
AVMetadataItemFilter    
AVMetadataItemValueRequest    
#直播流
#样本数据修改   
AVSampleBufferRequest      
AVSampleCursor          
AVSampleBufferGenerator   
#多媒体资源组合和编辑   
AVComposition      
AVCompositionTrack        
AVCompositionTrackSegment   
AVMutableComposition    
AVMutableCompositionTrack   

#应用进入后台的音频播放处理：    
在应用配置的后台模式(Background Modes)打开音频播放;   
在代理类的进入前台和后台的代理方法中处理音频的播放；    
在锁屏情况下支持从控制中心控制后台音频播放，结合 MediaPlayer 框架控制；


# JMCamera（自定义相机）          
框架内通过硬件设备获取图片或者视音频的架构       
·AVCaptureSession        
·AVCaptureInput(AVCaptureDevice) 输入需要添加指定类型的输入设备(视频、音频)     
·AVCaptureOutput        
  AVCaptureVideoDataOutput      
  AVCapturePhotoOutput      
  AVCaptureAudioDataOutput
  AVCaptureFileOutput           
  AVCaptureAudioPreviewOutput   
  AVCaptureDepthDataOutput      
  AVCaptureMetadataOutput       
      
1>. 请求用户授权访问硬件设备 [AVCaptureDevice  requestAccess]   
2>. 捕捉任务：

  





