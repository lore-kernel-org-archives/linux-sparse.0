From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/2] Use any previous initializer to size a symbol
Date: Sun, 30 Mar 2014 22:23:39 -0700
Message-ID: <CANeU7QmxYAcCOPvWMPwazmvREbFv7_CmG48NKnb=ZpuLdjd9+Q@mail.gmail.com>
References: <alpine.LFD.2.11.1403301020530.16374@i7.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:37858 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655AbaCaFXk (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 31 Mar 2014 01:23:40 -0400
Received: by mail-qa0-f54.google.com with SMTP id w8so7701442qac.27
        for <linux-sparse@vger.kernel.org>; Sun, 30 Mar 2014 22:23:39 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.11.1403301020530.16374@i7.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Mar 30, 2014 at 10:22 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Sun, 30 Mar 2014 10:13:54 -0700
> Subject: [PATCH 2/2] Use any previous initializer to size a symbol
>
> When we size a symbol, we only have one initializer per symbol, but we
> may have multiple symbol declarations for the same symbol.  So make sure
> to walk the "same_symbol" chain to find the initializer, rather than
> assuming it is attached to the current declaration.
>
> Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

This patch looks good to me. Will apply.


> ---
>
> This seems to be the simplest approach. Chris, what was your concern about
> scoping? The "same_symbol" list should already take scoping into account.


This bug is a special case of the more general sparse bug in merging
declaration types.

The scoping I am concern about is some thing like this:
(BTW, your patch does not have the scoping issue).

extern void foo(void) __attribute__((X));
for (;;) {
    extern void foo(void) __attribute__((Y));
    /* function foo()  should have both attribute X and Y here */

}

/* foo() should have only attribute X here */

Merging the initializer is a special case of this more general
bug. Obviously, this patch fix the merging of initialization,  should
be applied.

Chris
