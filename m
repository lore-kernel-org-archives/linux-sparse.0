From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: OP_CALL and function pointers
Date: Fri, 18 Nov 2011 10:24:08 -0200
Message-ID: <CA+55aFx56oV0cNvbDxE7g5fPfGrBST56SGqR9Wp7O+kBxGH+-g@mail.gmail.com>
References: <CAOJsxLHB0V=RxPmhQiW=G-2VSno9tJm3GHE4YFsUybkQjHXNnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37812 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316Ab1KRMYa (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 18 Nov 2011 07:24:30 -0500
Received: by eye27 with SMTP id 27so3201974eye.19
        for <linux-sparse@vger.kernel.org>; Fri, 18 Nov 2011 04:24:29 -0800 (PST)
In-Reply-To: <CAOJsxLHB0V=RxPmhQiW=G-2VSno9tJm3GHE4YFsUybkQjHXNnA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Christopher Li <sparse@chrisli.org>

On Fri, Nov 18, 2011 at 9:41 AM, Pekka Enberg <penberg@kernel.org> wrote:
>
> I'm implementing support for function pointer calls and I noticed that
> ->func->sym in 'strut instruction' is not SYM_NODE for function
> pointers like it is for normal functions. Why is that?

There *is* no real symbol to work with. It's an expression. The
expression may not even be a symbol, it could easily be some real
expression like

      ret = (flag ? fn1 : fn2)(arg1, arg2);

so trying to make up some "symbol" for it is just lying and crazy.

                  Linus
