From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: __attribute__((force)) should not be a storage class
Date: Sun, 2 Feb 2014 00:38:38 -0800
Message-ID: <20140202083838.GA20284@leaf>
References: <20140201184935.GA12321@leaf>
 <CANeU7Qm1=8ks=Fu6LzjuAYxRqLPS3gssmD+uxNzDfN568Xxodw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:33368 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253AbaBBIir (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 2 Feb 2014 03:38:47 -0500
Content-Disposition: inline
In-Reply-To: <CANeU7Qm1=8ks=Fu6LzjuAYxRqLPS3gssmD+uxNzDfN568Xxodw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Al Viro <viro@ftp.linux.org.uk>

On Sat, Feb 01, 2014 at 09:51:11PM -0800, Christopher Li wrote:
> On Sat, Feb 1, 2014 at 10:49 AM, Josh Triplett <josh@joshtriplett.org> wrote:
> > Commit 3829c4d8b097776e6b3472290a9fae08a705ab7a ("Don't mix storage
> > class bits with ctype->modifiers while parsing type") in 2009 separated
> > storage classes from modifiers; in the process, it changed
> > __attribute__((force)) from a modifier to a storage class.  I don't
> > think it makes sense to have force as a storage class, for one critical
> > reason: storage classes are mutually exclusive.
> 
> I am not convinced yet.
> 
> The current usage case for attribute "force" is to silence the type
> mismatch during the type conversion. For variable declaration, there is
> not need to silence any mismatch because there is no type conversion.
> 
> What you are purposing here is a new usage case. Do you want
> to silence every single type mismatch in every assignment to that
> variable? How about assignment from that variable?

I'd suggest that either it should have exactly the same behavior as it does
when applied to the type of a function argument (suppressing
Sparse-specific pointer qualifier mismatches on input), or it should be
prohibited entirely on standalone variable declarations.  I'd be fine
with the latter, if you prefer.

> > $ cat /tmp/test.c
> > static __attribute__((force)) int *p;
> > static int q = *p;
> 
> In this example, the attribute "force" is not needed.
> I think it compiles fine without forcing it. The "force" don't
> actually do any thing. So why do we want to support this?

This particular case was simply an unrelated test case which happened to
trigger the error about having multiple storage classes.  The original
test case came from http://gcc.gnu.org/bugzilla/show_bug.cgi?id=59850#c3
; I noticed the use of -Wno-decl, presumably to suppress the warnings
about the two variables not being static, so I marked them as static and
got the error that motivated this thread.

- Josh Triplett
