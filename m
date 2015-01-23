From: josh@joshtriplett.org
Subject: Re: [PATCH] Teach sparse about the __COUNTER__ predefined macro
Date: Fri, 23 Jan 2015 14:38:56 -0800
Message-ID: <20150123223856.GB1489@cloud>
References: <54C15E0E.4000008@de.ibm.com>
 <CANeU7QmVQyRFHJ+YSDPkfDfXsNSLL4rJ-jA4v3UQH0tNqjEPOw@mail.gmail.com>
 <20150123222332.GB42179@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:56754 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbbAWWjA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 23 Jan 2015 17:39:00 -0500
Content-Disposition: inline
In-Reply-To: <20150123222332.GB42179@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Jan 23, 2015 at 11:23:32PM +0100, Luc Van Oostenryck wrote:
> On Fri, Jan 23, 2015 at 08:40:17AM -0800, Christopher Li wrote:
> > I think sparse haven't implement the __COUNTER__ macro. That is why it emit the
> > error on duplicate entry.
> 
> The following patch should fix that.
[...]
> Subject: [PATCH] Teach sparse about the __COUNTER__ predefined macro.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

One issue below.

> --- a/pre-process.c
> +++ b/pre-process.c
> @@ -181,6 +181,10 @@ static int expand_one_symbol(struct token **list)
>  			time(&t);
>  		strftime(buffer, 9, "%T", localtime(&t));
>  		replace_with_string(token, buffer);
> +	} else if (token->ident == &__COUNTER___ident) {
> +		static int counter;
> +
> +		replace_with_integer(token, counter++);

This should not use a static counter.  GCC and Sparse can run over more
than one file in one invocation:

$ head test1.c test2.c
==> test1.c <==
__COUNTER__
__COUNTER__

==> test2.c <==
__COUNTER__
__COUNTER__

$ gcc -E test1.c test2.c
# 1 "test1.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "test1.c"
0
1
# 1 "test2.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "test2.c"
0
1

Notice that the second file starts with __COUNTER__ at 0 again.

The counter *should* keep counting through include files, but needs to
reset before starting a new top-level compile.

- Josh Triplett
