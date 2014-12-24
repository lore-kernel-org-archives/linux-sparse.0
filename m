From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] sparse: Make struct token::special signed
Date: Wed, 24 Dec 2014 06:01:30 +0100
Message-ID: <1419397290.27103.72.camel@kernel.crashing.org>
References: <1419340606-15606-1-git-send-email-rv@rasmusvillemoes.dk>
	 <CA+55aFwW30VbRy7uiBZn-gmnYi7B7jr8g=rvR-_uhYxV3U6_Vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:35271 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746AbaLXFBv (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Dec 2014 00:01:51 -0500
In-Reply-To: <CA+55aFwW30VbRy7uiBZn-gmnYi7B7jr8g=rvR-_uhYxV3U6_Vw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rasmus Villemoes <rv@rasmusvillemoes.dk>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

On Tue, 2014-12-23 at 11:01 -0800, Linus Torvalds wrote:
> On Tue, Dec 23, 2014 at 5:16 AM, Rasmus Villemoes <rv@rasmusvillemoes.dk> wrote:
> > There doesn't seem to be any reason for the special member of struct
> > token to be unsigned; AFAICT it is only ever being directly compared
> > to explicit characters and the SPECIAL_* enum constants using ==, !=
> > and in a switch statement. Making it plain int avoids an annoying
> > warning from match_op in token.h when compiling with -Wsign-compare.
> 
> Please don't use -Wsign-cpmpare to make decisions about code.
> 
> "unsigned" is generally the much preferred type if there are no
> reasons for it to be signed. And -Wsign-compare on its own is not a
> reason, since it gives insane warnings for good code.
> 
> -Wsign-compare is basically a "you can walk through the warnings and
> see if any of them are actually valid" thing. It's not worth it in any
> other form. Trying to be sign-compare clean will result in actively
> *worse* code in some circumstances (ie pointless casts etc etc).

Additionally "compare with characters" trips another flag, chars are
unsigned by default on some archs :)

Cheers
Ben.

>                      Linus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


