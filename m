From: Xi Wang <xi.wang@gmail.com>
Subject: Re: [PATCH] fix casts when linearizing compound assignments
Date: Fri, 8 Jun 2012 15:25:11 -0400
Message-ID: <D19AC258-0412-4310-B2DE-A593F50203D4@gmail.com>
References: <1339152460-17411-1-git-send-email-xi.wang@gmail.com> <56898225-DCA7-465E-BFD8-7D9D084A243B@gmail.com> <CAOJsxLEQhzNe2RNKW3RkDNkLbu3cszJfW0KzRq4oNRVaRXoP5Q@mail.gmail.com> <CA+55aFyGWsjSqrAEvc=TL9qB0QabKuBaVx7ncABJ+A_McKY5wg@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:36168 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772Ab2FHTZQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 8 Jun 2012 15:25:16 -0400
Received: by gglu4 with SMTP id u4so1543543ggl.19
        for <linux-sparse@vger.kernel.org>; Fri, 08 Jun 2012 12:25:15 -0700 (PDT)
In-Reply-To: <CA+55aFyGWsjSqrAEvc=TL9qB0QabKuBaVx7ncABJ+A_McKY5wg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pekka Enberg <penberg@kernel.org>, linux-sparse@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christopher Li <sparse@chrisli.org>

On Jun 8, 2012, at 3:18 PM, Linus Torvalds wrote:

> On Fri, Jun 8, 2012 at 12:10 PM, Pekka Enberg <penberg@kernel.org> wrote:
>> 
>> So it seems that LLVM really wants to use the "getelementptr" thingy
>> for these. I have no idea what makes the most sense from sparse IR
>> point of view.
> 
> I think the right thing to do is as an EXPR_BINOP with a
> "SPECIAL_ADDPTR" operation which takes a pointer and a (pre-scaled)
> 'long'.
> 
> From a code generation and optimization standpoint, OP_ADDPTR would be
> the same as '+'

Not sure we really need getelementptr.

What I am doing now is to convert all operands to integers first,
perform the addition, and then convert the result back to pointer.
Anything wrong with that?

- xi
