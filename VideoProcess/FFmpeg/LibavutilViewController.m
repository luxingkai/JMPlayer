//
//  LibavutilViewController.m
//  VideoProcess
//
//  Created by tigerfly on 2021/3/6.
//  Copyright © 2021 tiger fly. All rights reserved.
//

#import "LibavutilViewController.h"

#include <libavutil/avutil.h>

// Crypto and Hashing
#include <libavutil/aes.h>
#include <libavutil/base64.h>
#include <libavutil/blowfish.h>
#include <libavutil/camellia.h>
#include <libavutil/cast5.h>
#include <libavutil/hash.h>
#include <libavutil/hmac.h>
#include <libavutil/lzo.h>
#include <libavutil/tea.h>
#include <libavutil/twofish.h>
#include <libavutil/xtea.h>
#include <libavutil/random_seed.h>


//Mathematics
#include <libavutil/mathematics.h>

//String Manipulation
#include <libavutil/avstring.h>

//Memory Management
#include <libavutil/mem.h>

//Data Structures
#include <libavutil/buffer.h>
#include <libavutil/frame.h>
#include <libavutil/opt.h>
#include <libavutil/dict.h>

//Video related
#include <libavutil/display.h>
#include <libavutil/stereo3d.h>

//Audio related
#include <libavutil/audio_fifo.h>
#include <libavutil/channel_layout.h>
#include <libavutil/downmix_info.h>
#include <libavutil/samplefmt.h>

//Error
#include <libavutil/error.h>

//Log
#include <libavutil/log.h>


//Other
#include <libavutil/macros.h>
#include <libavutil/version.h>
#include <libavdevice/avdevice.h>

@interface LibavutilViewController ()

@end

@implementation LibavutilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    
    /*
     Common utility Library
     
     libavutil is designed to be modular. In most cases, in order
     to use the functions provided by one component of libavutil
     you must explicitly include the specific header containing that
     feature. If you are only using media-related components, you
     could simply include libavutil/avutil.h, which brings in most
     of the "core" components.
     */

    
    /**
     Modules
     
     •  Crypto and Hashing
     •  Mathematics
     •  String Manipulation
     •  Memory Management
     •  Data Structures
     •  Video related
     •  Audio related
     •  Error Codes
     •  Logging Facility
     */
    
    /**
     Files
     
     avutil.h
     macros.h
     version.h
     */
    
    
#pragma mark -- Crypto and Hashing
    
    uint32_t random_seed = av_get_random_seed();

    
    
#pragma mark -- Mathematics
    
//    av_gcd(<#int64_t a#>, <#int64_t b#>)
//    av_rescale(<#int64_t a#>, <#int64_t b#>, <#int64_t c#>)
//    av_rescale_rnd(<#int64_t a#>, <#int64_t b#>, <#int64_t c#>, <#enum AVRounding#>)
//    av_rescale_q(<#int64_t a#>, <#AVRational bq#>, <#AVRational cq#>)
//    av_rescale_q_rnd(<#int64_t a#>, <#AVRational bq#>, <#AVRational cq#>, <#enum AVRounding#>)
//    av_compare_ts(<#int64_t ts_a#>, <#AVRational tb_a#>, <#int64_t ts_b#>, <#AVRational tb_b#>)
//    av_compare_mod(<#uint64_t a#>, <#uint64_t b#>, <#uint64_t mod#>)
//    av_rescale_delta(<#AVRational in_tb#>, <#int64_t in_ts#>, <#AVRational fs_tb#>, <#int duration#>, <#int64_t *last#>, <#AVRational out_tb#>)
//    av_add_stable(<#AVRational ts_tb#>, <#int64_t ts#>, <#AVRational inc_tb#>, <#int64_t inc#>)
    
    
    
    
#pragma mark -- String Manipulation
    
//    av_strstart(<#const char *str#>, <#const char *pfx#>, <#const char **ptr#>)
//    av_stristart(<#const char *str#>, <#const char *pfx#>, <#const char **ptr#>)
//    av_stristr(<#const char *haystack#>, <#const char *needle#>)
//    av_strnstr(<#const char *haystack#>, <#const char *needle#>, <#size_t hay_length#>)
//    av_strlcpy(<#char *dst#>, <#const char *src#>, <#size_t size#>)
//    av_strlcat(<#char *dst#>, <#const char *src#>, <#size_t size#>)
//    av_strlcatf(<#char *dst#>, <#size_t size#>, <#const char *fmt, ...#>)
//    av_strnlen(<#const char *s#>, <#size_t len#>)
//    av_asprintf(<#const char *fmt, ...#>)
//    av_d2str(<#double d#>)
//    av_get_token(<#const char **buf#>, <#const char *term#>)
//    av_strtok(<#char *s#>, <#const char *delim#>, <#char **saveptr#>)
//    av_isdigit(<#int c#>)
//    av_isgraph(<#int c#>)
//    av_isspace(<#int c#>)
//    av_toupper(<#int c#>)
//    av_tolower(<#int c#>)
//    av_isxdigit(<#int c#>)
//    av_strcasecmp(<#const char *a#>, <#const char *b#>)
//    av_strncasecmp(<#const char *a#>, <#const char *b#>, <#size_t n#>)
//    av_basename(<#const char *path#>)
//    av_dirname(<#char *path#>)
//    av_match_name(<#const char *name#>, <#const char *names#>)
//    av_append_path_component(<#const char *path#>, <#const char *component#>)
//    av_match_list(<#const char *name#>, <#const char *list#>, <#char separator#>)
    
    
#pragma mark -- Memory Management
        
    /**
     Utilities for manipulating memory.
     
     FFmpeg has several applications of memory that are not
     required of a typical program. For example, the computing
     -heavy components like video decoding and encoding can be
     speed up significantly through the use of aligned memory.
     
     However, for each of FFmpeg's applications of memory, there
     might not be a recognized or standardized API for that
     specific use. Memory alignment, for instancce, varies wildly
     depending on operating systems, architectures, and compilers.
     Hence, this component of libavutil is created to make dealing
     with memory consistently possible on all platforms.
     */
    
    
//    av_dynarray_add(<#void *tab_ptr#>, <#int *nb_ptr#>, <#void *elem#>)
//    av_size_mult(<#size_t a#>, <#size_t b#>, <#size_t *r#>)
//    av_max_alloc(<#size_t max#>)
    
    
    
#pragma mark -- Data Structures
    
    
    
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
