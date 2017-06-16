From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [GIT PULL] patches for -rc2
Date: Fri, 16 Jun 2017 05:35:56 +0200
Message-ID: <20170616033517.v5lsvxyn3iqntqa6@ltop.local>
References: <20170615043455.3ke55dyo6v4vpebo@ltop.local>
 <CANeU7QmtKh5LxJVvaFVGy7KApXTtzW+-G19LogbEZH=kTNLHAQ@mail.gmail.com>
 <20170615082050.4ztydiu3d6m4fx2e@ltop.local>
 <57e076f3-77c6-34c6-b8b5-8301efcc3f7f@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38390 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750792AbdFPDgD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 15 Jun 2017 23:36:03 -0400
Received: by mail-wm0-f49.google.com with SMTP id u195so1470407wmd.1
        for <linux-sparse@vger.kernel.org>; Thu, 15 Jun 2017 20:36:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <57e076f3-77c6-34c6-b8b5-8301efcc3f7f@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Jun 16, 2017 at 01:03:00AM +0100, Ramsay Jones wrote:
> I decided to fetch this tonight and do a bit of light testing.

Thanks for that.

...
> I then ran sparse over the entire git project, as I usually do, to see if
> there were any new errors/warnings. Unfortunately, there were, which can
> be seen as follows:
>  
>   $ make builtin/rev-parse.sp
>       SP builtin/rev-parse.c
>   ./git-compat-util.h:480:22: warning: crazy programmer
>   ./git-compat-util.h:480:22: warning: crazy programmer
>   ./git-compat-util.h:480:22: warning: crazy programmer
>   $ 
> 
> I used git-bisect the find the commit responsible for the new warnings,
> the end of that session was as follows:
> 
>   $ git bisect good
>   5636cd5cbf816f30ee57d580ec4debd8e0bd7581 is the first bad commit

I'm not much surprised that you see a problem with this patch
but I would have hoped that these "crazy programmer" warnings
would have gone away after a later commit, like it did for the kernel:
	(51cfbc90a "fix: kill unreachable BBs after killing a child")
It visibly doesn't.

> I tried to create a minimal reproducer, but I just couldn't reduce it at all!
> 
> The warning points to the 'while' line of the skip_prefix() function in the
> git-compat-util.h header file. This is used all over the place, but it seems
> to be only complaining about its use in builtin/rev-parse.c. In particular,
> there are 16 inlined calls in the function cmd_rev_parse() alone. So I don't
> know which 3 of those inlined calls it is complaining about (the warning
> message is not much help ...).

Yes, the error message doesn't help much. It is emitted when a cycle is found
between loads, something a correct program should never have but can happen
when there is some unitilized variables that are optimized away. Here, it's
obviously a bug is sparse, though.

> That is as far as I have gone in trying to chase this down. I have to get
> some sleep now, so I thought I should let you know what I found so far. :-D

Thank you very much, it already help a lot. I'm looking at it now.

-- Luc
