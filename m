From: Christopher Li <sparse@chrisli.org>
Subject: Re: Bad interaction between macro expansion and literal concatenation
Date: Fri, 30 Jan 2015 21:16:57 -0800
Message-ID: <CANeU7QnQWRRB1kmt7KOjuJ4PFasefaX91yPZ-DEYxE2qUzxX3A@mail.gmail.com>
References: <87y4ojhq2f.fsf@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:56716 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbbAaFQ6 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 31 Jan 2015 00:16:58 -0500
Received: by mail-qc0-f169.google.com with SMTP id b13so23727246qcw.0
        for <linux-sparse@vger.kernel.org>; Fri, 30 Jan 2015 21:16:57 -0800 (PST)
In-Reply-To: <87y4ojhq2f.fsf@rasmusvillemoes.dk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Jan 30, 2015 at 2:16 PM, Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
>   KERN_DEBUG "%s: Reset: current Rx mode %d.\n"
>
> KERN_DEBUG ultimately expands to "\001" "7". When I print the
> corresponding ->string->data, I get
>
>   ^A6%s7%s: Reset: current Rx mode %d.

Can you construct a small C program to demonstrate the problem
without including any real kernel headers?

e.g. some thing like:

#define KERNEL_DEBUG "\001" "7"

void foo(void)
{
     printk(KERN_DEBUG "%s: .....", ...);
}

Obviously, my test case is not a complete one. It is not
even valid C. It just show you some idea how a test case
can be constructed.

Once you have a small test case, it is much easier
to discuss and debug what is going on there.

BTW, how do you print the "string->data"? It helps to show the
functions that does the print.

Chris
