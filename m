From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: pre-process.c:569:18: error: bad constant expression
Date: Sat, 31 Dec 2005 11:31:44 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512311122400.3249@g5.osdl.org>
References: <20051231073006.GA3583@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:4019 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965043AbVLaTbt (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 31 Dec 2005 14:31:49 -0500
In-Reply-To: <20051231073006.GA3583@localhost>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alecs King <alecsk@gmail.com>
Cc: linux-sparse <linux-sparse@vger.kernel.org>



On Sat, 31 Dec 2005, Alecs King wrote:
>
>         int nargs = sym->arglist ? sym->arglist->count.normal : 0;
>         struct arg args[nargs];
> 
> gcc went fine but sparse complaint about this.  Declaring such kind of
> variable-sized arrays is allowed or not?  Seems 'nargs' cannot be
> evaluated until runtime..?

sparse doesn't really do C99, it does a mixture of traditional ANSI C with 
many (but not all) of the newer features.  And sometimes it refuses to do 
traditional ANSI C too (warning about function prototypes without an 
explicit "(void)" to show that there are no arguments etc).

And one of the things it doesn't like is variable-sized arrays. It will 
actually correctly handle _some_ aspects of them (it should parse them and 
so on)), but never got it working properly even enough to make "sizeof" 
work, and they are not liked in the kernel sources, so it warns about 
them.

Variable-sized arrays really are pretty nasty to handle. I'e made 
"array_size" be a "struct expression *" in preparation for allowing it to 
be supported, but much more is needed.

		Linus
