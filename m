From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse release v0.5.1-rc1
Date: Wed, 14 Jun 2017 04:29:36 +0200
Message-ID: <20170614022934.hwr76bduxnwrnolg@ltop.local>
References: <CANeU7QnnwD5+XDp-C1-4oxrD8Vn-tMWhoNC8NBv0M36PO9J2fQ@mail.gmail.com>
 <20170613045829.p4ilb7xjxg35hzvm@ltop.local>
 <5396b5dd-8a26-238c-19b3-12132a9a556b@ramsayjones.plus.com>
 <20170613160511.fkjvpulf7mhzqi7z@ltop.local>
 <2a728714-43f7-3db5-e12a-0fe8440517c7@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:34674 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754089AbdFNC3j (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Jun 2017 22:29:39 -0400
Received: by mail-wr0-f169.google.com with SMTP id 77so21002063wrb.1
        for <linux-sparse@vger.kernel.org>; Tue, 13 Jun 2017 19:29:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2a728714-43f7-3db5-e12a-0fe8440517c7@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Jun 14, 2017 at 01:00:02AM +0100, Ramsay Jones wrote:
> 
> 
> On 13/06/17 17:05, Luc Van Oostenryck wrote:
> > On Tue, Jun 13, 2017 at 04:08:23PM +0100, Ramsay Jones wrote:
> >> Luc, I have not actually tested these patches (I was waiting for
> >> something I could git-fetch). I have no doubt they are good, but
> > 
> > This -rc1 is in fact the parent of the mem-max-count mini-series,
> > so you tested it already a bit :)
> 
> Err, ... I don't see those patches as part of the sparse-0.5.1-rc1
> branch (or v0.5.1-rc1/master, ...).

No, they will be part of the -rc2. I just meant that they were
built on top of what is now the -rc1.
 
> >> it just occurred to me that a patch may be missing. I don't recall
> >> seeing a change to cgcc to filter-out the new, sparse only, options.
> >> ie. they need to be added to the check_only_option subroutine (#102).
> > 
> > Indeed, it's really great that you thought about it
> > because since I don't use cgcc myself, I would never
> > have thought about updated it.
> 
> I use it all the time (it's really the main front-end to sparse!)
> with '-no-compile'. In this case, since it doesn't call gcc, the
> lack of this 'options filter' does not matter. However, I'm aware
> that many people use cgcc as a proxy for gcc (which is the _intent_,
> after all), so this needs to be fixed. (So that 'make CC=cgcc ...'
> continues to works).

For people that use it as gcc's proxy, they normally wouldn't
feed it with sparse-only options, so it should also be OK.

Otherwise, I'm a bit curious to know the advantage to using cgcc
as a front-end for sparse. I'm aware of the need to have things
like __LONG_MAX__ be defined or __unix, __linux but I'm wondering
what else is needed.

> > I'll add what is needed and check if anything else is
> > missing there.
> 
> Yeah, it is not just _these_ new options; I think there have been
> several 'sparse only' options added 'recently' which have not been
> filtered out in cgcc. (again only 'sparse only' options need to be
> added to the regex in the check_only_option subroutine).

The last months, I added support for a few new flags but most
are flags also know by GCC (-fmem-report, -Woverride-init,
-Waddress, -dD, -std={c11,gnu11}). The only ones that need
to be filtered-out should be:
* -Wmemcpy-max-count and -fmemcpy-max-count=COUNT
* -fdump-linearize[=...]
but Ill double-check.

-- Luc
