//
//  LibavfilterViewController.m
//  VideoProcess
//
//  Created by tigerfly on 2021/5/10.
//  Copyright © 2021 tiger fly. All rights reserved.
//

#import "LibavfilterViewController.h"
#include <libavfilter/avfilter.h>
#include <libavfilter/version.h>


@interface LibavfilterViewController ()

@end

@implementation LibavfilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    /*
     The libavfilter library provides a generic audio/video filtering framework
     containing several filters, sources and sinks.     
     */
    
    AVFilterContext *context;
    
    unsigned int version = avfilter_version();
    const char *config = avfilter_configuration();
    const char *license = avfilter_license();

    
    
//    avfilter_pad_count(<#const AVFilterPad *pads#>)
//    avfilter_pad_get_name(<#const AVFilterPad *pads#>, <#int pad_idx#>)
//    avfilter_pad_get_type(<#const AVFilterPad *pads#>, <#int pad_idx#>)
    
//    avfilter_link(<#AVFilterContext *src#>, <#unsigned int srcpad#>, <#AVFilterContext *dst#>, <#unsigned int dstpad#>)
//    avfilter_link_free(<#AVFilterLink **link#>)
//    avfilter_link_set_closed(<#AVFilterLink *link#>, <#int closed#>)
//    avfilter_config_links(<#AVFilterContext *filter#>)
    
//    avfilter_process_command(<#AVFilterContext *filter#>, <#const char *cmd#>, <#const char *arg#>, <#char *res#>, <#int res_len#>, <#int flags#>)
    
//    avfilter_get_by_name(<#const char *name#>)
    
//    avfilter_init_str(<#AVFilterContext *ctx#>, <#const char *args#>)
//    avfilter_init_dict(<#AVFilterContext *ctx#>, <#AVDictionary **options#>)
    
//    avfilter_free(<#AVFilterContext *filter#>)
    
//    avfilter_insert_filter(<#AVFilterLink *link#>, <#AVFilterContext *filt#>, <#unsigned int filt_srcpad_idx#>, <#unsigned int filt_dstpad_idx#>)
    
    avfilter_get_class();
    
    AVFilterGraph *filterGraph = avfilter_graph_alloc();
    
//    avfilter_graph_alloc_filter(<#AVFilterGraph *graph#>, <#const AVFilter *filter#>, <#const char *name#>)
    
//    avfilter_graph_get_filter(<#AVFilterGraph *graph#>, <#const char *name#>)
    
//    avfilter_graph_create_filter(<#AVFilterContext **filt_ctx#>, <#const AVFilter *filt#>, <#const char *name#>, <#const char *args#>, <#void *opaque#>, <#AVFilterGraph *graph_ctx#>)
    
//    avfilter_graph_set_auto_convert(<#AVFilterGraph *graph#>, <#unsigned int flags#>)
    
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
