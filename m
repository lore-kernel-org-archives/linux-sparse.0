From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [PATCH v3] dmaengine: xgene-dma: Fix sparse wannings and
 coccinelle warnings
Date: Fri, 12 Jun 2015 09:00:26 +0800
Message-ID: <20150612010026.GA14406@wfg-t540p.sh.intel.com>
References: <1429212673-22254-1-git-send-email-rsahu@apm.com>
 <20150417182937.GN30624@intel.com>
 <CAFd313y-HfW_us0FVQFEkGAzf-ZCKpRtF6eYweaK0V94MBg4iQ@mail.gmail.com>
 <20150427031315.GG2738@intel.com>
 <20150427052045.GA5199@wfg-t540p.sh.intel.com>
 <CANeU7Q=0VT5EOjKXEFJ4WgKQGcZhufEgksLoN4PDLEbc+q0pgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:4515 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818AbbFLBBv (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 11 Jun 2015 21:01:51 -0400
Content-Disposition: inline
In-Reply-To: <CANeU7Q=0VT5EOjKXEFJ4WgKQGcZhufEgksLoN4PDLEbc+q0pgQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Vinod Koul <vinod.koul@intel.com>, Rameshwar Sahu <rsahu@apm.com>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jcm@redhat.com, patches@apm.com, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Jun 11, 2015 at 05:36:00PM -0700, Christopher Li wrote:
> n Sun, Apr 26, 2015 at 10:20 PM, Fengguang Wu <fengguang.wu@intel.com> wrote:
> >> >
> >> > drivers/dma/xgene-dma.c:2088:1: sparse: symbol
> >> > '__UNIQUE_ID_author__COUNTER__' has multiple initializers (originally
> >> > initialized at drivers/dma/xgene-dma.c:2087)
> >> > So, I kept only one author here.
> >> No that is not right, sparse shouldn't have cribbed here.
> >>
> >> Fengguang can we get the bot to ignore this please
> 
> Sorry for the late reply.
> 
> That looks like the __COUNTER__ macro feature. It has been implemented in
> sparse git tree already.

That's great, I'll fetch the latest sparse code from

git://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git

Thanks,
Fengguang
