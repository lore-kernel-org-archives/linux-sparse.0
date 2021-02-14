Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E669C433E0
	for <linux-sparse@archiver.kernel.org>; Sun, 14 Feb 2021 17:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1367664DCF
	for <linux-sparse@archiver.kernel.org>; Sun, 14 Feb 2021 17:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhBNRRq (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 14 Feb 2021 12:17:46 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:49700 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229884AbhBNRRo (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 14 Feb 2021 12:17:44 -0500
X-Greylist: delayed 641 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Feb 2021 12:17:43 EST
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id CB983FB03;
        Sun, 14 Feb 2021 18:06:18 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3oNCoDZm0plg; Sun, 14 Feb 2021 18:06:16 +0100 (CET)
Date:   Sun, 14 Feb 2021 18:06:15 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        kbuild-all@lists.01.org, linux-sparse@vger.kernel.org
Subject: Re: [PATCH v2 2/4] usb: typec: tps6598x: Add trace event for status
 register
Message-ID: <YClYh7pqDlbXy8qh@bogon.m.sigxcpu.org>
References: <651ac50b9ff6ed3db8cab9f176514900f6a02a0c.1613131413.git.agx@sigxcpu.org>
 <20210213031237.GP219708@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210213031237.GP219708@shao2-debian>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Hi ,
On Sat, Feb 13, 2021 at 11:12:37AM +0800, kernel test robot wrote:
> Hi "Guido,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on usb/usb-testing]
> [also build test WARNING on v5.11-rc7 next-20210211]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Guido-G-nther/usb-typec-tps6598x-Add-IRQ-flag-and-register-tracing/20210212-200855
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> config: openrisc-randconfig-s032-20210209 (attached as .config)
> compiler: or1k-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.3-215-g0fb77bb6-dirty
>         # https://github.com/0day-ci/linux/commit/ba45e1d5e1fd25b6aed8724106e6c7d5adef7a20
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Guido-G-nther/usb-typec-tps6598x-Add-IRQ-flag-and-register-tracing/20210212-200855
>         git checkout ba45e1d5e1fd25b6aed8724106e6c7d5adef7a20
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=openrisc 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> "sparse warnings: (new ones prefixed by >>)"
>    drivers/usb/typec/tps6598x.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, drivers/usb/typec/tps6598x_trace.h):
> >> drivers/usb/typec/./tps6598x_trace.h:157:1: sparse: sparse: too long token expansion
> 

I looked around but didn't find any hints how to fix this. Any pointers
I missed (added the sparse list to cc:)?

Cheers,
 -- Guido

> vim +157 drivers/usb/typec/./tps6598x_trace.h
> 
> c90c0282e4ce33 Guido Günther 2021-02-12  156  
> ba45e1d5e1fd25 Guido Günther 2021-02-12 @157  TRACE_EVENT(tps6598x_status,
> ba45e1d5e1fd25 Guido Günther 2021-02-12  158  	    TP_PROTO(u32 status),
> ba45e1d5e1fd25 Guido Günther 2021-02-12  159  	    TP_ARGS(status),
> ba45e1d5e1fd25 Guido Günther 2021-02-12  160  
> ba45e1d5e1fd25 Guido Günther 2021-02-12  161  	    TP_STRUCT__entry(
> ba45e1d5e1fd25 Guido Günther 2021-02-12  162  			     __field(u32, status)
> ba45e1d5e1fd25 Guido Günther 2021-02-12  163  			     ),
> ba45e1d5e1fd25 Guido Günther 2021-02-12  164  
> ba45e1d5e1fd25 Guido Günther 2021-02-12  165  	    TP_fast_assign(
> ba45e1d5e1fd25 Guido Günther 2021-02-12  166  			   __entry->status = status;
> ba45e1d5e1fd25 Guido Günther 2021-02-12  167  			   ),
> ba45e1d5e1fd25 Guido Günther 2021-02-12  168  
> ba45e1d5e1fd25 Guido Günther 2021-02-12  169  	    TP_printk("conn: %s, pp_5v0: %s, pp_hv: %s, pp_ext: %s, pp_cable: %s, "
> ba45e1d5e1fd25 Guido Günther 2021-02-12  170  		      "pwr-src: %s, vbus: %s, usb-host: %s, legacy: %s, flags: %s",
> ba45e1d5e1fd25 Guido Günther 2021-02-12  171  		      show_status_conn_state(__entry->status),
> ba45e1d5e1fd25 Guido Günther 2021-02-12  172  		      show_status_pp_switch_state(TPS_STATUS_PP_5V0_SWITCH(__entry->status)),
> ba45e1d5e1fd25 Guido Günther 2021-02-12  173  		      show_status_pp_switch_state(TPS_STATUS_PP_HV_SWITCH(__entry->status)),
> ba45e1d5e1fd25 Guido Günther 2021-02-12  174  		      show_status_pp_switch_state(TPS_STATUS_PP_EXT_SWITCH(__entry->status)),
> ba45e1d5e1fd25 Guido Günther 2021-02-12  175  		      show_status_pp_switch_state(TPS_STATUS_PP_CABLE_SWITCH(__entry->status)),
> ba45e1d5e1fd25 Guido Günther 2021-02-12  176  		      show_status_power_sources(__entry->status),
> ba45e1d5e1fd25 Guido Günther 2021-02-12  177  		      show_status_vbus_status(__entry->status),
> ba45e1d5e1fd25 Guido Günther 2021-02-12  178  		      show_status_usb_host_present(__entry->status),
> ba45e1d5e1fd25 Guido Günther 2021-02-12  179  		      show_status_legacy(__entry->status),
> ba45e1d5e1fd25 Guido Günther 2021-02-12  180  		      show_status_flags(__entry->status)
> ba45e1d5e1fd25 Guido Günther 2021-02-12  181  		    )
> ba45e1d5e1fd25 Guido Günther 2021-02-12  182  );
> ba45e1d5e1fd25 Guido Günther 2021-02-12  183  
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


> _______________________________________________
> kbuild mailing list -- kbuild@lists.01.org
> To unsubscribe send an email to kbuild-leave@lists.01.org

