From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: Casting away noderef and address spaces?
Date: Mon, 22 Dec 2008 20:57:50 +0000
Message-ID: <20081222205750.GK28946@ZenIV.linux.org.uk>
References: <200812221606.13910.rusty@rustcorp.com.au> <70318cbf0812221206o1b5e2aech2a36f723afc63ffa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:60553 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754016AbYLVU5y (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Dec 2008 15:57:54 -0500
Content-Disposition: inline
In-Reply-To: <70318cbf0812221206o1b5e2aech2a36f723afc63ffa@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-sparse@vger.kernel.org

On Mon, Dec 22, 2008 at 12:06:03PM -0800, Christopher Li wrote:
> On Sun, Dec 21, 2008 at 9:36 PM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> > #define convert(v) \
> >        (*(__attribute__((address_space(0), force)) typeof(&v))(v))
> >
> Am I reading it right? You are trying to dereferenc a type instead of a pointer?
> 
> I don't think you can do that with sparse.

The right solution is
	(*(typeof(v) __attribute__((address_space(0), force)) *)(&v))

Cast there will take a pointer to type of V and force-cast it to pointer to
unqualified type of V.  *(cast)&v will do the obvious thing.  Will trim
both the AS and noderef.
