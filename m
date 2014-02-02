From: Christopher Li <sparse@chrisli.org>
Subject: Re: __attribute__((force)) should not be a storage class
Date: Sat, 1 Feb 2014 21:51:11 -0800
Message-ID: <CANeU7Qm1=8ks=Fu6LzjuAYxRqLPS3gssmD+uxNzDfN568Xxodw@mail.gmail.com>
References: <20140201184935.GA12321@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:33175 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718AbaBBFvM (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 2 Feb 2014 00:51:12 -0500
Received: by mail-qa0-f43.google.com with SMTP id o15so8414370qap.16
        for <linux-sparse@vger.kernel.org>; Sat, 01 Feb 2014 21:51:11 -0800 (PST)
In-Reply-To: <20140201184935.GA12321@leaf>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Al Viro <viro@ftp.linux.org.uk>

On Sat, Feb 1, 2014 at 10:49 AM, Josh Triplett <josh@joshtriplett.org> wrote:
> Commit 3829c4d8b097776e6b3472290a9fae08a705ab7a ("Don't mix storage
> class bits with ctype->modifiers while parsing type") in 2009 separated
> storage classes from modifiers; in the process, it changed
> __attribute__((force)) from a modifier to a storage class.  I don't
> think it makes sense to have force as a storage class, for one critical
> reason: storage classes are mutually exclusive.

I am not convinced yet.

The current usage case for attribute "force" is to silence the type
mismatch during the type conversion. For variable declaration, there is
not need to silence any mismatch because there is no type conversion.

What you are purposing here is a new usage case. Do you want
to silence every single type mismatch in every assignment to that
variable? How about assignment from that variable?

That seems a lot of complexity to keep track of the attribute
belong to which level of the type tree.

>
> $ cat /tmp/test.c
> static __attribute__((force)) int *p;
> static int q = *p;

In this example, the attribute "force" is not needed.
I think it compiles fine without forcing it. The "force" don't
actually do any thing. So why do we want to support this?

I want to justify the extra complexity it add to the code
base.

Chris
