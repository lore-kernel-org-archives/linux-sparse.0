From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] [PATCH] clean up cclass
Date: Sat, 31 Dec 2005 13:26:39 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512311320350.3249@g5.osdl.org>
References: <20051231072055.GA2323@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:62143 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751317AbVLaV0o (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 31 Dec 2005 16:26:44 -0500
In-Reply-To: <20051231072055.GA2323@localhost>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alecs King <alecsk@gmail.com>
Cc: linux-sparse <linux-sparse@vger.kernel.org>



On Sat, 31 Dec 2005, Alecs King wrote:
>
> Is there a good reason to always add that '+ 1' in both initialization
> and dereference of cclass?

EOF, aka -1.

Now, whether that's a good enough reason for ugly code, I don't know. You 
could do the same by doing something like

	static const struct {
		long eof;
		long c[256];
	} cclass = { 0 , { ..sane initializer.. } };

and then using

	cclass.c[next]

without the "+1". It might noe be strictly conforming, but it sure as hell 
should work in practice.

Another (perhaps better) alternative is to change the #define of EOF from 
-1 to 256, and then make sure that we don't rely on "next < 0" anywhere 
(which we might do by changing the type to "unsigned int" and expecting 
the compiler to complain.

			Linus
