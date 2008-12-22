From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: Casting away noderef and address spaces?
Date: Mon, 22 Dec 2008 21:39:54 +0000
Message-ID: <20081222213953.GN28946@ZenIV.linux.org.uk>
References: <200812221606.13910.rusty@rustcorp.com.au> <70318cbf0812221206o1b5e2aech2a36f723afc63ffa@mail.gmail.com> <20081222205750.GK28946@ZenIV.linux.org.uk> <70318cbf0812221323s53119420qcdb2ee0542185667@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:57013 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754610AbYLVVkA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Dec 2008 16:40:00 -0500
Content-Disposition: inline
In-Reply-To: <70318cbf0812221323s53119420qcdb2ee0542185667@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-sparse@vger.kernel.org

On Mon, Dec 22, 2008 at 01:23:47PM -0800, Christopher Li wrote:
> On Mon, Dec 22, 2008 at 12:57 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > The right solution is
> >        (*(typeof(v) __attribute__((address_space(0), force)) *)(&v))
> >
> > Cast there will take a pointer to type of V and force-cast it to pointer to
> > unqualified type of V.  *(cast)&v will do the obvious thing.  Will trim
> > both the AS and noderef.
> 
> Thanks, that is much better. However sparse don't know how to handle it yet.
> 
> /tmp/typeof.c:11:64: warning: incorrect type in assignment (invalid types)
> /tmp/typeof.c:11:64:    expected unknown type 11 <noident>
> /tmp/typeof.c:11:64:    got int
> 
> classify_type does not know how to handle SYM_TYPEOF yet.
> Let me see if I can make it to work.

Works here (built from 8f208e215a531d2b32aec0428fd5eaa24ae3100b)...

But yes, SYM_TYPEOF is a brittle mess, so whether that works or not
is, er, version-dependent ;-/

I really ought to resurrect lazy-type-expressions branch...
