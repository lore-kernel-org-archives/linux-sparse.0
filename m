From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/4] assorted cleanups
Date: Thu, 16 Feb 2017 03:56:21 +0100
Message-ID: <20170216025620.cl5je57nn76hmfp6@macpro.local>
References: <20170215221358.68400-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qnnjzn6+8UTa2hnEYPujnrO-cER-hu-wyrrpk7ODSEOQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:34045 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751421AbdBPC41 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 15 Feb 2017 21:56:27 -0500
Received: by mail-wr0-f175.google.com with SMTP id z61so2739321wrc.1
        for <linux-sparse@vger.kernel.org>; Wed, 15 Feb 2017 18:56:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Qnnjzn6+8UTa2hnEYPujnrO-cER-hu-wyrrpk7ODSEOQQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Feb 16, 2017 at 10:29:47AM +0800, Christopher Li wrote:
> On Thu, Feb 16, 2017 at 6:13 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > This serie is only a small collections of independent
> > cleanups, mainly removal of unused struct members.
> >
> > Patches 1-4 have no functional changes.
> > Patch 4 make show_statement() slightly more useful.
> 
> Thanks,
> 
> Applied and pushed to sparse-next.
Thanks.
 
> Do you have more patches coming? If not I am going to cut
> a sparse release RC soon.
I have lots of patches in diverse state of completeness but only
a dozen or so really ready.

In fact I was going to send some of them while I saw your email.
And I'll probably send a few others in the coming days.

Would it be possible to have the previous sparse-next promoted
to the master branch? I could then merge my features branches
with an up-to-date official branch that I'm sure is stable before
making some testing.

Luc
