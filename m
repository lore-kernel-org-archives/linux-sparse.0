From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v3 00/37] Makefile reorganization
Date: Fri, 10 Nov 2017 03:11:10 +0800
Message-ID: <CANeU7QkBakvfoWn1RdZz-D3evS3=UEdjgqE8mfuddxFup_hf+w@mail.gmail.com>
References: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:48180 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752622AbdKITLL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 14:11:11 -0500
Received: by mail-qt0-f177.google.com with SMTP id f8so9025151qta.5
        for <linux-sparse@vger.kernel.org>; Thu, 09 Nov 2017 11:11:11 -0800 (PST)
In-Reply-To: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>, Josh Triplett <josh@joshtriplett.org>, Jeff Layton <jlayton@redhat.com>

On Thu, Nov 9, 2017 at 2:46 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The goal of this series is to reorganize sparse's Makefile
> in order to offer a few features asked by the distros:
> 1) allow CFLAGS & CPPFLAGS to be taken from the command line

That can be done in one patch.

> 2) allow PREFIX to be taken from the environment

Not straightly necessary. You can invoke "make PREFIX=$PREFIX".

I will have to hold of the review of this series as well
as I feel most of the review is not straightly necessary.

Some of the stuff get removed, I am actually still using.

Another thing is that, there is an earlier debug version of sparse
makefile change under discussion. I have express that I want to
hold off big Makefile changes until the debug version series
reach to some conclusion.

In general I don't like big rewrite and rename for the
sake of rewrite.

Chris
