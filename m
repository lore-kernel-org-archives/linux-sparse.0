From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse release v0.5.1-rc1
Date: Tue, 13 Jun 2017 06:58:30 +0200
Message-ID: <20170613045829.p4ilb7xjxg35hzvm@ltop.local>
References: <CANeU7QnnwD5+XDp-C1-4oxrD8Vn-tMWhoNC8NBv0M36PO9J2fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:33787 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751915AbdFME6e (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Jun 2017 00:58:34 -0400
Received: by mail-wr0-f178.google.com with SMTP id v104so121018566wrb.0
        for <linux-sparse@vger.kernel.org>; Mon, 12 Jun 2017 21:58:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QnnwD5+XDp-C1-4oxrD8Vn-tMWhoNC8NBv0M36PO9J2fQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Jun 12, 2017 at 10:05:27AM -0700, Christopher Li wrote:
> Hi,
> 
> 
> I know that sparse has due for a new release for very long time.
> So here it is.

Great!

> I take what is in the spase-next and put them into
> a branch "sparse-0.5.1-rc1".
> 
> https://git.kernel.org/pub/scm/devel/sparse/sparse.git/log/?h=sparse-0.5.1-rc1
> 
> Thanks to Luc Van Oostenryck who contribute a great deal
> of the high quality patches. Sparse should behave much better
> when checking the recent kernel source code.
> 
> Please give the RC1 a good test. Report any problem you found.

I really think that for this it would be better to not have
this rc1 in a separate branch but instead a simple tag in
the master branch, like most projects do.
A lot of people are willing to take the last version of the
master branch but won't bother to checkout another one.
It also conveys the message that this rc1 may be unstable and
too risky for be part of the master branch. It's also not good
for distros and environments which do automatic build, daily
snapshots and such as they won't use another branch.

> Luc, do you have another other bug fix low risk patches you want to
> add in this release? I want to do a quick release then go back to merge
> your other changes.

Nothing really important but I would like to have the following
ones in the release:
- patch "avoid warning on explicit 'bool <- restricted' casts" 
  I would have liked an Acked-by from Al Viro on this one but
  he is quite busy.
- patch "add support for -Wmemcpy-max-count" & friends
  This patch will likely be used for the git tree
- patch "finer control over error vs. warnings"
  which can reveal potential problems which were hidden
- patch "teach cgcc about OSX aka darwin"
- patch "ret-void: warn for implicit type"
- series "testsuite speedup"

I'll send a pull request tomorrow.

-- Luc 
