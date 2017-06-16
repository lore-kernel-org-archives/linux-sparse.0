From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 0/2] fix bogus "crazy progammer"
Date: Fri, 16 Jun 2017 21:10:57 +0100
Message-ID: <8132b29c-0bfc-9294-8040-a2f7271affd6@ramsayjones.plus.com>
References: <20170616191844.86256-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout07.plus.net ([84.93.230.235]:57817 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750844AbdFPULB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 16 Jun 2017 16:11:01 -0400
In-Reply-To: <20170616191844.86256-1-luc.vanoostenryck@gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org
Cc: Chris Li <sparse@chrisli.org>



On 16/06/17 20:18, Luc Van Oostenryck wrote:
> The goal of this series is to fix the bogus "crazy progammer"
> warnings issued by sparse when running on the git tree.
> 
> This "crazy programmer" warning is issued when there is
> a circulary dependency between pseudos but in the present
> case this circulary dependence was only an consequence of
> optimizations applied on a wrong state.

Thank you for posting this (I had just started looking at this
again tonight). I have just fetched it and done a very quick test
and this works for me! Thanks!

[You probably noticed that I counted "grep 'inline.*skip_prefix' |
wc -l", thereby counting the number of inlined calls twice! once for
'begin_inline' and once for 'end_inline'! Ahem ;-)]

> With this bug fixed, there is only a single sparse warnings 
> left in the git tree (and it's most probably a bogus one).

Hmm, which one is that? (I'm not counting the 'memset byte count'
warning!) The only other warnings I am aware of are on the 'pu'
branch (expected), or if you build with the NO_REGEX build variable
set. (which I don't on Linux, but I do on cygwin).

This is another long-standing error that I have been meaning to
fix at some point (but it has been on my TODO list for many a
year, so ...). It looks like so:

    SP compat/regex/regex.c
compat/regex/regex_internal.c:926:1: error: symbol 're_string_context_at' redeclared with different type (originally declared at compat/regex/regex_internal.h:434) - different modifiers

(ie the 'pure' attribute is in a different place in the declaration
and definition of the function).

I will do some more testing later (cygwin, 32bit linux etc.) and let
you know if I find anything else.

Thanks again.

ATB,
Ramsay Jones

