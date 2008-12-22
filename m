From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: Casting away noderef and address spaces?
Date: Mon, 22 Dec 2008 13:23:47 -0800
Message-ID: <70318cbf0812221323s53119420qcdb2ee0542185667@mail.gmail.com>
References: <200812221606.13910.rusty@rustcorp.com.au>
	 <70318cbf0812221206o1b5e2aech2a36f723afc63ffa@mail.gmail.com>
	 <20081222205750.GK28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:26047 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbYLVVXs (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Dec 2008 16:23:48 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2084546rvb.1
        for <linux-sparse@vger.kernel.org>; Mon, 22 Dec 2008 13:23:47 -0800 (PST)
In-Reply-To: <20081222205750.GK28946@ZenIV.linux.org.uk>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-sparse@vger.kernel.org

On Mon, Dec 22, 2008 at 12:57 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> The right solution is
>        (*(typeof(v) __attribute__((address_space(0), force)) *)(&v))
>
> Cast there will take a pointer to type of V and force-cast it to pointer to
> unqualified type of V.  *(cast)&v will do the obvious thing.  Will trim
> both the AS and noderef.

Thanks, that is much better. However sparse don't know how to handle it yet.

/tmp/typeof.c:11:64: warning: incorrect type in assignment (invalid types)
/tmp/typeof.c:11:64:    expected unknown type 11 <noident>
/tmp/typeof.c:11:64:    got int

classify_type does not know how to handle SYM_TYPEOF yet.
Let me see if I can make it to work.

Chris
