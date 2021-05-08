//
//  FFmpegViewController.m
//  VideoProcess
//
//  Created by tigerfly on 2021/3/4.
//  Copyright © 2021 tiger fly. All rights reserved.
//

#import "FFmpegViewController.h"
@interface FFmpegViewController ()

@end

@implementation FFmpegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    /*
     Each of the FFmpeg libraries contains a version.h header,
     which defines a major, minor and micro version number with
     the LIBRARYNAME_VERSION_{MAJOR,MINOR,MICRO} macros. The
     major version number is incremented with backward incompatible
     changes - e.g. removing parts of the public API, reordering
     public struct members, etc. The minor version number is
     incremented for backward compatible API changes or major new
     features - e.g. adding a new public function or a new decoder.
     The micro version number is incremented for smaller changes
     that a calling program might still want to check for - e.g.
     changing behavior in a previously unspecified situation.

     FFmpeg guarantees backward API and ABI compatibility for
     each library as long as its major version number is
     unchanged. This means that no public symbols will be
     removed or renamed. Types and names of the public struct
     members and values of public macros and enums will remain
     the same (unless they were explicitly declared as not
     part of the public API). Documented behavior will not
     change.

     In other words, any correct program that works with a
     given FFmpeg snapshot should work just as well without
     any changes with any later snapshot with the same major
     versions. This applies to both rebuilding the program
     against new FFmpeg versions or to replacing the dynamic
     FFmpeg libraries that a program links against.

     However, new public symbols may be added and new members
     may be appended to public structs whose size is not
     part of public ABI (most public structs in FFmpeg).
     New macros and enum values may be added. Behavior in
     undocumented situations may change slightly (and be
     documented). All those are accompanied by an entry in
     doc/APIchanges and incrementing either the minor or
     micro version number.
    */
    
    
    
    
#pragma mark -- Libavutil
    
    /*
     The libavutil library is a utility library to aid portable
     multimedia programming. It contains safe portable string
     functions, random number generators, data structures,
     additional mathematics functions, cryptography and multimedia
     related functionality (like enumerations for pixel and
     sample formats). It is not a library for code needed by
     both libavcodec and libavformat.

     The goals for this library is to be:

     Modular
     It should have few interdependencies and the possibility
     of disabling individual parts during ./configure.

     Small
     Both sources and objects should be small.

     Efficient
     It should have low CPU and memory usage.

     Useful
     It should avoid useless features that almost no one needs.
     */
    
    
    
#pragma mark -- Libswscale
    
    /*
     The libswscale library performs highly optimized image scaling
     and colorspace and pixel format conversion operations.

     Specifically, this library performs the following conversions:

     •  Rescaling: is the process of changing the video size. Several
        rescaling options and algorithms are available. This is usually
        a lossy process.
     •  Pixel format conversion: is the process of converting the
        image format and colorspace of the image, for example from
        planar YUV420P to RGB24 packed. It also handles packing
        conversion, that is converts from packed layout (all pixels
        belonging to distinct planes interleaved in the same buffer),
        to planar layout (all samples belonging to the same plane
        stored in a dedicated buffer or "plane").
     
     This is usually a lossy process in case the source and destination
     colorspaces differ.
     */
    
    
    
#pragma mark -- Libswresample
    
    /*
     The libswresample library performs highly optimized audio
     resampling, rematrixing and sample format conversion operations.

     Specifically, this library performs the following conversions:

     •  Resampling: is the process of changing the audio rate, for
        example from a high sample rate of 44100Hz to 8000Hz. Audio
        conversion from high to low sample rate is a lossy process.
        Several resampling options and algorithms are available.
     •  Format conversion: is the process of converting the type of
        samples, for example from 16-bit signed samples to unsigned
        8-bit or float samples. It also handles packing conversion,
        when passing from packed layout (all samples belonging to
        distinct channels interleaved in the same buffer), to planar
        layout (all samples belonging to the same channel stored in a
        dedicated buffer or "plane").
     •  Rematrixing: is the process of changing the channel layout,
        for example from stereo to mono. When the input channels
        cannot be mapped to the output streams, the process is lossy,
        since it involves different gain factors and mixing.
     
     Various other audio conversions (e.g. stretching and padding)
     are enabled through dedicated options.
     */
    
    
    
#pragma mark -- Libavcodec
    
    /*
     The libavcodec library provides a generic encoding/decoding
     framework and contains multiple decoders and encoders for audio,
     video and subtitle streams, and several bitstream filters.

     The shared architecture provides various services ranging from
     bit stream I/O to DSP optimizations, and makes it suitable for
     implementing robust and fast codecs as well as for experimentation.
     */
    
    
    
#pragma mark -- Libavformat
    
    /*
     The libavformat library provides a generic framework for
     multiplexing and demultiplexing (muxing and demuxing) audio,
     video and subtitle streams. It encompasses multiple muxers and
     demuxers for multimedia container formats.

     It also supports several input and output protocols to access
     a media resource.
     */

    
    
#pragma mark -- Libavdevice
    
    /*
     The libavdevice library provides a generic framework for
     grabbing from and rendering to many common multimedia
     input/output devices, and supports several input and output
     devices, including Video4Linux2, VfW, DShow, and ALSA.
     */
    
    
    
#pragma mark -- Libavfilter
    
    /*
     The libavfilter library provides a generic audio/video
     filtering framework containing several filters, sources
     and sinks.
     */
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
