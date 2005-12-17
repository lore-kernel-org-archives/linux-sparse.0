From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Sparse: fix the setting of __SIZE_TYPE__ in lib.c
Date: Sat, 17 Dec 2005 12:56:23 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512171251150.3698@g5.osdl.org>
References: <4301cff60512171240v3436593ei44e662a82893cc0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:48360 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964974AbVLQU4i (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 17 Dec 2005 15:56:38 -0500
In-Reply-To: <4301cff60512171240v3436593ei44e662a82893cc0a@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Mika Kukkonen <mikukkon@iki.fi>
Cc: linux-sparse@vger.kernel.org



On Sat, 17 Dec 2005, Mika Kukkonen wrote:
> 
> Does the attached patch make sense?

Please don't use attachments, but most _especially_ not attachements that 
aren't even marked "text/plain". It means that you have to save the 
attachment to a file, and can't quote it in the reply sanely.

Anyway, I'd much prefer a solution that just involves using a real type, 
ie a "__builtin_size_t" type or something, and then we just do

	#define __SIZE_T__ __builtin_size_t

We actually already have a builtin [s]size_t pointer: do a 

	git grep size_t_ctype

to see what I mean (although right now it always ends up pointing to 
"unsigned long", regardless of what __SIZE_T__ is, which means that you 
can end up with

	sizeof(__SIZE_T__) != sizeof(sizeof(int))

which is wrong.

		Linus
