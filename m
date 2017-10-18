From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] build: assign extra flags to ALL_CFLAGS instead of CFLAGS
Date: Wed, 18 Oct 2017 12:36:41 -0700
Message-ID: <CANeU7QmPgxKqjZpvudX_MYwhwGWx6nnZrats3brDMVvUUvBTFg@mail.gmail.com>
References: <20171018150727.26821-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:56915 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbdJRTgp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 18 Oct 2017 15:36:45 -0400
Received: by mail-yw0-f170.google.com with SMTP id l32so1546599ywh.13
        for <linux-sparse@vger.kernel.org>; Wed, 18 Oct 2017 12:36:45 -0700 (PDT)
In-Reply-To: <20171018150727.26821-1-jlayton@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Oct 18, 2017 at 8:07 AM, Jeff Layton <jlayton@kernel.org> wrote:
> From: Jeff Layton <jlayton@redhat.com>
>
> The fedora packaging tools want to override $CFLAGS when building
> sparse, but that fails on a couple of targets.
>
> There are a couple of build targets in the makefile that want to add
> options to $CFLAGS. When we do a build though, we pass $ALL_CFLAGS
> to the compiler, and that ends up not getting options passed in
> via $CFLAGS on the command line.

Can you give example of what CFLAGS it passed in the command line?
Does it append some flags only?

It seems wrong to overwrite CFLAGS from command line. That are
other flags store in the CFLAGS will get overwritten.

We have add some variable in the ALL_CFLAGS list for overwrite
purpose  e.g. CFLAGS_CMD then have command line over write that?

Chris
