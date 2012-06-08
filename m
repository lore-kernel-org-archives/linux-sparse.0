From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] fix casts when linearizing compound assignments
Date: Fri, 8 Jun 2012 12:18:55 -0700
Message-ID: <CA+55aFyGWsjSqrAEvc=TL9qB0QabKuBaVx7ncABJ+A_McKY5wg@mail.gmail.com>
References: <1339152460-17411-1-git-send-email-xi.wang@gmail.com>
 <56898225-DCA7-465E-BFD8-7D9D084A243B@gmail.com> <CAOJsxLEQhzNe2RNKW3RkDNkLbu3cszJfW0KzRq4oNRVaRXoP5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:61048 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756340Ab2FHTTR (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 8 Jun 2012 15:19:17 -0400
Received: by weyu7 with SMTP id u7so807207wey.19
        for <linux-sparse@vger.kernel.org>; Fri, 08 Jun 2012 12:19:16 -0700 (PDT)
In-Reply-To: <CAOJsxLEQhzNe2RNKW3RkDNkLbu3cszJfW0KzRq4oNRVaRXoP5Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Xi Wang <xi.wang@gmail.com>, linux-sparse@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christopher Li <sparse@chrisli.org>

On Fri, Jun 8, 2012 at 12:10 PM, Pekka Enberg <penberg@kernel.org> wrote:
>
> So it seems that LLVM really wants to use the "getelementptr" thingy
> for these. I have no idea what makes the most sense from sparse IR
> point of view.

I think the right thing to do is as an EXPR_BINOP with a
"SPECIAL_ADDPTR" operation which takes a pointer and a (pre-scaled)
'long'.

From a code generation and optimization standpoint, OP_ADDPTR would be
the same as '+'

                   Linus
