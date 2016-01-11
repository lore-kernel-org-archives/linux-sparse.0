From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] sparse: add support for static assert
Date: Mon, 11 Jan 2016 18:37:40 +0100
Message-ID: <20160111173739.GA2972@macpro.local>
References: <1452105317-5828-1-git-send-email-lrichard@redhat.com>
 <20160109135440.GA6833@macpro.local>
 <1249921583.11998072.1452480864238.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34829 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761224AbcAKRho (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 11 Jan 2016 12:37:44 -0500
Received: by mail-wm0-f42.google.com with SMTP id f206so221309225wmf.0
        for <linux-sparse@vger.kernel.org>; Mon, 11 Jan 2016 09:37:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1249921583.11998072.1452480864238.JavaMail.zimbra@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Lance Richardson <lrichard@redhat.com>
Cc: linux-sparse@vger.kernel.org

On Sun, Jan 10, 2016 at 09:54:24PM -0500, Lance Richardson wrote:
> ----- Original Message -----
> > On Wed, Jan 06, 2016 at 01:35:17PM -0500, Lance Richardson wrote:
> > > This patch introduces support for _Static_assert() in global,
> > > function, and struct/union declaration contexts (as currently supported
> > > by gcc).
> > > 
> > > Tested via:
> > >    - kernel build with C=1 CF=-D__CHECK_ENDIAN__
> > >    - build/check large code base making heavy use of _Static_assert()
> > >    - "make check" with added test case for static assert support
> > 
> > Nice, it was something that was indeed missing.
> > 
> > I have a few remarks, mostly nitpicking, here under.
> 
> Hi Luc, thanks for taking the time to review this.

Glad to help!
 
...

> > 
> > I find also a bit strange to have this sort of semantic check inside the
> > parser.
> 
> This prompted me to look at the gcc implementation, it appears that gcc also
> processes _Static_assert() during parsing.

It can always be moved elsewhere if needed.
 

> > Also, what should happen with:
> > 	_Static_assert(1 / 0, "invalid expression: should not show up?");
> > (The C11 standard is not clear to me, GCC outputs an "invalid expression"
> > message and ignore the assertion).
> 
> v2 will output something like "invalid constant integer expression".

Please don't.
That's the job of constant_expression() to emit a good error message.
Here, the best thing to do is to *not* emit an error message if the
expression is not a valid expression, constant (for example,
by forcing val to 1 when expr is null).

> > 
> > Finally, the standard also allow to place the assertion
> > inside a struct or union declaration; like:
> > 	struct s {
> > 		char c;
> > 		_Static_assert(1, "inside struct");
> > 	};
> > which is working fine.
> > And also, I think:
> > 	struct s2 {
> > 		char c;
> > 		_Static_assert(sizeof(struct s) == 1, "own struct sizeof");
> > 	};
> > which doesn't.
> 
> The second case should work (unless you intended "sizeof(struct s2)"), the v2
> implementation will be a little different to address this issue.

Yep, I messed it up.
I indeed meant "sizeof(struct s2)" and it seems to work fine
but for the wrong reason. See what I mean with the following example:
	struct s3 {
	        char c;
	        _Static_assert(sizeof(struct s3) == 1, "own struct sizeof, partial 1");
	        _Static_assert(sizeof(struct s3) == 2, "own struct sizeof, partial 2");
	        char d;
	};
but this problem is unrelated to your patch.

Yours,
Luc
