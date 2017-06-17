From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/2] fix bogus "crazy progammer"
Date: Sat, 17 Jun 2017 05:44:50 +0200
Message-ID: <20170617034449.6clvouwqxpfiujrb@ltop.local>
References: <20170616191844.86256-1-luc.vanoostenryck@gmail.com>
 <8132b29c-0bfc-9294-8040-a2f7271affd6@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33359 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752379AbdFQDoy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 16 Jun 2017 23:44:54 -0400
Received: by mail-wm0-f65.google.com with SMTP id f90so7884616wmh.0
        for <linux-sparse@vger.kernel.org>; Fri, 16 Jun 2017 20:44:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8132b29c-0bfc-9294-8040-a2f7271affd6@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: linux-sparse@vger.kernel.org, Chris Li <sparse@chrisli.org>

On Fri, Jun 16, 2017 at 09:10:57PM +0100, Ramsay Jones wrote:
> 
> 
> On 16/06/17 20:18, Luc Van Oostenryck wrote:
> > The goal of this series is to fix the bogus "crazy progammer"
> > warnings issued by sparse when running on the git tree.
> > 
> > This "crazy programmer" warning is issued when there is
> > a circulary dependency between pseudos but in the present
> > case this circulary dependence was only an consequence of
> > optimizations applied on a wrong state.
> 
> Thank you for posting this (I had just started looking at this
> again tonight). I have just fetched it and done a very quick test
> and this works for me! Thanks!
> 
> [You probably noticed that I counted "grep 'inline.*skip_prefix' |
> wc -l", thereby counting the number of inlined calls twice! once for
> 'begin_inline' and once for 'end_inline'! Ahem ;-)]

Hehe, I confess that once I saw 'crazy programmer', I directly went
to try to reproduce it (which was simple given you bug report)
because I had already struggled on it some time ago. And then I
tried to reduce it (which took me some time!) before trying to
understand what was happening.

> > With this bug fixed, there is only a single sparse warnings 
> > left in the git tree (and it's most probably a bogus one).
> 
> Hmm, which one is that? (I'm not counting the 'memset byte count'
> warning!) The only other warnings I am aware of are on the 'pu'
> branch (expected), or if you build with the NO_REGEX build variable
> set. (which I don't on Linux, but I do on cygwin).

I think I had left with the default options and it was the master
branch. And, indeed I don't count the 'memset byte count' anymore.
I meant the same as you here:

> This is another long-standing error that I have been meaning to
> fix at some point (but it has been on my TODO list for many a
> year, so ...). It looks like so:
> 
>     SP compat/regex/regex.c
> compat/regex/regex_internal.c:926:1: error: symbol 're_string_context_at' redeclared with different type (originally declared at compat/regex/regex_internal.h:434) - different modifiers
> 
> (ie the 'pure' attribute is in a different place in the declaration
> and definition of the function).

Ah yes, indeed. The syntax for attributes is a bit ... well ...
and dependening on the place the attribute will be 'attached'
either to the function itself or to the return type (or something
close to this).

> I will do some more testing later (cygwin, 32bit linux etc.) and let
> you know if I find anything else.

Yes, please. It's very much appreciated.

-- Luc Van Oostenryck
