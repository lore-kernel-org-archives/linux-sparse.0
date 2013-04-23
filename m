From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [next:akpm 798/1000] drivers/rtc/rtc-ds1286.c:343:24: sparse:
 incorrect type in argument 1 (different address spaces)
Date: Tue, 23 Apr 2013 10:51:43 +0800
Message-ID: <20130423025143.GC7154@localhost>
References: <5171d93a.0NZAGYYKNj8hjsAs%fengguang.wu@intel.com>
 <20130422165629.bae79e6c5251bf148a3bae73@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22797 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754040Ab3DWCvq (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Apr 2013 22:51:46 -0400
Content-Disposition: inline
In-Reply-To: <20130422165629.bae79e6c5251bf148a3bae73@linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jingoo Han <jg1.han@samsung.com>, kbuild-all@01.org, linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Apr 22, 2013 at 04:56:29PM -0700, Andrew Morton wrote:
> On Sat, 20 Apr 2013 07:54:34 +0800 kbuild test robot <fengguang.wu@intel.com> wrote:
> 
> > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git akpm
> > head:   c9941b7ec7840ad33f5822c7f238157558d40132
> > commit: d5e42b5769899607e1e4b0c9200340d24f370e8c [798/1000] rtc: rtc-ds1286: use devm_*() functions
> > 
> > 
> > sparse warnings: (new ones prefixed by >>)
> > 
> > >> drivers/rtc/rtc-ds1286.c:343:24: sparse: incorrect type in argument 1 (different address spaces)
> >    drivers/rtc/rtc-ds1286.c:343:24:    expected void const *ptr
> >    drivers/rtc/rtc-ds1286.c:343:24:    got unsigned int [noderef] [usertype] <asn:2>*rtcregs
> > >> drivers/rtc/rtc-ds1286.c:344:36: sparse: incorrect type in argument 1 (different address spaces)
> >    drivers/rtc/rtc-ds1286.c:344:36:    expected void const *ptr
> >    drivers/rtc/rtc-ds1286.c:344:36:    got unsigned int [noderef] [usertype] <asn:2>*rtcregs
> > 
> > vim +343 drivers/rtc/rtc-ds1286.c
> > 
> >    337			return -ENODEV;
> >    338		priv = devm_kzalloc(&pdev->dev, sizeof(struct ds1286_priv), GFP_KERNEL);
> >    339		if (!priv)
> >    340			return -ENOMEM;
> >    341	
> >    342		priv->rtcregs = devm_ioremap_resource(&pdev->dev, res);
> >  > 343		if (IS_ERR(priv->rtcregs))
> >  > 344			return PTR_ERR(priv->rtcregs);
> >    345	
> >    346		spin_lock_init(&priv->lock);
> >    347		platform_set_drvdata(pdev, priv);
> 
> I think doing IS_ERR() and PTR_ERR() on __iomem pointers is a natural
> thing, and we should be able to do this without adding call-site
> trickery to make sparse happy.
> 
> Is there some sort of annotation which we can add to the
> IS_ERR()/PTR_ERR() definitions so that sparse will stop warning about
> this usage?

If it's too hard to fix in sparse, I can add a check in my scripts,
ignoring all "parse: incorrect type in argument 1 (different address
spaces)" warnings in the IS_ERR/PTR_ERR lines.

Thanks,
Fengguang
