From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] quiet memset() warning with sizeof(VLA)
Date: Sat, 17 Feb 2018 20:57:20 +0100
Message-ID: <20180217195718.kawdviwqnhpzdopn@ltop.local>
References: <20180217165839.61981-1-luc.vanoostenryck@gmail.com>
 <20180217191826.GA22695@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:39131 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751590AbeBQT50 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 17 Feb 2018 14:57:26 -0500
Received: by mail-wr0-f180.google.com with SMTP id w77so5952727wrc.6
        for <linux-sparse@vger.kernel.org>; Sat, 17 Feb 2018 11:57:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180217191826.GA22695@localhost>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: linux-sparse@vger.kernel.org

On Sat, Feb 17, 2018 at 11:18:26AM -0800, Josh Triplett wrote:
> On Sat, Feb 17, 2018 at 05:58:39PM +0100, Luc Van Oostenryck wrote:
> > Currently, sparse doesn't handle yet VLA's sizeof(). The size
> > of a VLA is considered as zero and the result of sizeof() on
> > a VLA is treated as an error with a value of -1.
> > 
> > That's a problem with the check done by the sparse tool, which
> > warn when operations like memset() are done with a static count
> > which is above some limit. Of course, all this is done with
> > unsigned numbers and the -1 from sizeof(VLA) is then considered
> > as off-limit.
> > 
> > Sure, size of VLAs should be supported but it's longer term.
> > One short term solution would be to do the check with signed
> > numbers but that would eat the upper bit of the limit which
> > may well be the bound that we would like to check.
> > 
> > So, check instead for sizes of -1, which must come from some
> > previous errors that must have already been reported, and do
> > not issue the memset() warning in this case.
> 
> I'm concerned about generically ignoring this warning for *all* -1
> sizes, because -1 seems like a very common value to slip through for
> other reasons.  Losing those very real warnings just to avoid getting a
> second warning on a VLA doesn't seem worth it.

Yes, I think you're right.
 
> (Also, at the very *least* this would need a comment explaining *why* it
> ignores -1.)
> 
> Could you somehow propagate a taintedness on that value that causes the
> memset to ignore it? Or just change the dummy error value to 0?

Yes, that could be a solution (but changing it to zero seems to me as
bad). I'll look for something but I think I'll just better spend a bit
time on having real support for VLA's size.

Thanks for the review
-- Luc
