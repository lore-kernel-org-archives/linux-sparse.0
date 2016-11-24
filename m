From: Josh Triplett <josh@kernel.org>
Subject: Re: [PATCH] lib: __builtin_object_size should accept void *
Date: Wed, 23 Nov 2016 21:19:14 -0800
Message-ID: <20161124051913.ns47h4xnridei33c@x>
References: <1479932572-12543-1-git-send-email-mst@redhat.com>
 <CANeU7Qm4Q7fawnTkGgsgQoiLJXwJLJng+4Y60+n5c_nbK-vRgQ@mail.gmail.com>
 <20161124052744-mutt-send-email-mst@kernel.org>
 <CANeU7Q=tRrCDxo25xgQC8qAQJsA27dEUiJ8sjDTXU-HAL3_h6w@mail.gmail.com>
 <20161124043536.cw2664fjdsdg7ssy@x>
 <CANeU7QkS2QTrQ40JYTXmzi19s4JyL+T15+3y9y0vQBmBTNCEKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:38061 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbcKXFTU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 24 Nov 2016 00:19:20 -0500
Content-Disposition: inline
In-Reply-To: <CANeU7QkS2QTrQ40JYTXmzi19s4JyL+T15+3y9y0vQBmBTNCEKw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Nov 24, 2016 at 01:03:32PM +0800, Christopher Li wrote:
> On Thu, Nov 24, 2016 at 12:35 PM, Josh Triplett <josh@kernel.org> wrote:
> > Probably doesn't need a separate integration repository; if you want to
> > stage changes that you don't know you want to ship yet, a "next" branch
> > in the main repository would be easier for people to find and use.  If
> > you just want to give changes time to stabilize, you can probably put
> > them on "master" and just not release them yet.
> 
> I want a branch I can publish for others to review and test.
> At the same time I want to be able to go back and modify the history
> of the patch, merge and squash fix for the already applied patch.
> 
> That "next" branch will not be pull stable, is it acceptable?
> I saw linux-next has a separate repository and the master branch
> is not pull stable. At the same time there are tag like next-20161121
> to reference old branch.

Rebasing a "next" branch, as long as you clearly document that, seems
fine.

> I assume I can do the similar thing. The question is that does it
> need to be a separate repository?

I don't think so, no.

> As long as people don't expect pull stable from that "next" branch,
> I am fine with putting it under the sparse main repository.
> 
> I guess there is other implications on the git repository size. If the
> repository get rewind and modify very often, it might cause the git
> pack file contain a lot of useless head not part of the stable master
> branch. I don't think sparse next branch will rewind that often, but
> that is some thing to consider as a separate repository.

git will automatically discard any unreferenced objects when repacking.
But even if you archive the old versions of "next" using branches or
tags, it still won't take up that much space, compared to linux.git for
instance.
