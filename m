From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] lib: __builtin_object_size should accept void *
Date: Thu, 24 Nov 2016 13:03:32 +0800
Message-ID: <CANeU7QkS2QTrQ40JYTXmzi19s4JyL+T15+3y9y0vQBmBTNCEKw@mail.gmail.com>
References: <1479932572-12543-1-git-send-email-mst@redhat.com>
 <CANeU7Qm4Q7fawnTkGgsgQoiLJXwJLJng+4Y60+n5c_nbK-vRgQ@mail.gmail.com>
 <20161124052744-mutt-send-email-mst@kernel.org> <CANeU7Q=tRrCDxo25xgQC8qAQJsA27dEUiJ8sjDTXU-HAL3_h6w@mail.gmail.com>
 <20161124043536.cw2664fjdsdg7ssy@x>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:32993 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbcKXFDe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 24 Nov 2016 00:03:34 -0500
Received: by mail-io0-f196.google.com with SMTP id j92so3941835ioi.0
        for <linux-sparse@vger.kernel.org>; Wed, 23 Nov 2016 21:03:34 -0800 (PST)
In-Reply-To: <20161124043536.cw2664fjdsdg7ssy@x>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Nov 24, 2016 at 12:35 PM, Josh Triplett <josh@kernel.org> wrote:
> Probably doesn't need a separate integration repository; if you want to
> stage changes that you don't know you want to ship yet, a "next" branch
> in the main repository would be easier for people to find and use.  If
> you just want to give changes time to stabilize, you can probably put
> them on "master" and just not release them yet.

I want a branch I can publish for others to review and test.
At the same time I want to be able to go back and modify the history
of the patch, merge and squash fix for the already applied patch.

That "next" branch will not be pull stable, is it acceptable?
I saw linux-next has a separate repository and the master branch
is not pull stable. At the same time there are tag like next-20161121
to reference old branch.

I assume I can do the similar thing. The question is that does it
need to be a separate repository?

As long as people don't expect pull stable from that "next" branch,
I am fine with putting it under the sparse main repository.

I guess there is other implications on the git repository size. If the
repository get rewind and modify very often, it might cause the git
pack file contain a lot of useless head not part of the stable master
branch. I don't think sparse next branch will rewind that often, but
that is some thing to consider as a separate repository.

Chris
