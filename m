From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 00/37] Makefile reorganization
Date: Thu, 9 Nov 2017 21:54:24 +0100
Message-ID: <20171109205423.xnztemrxvapob7rs@ltop.local>
References: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
 <CANeU7QkBakvfoWn1RdZz-D3evS3=UEdjgqE8mfuddxFup_hf+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:56181 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbdKIUy1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 15:54:27 -0500
Received: by mail-wm0-f44.google.com with SMTP id b189so5482626wmd.4
        for <linux-sparse@vger.kernel.org>; Thu, 09 Nov 2017 12:54:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7QkBakvfoWn1RdZz-D3evS3=UEdjgqE8mfuddxFup_hf+w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>, Josh Triplett <josh@joshtriplett.org>, Jeff Layton <jlayton@redhat.com>

On Fri, Nov 10, 2017 at 03:11:10AM +0800, Christopher Li wrote:
> On Thu, Nov 9, 2017 at 2:46 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > The goal of this series is to reorganize sparse's Makefile
> > in order to offer a few features asked by the distros:
> > 1) allow CFLAGS & CPPFLAGS to be taken from the command line
> 
> That can be done in one patch.
> 
> > 2) allow PREFIX to be taken from the environment
> 
> Not straightly necessary. You can invoke "make PREFIX=$PREFIX".
> 
> I will have to hold of the review of this series as well
> as I feel most of the review is not straightly necessary.
> 
> Some of the stuff get removed, I am actually still using.

Good.

> Another thing is that, there is an earlier debug version of sparse
> makefile change under discussion. I have express that I want to
> hold off big Makefile changes until the debug version series
> reach to some conclusion.

I know, and it's why I said earlier that these patches were for my
development tree, I never thought you could be interested in them.
 
Regards,
-- Luc
