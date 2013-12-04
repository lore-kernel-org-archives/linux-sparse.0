From: Tejun Heo <tj@kernel.org>
Subject: Re: [BUG report]sparse warnings on DEFINE_PER_CPU() symbols
 non-static
Date: Wed, 4 Dec 2013 10:10:51 -0500
Message-ID: <20131204151051.GN3158@htj.dyndns.org>
References: <5294175F.2080407@cn.fujitsu.com>
 <20131203222543.GQ8277@htj.dyndns.org>
 <20131203234320.GA15141@jtriplet-mobl1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yh0-f42.google.com ([209.85.213.42]:44125 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753488Ab3LDPKz (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 4 Dec 2013 10:10:55 -0500
Received: by mail-yh0-f42.google.com with SMTP id z6so11537230yhz.15
        for <linux-sparse@vger.kernel.org>; Wed, 04 Dec 2013 07:10:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131203234320.GA15141@jtriplet-mobl1>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Wanlong Gao <gaowanlong@cn.fujitsu.com>, linux-sparse@vger.kernel.org, Wu Fengguang <fengguang.wu@intel.com>, kbuild-all@01.org, Rusty Russell <rusty@rustcorp.com.au>, Christoph Lameter <cl@linux-foundation.org>

On Tue, Dec 03, 2013 at 03:43:20PM -0800, Josh Triplett wrote:
> > Does the following patch make it go away?
> 
> It should, but is there some reason why you couldn't make the definition
> on the line immediately below that static?

Weak symbols can't be static.  That's the point of the whole thing.

Thanks.

-- 
tejun
