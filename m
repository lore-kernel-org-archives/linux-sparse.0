From: "Mike Goodwin" <mike.goodwin@cantab.net>
Subject: Re: looking for any examples of using sparse
Date: Wed, 9 May 2007 23:34:39 -0700
Message-ID: <c38fc0de0705092334u6c3635e6i5fc1dec91a00f319@mail.gmail.com>
References: <bb2368c50705090732w4948fcc0ka3aea74ba22945b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.225]:56886 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755915AbXEJGek (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 10 May 2007 02:34:40 -0400
Received: by wr-out-0506.google.com with SMTP id 76so520766wra
        for <linux-sparse@vger.kernel.org>; Wed, 09 May 2007 23:34:39 -0700 (PDT)
In-Reply-To: <bb2368c50705090732w4948fcc0ka3aea74ba22945b5@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

I hear you, being in a similar situation myself. I believe I roughly
understand what is going on (though mostly I only care about up until
the parsing stage), but not well enough to explain.

Unless there is a trove of documentation I am missing, sparse at the
moment for better or worse seems to be an experts only (experts in
sparse that is!). The excessive amounts of comments I assume is said
with a little 2nd degree. For me what is lacking is the type of broad
comments (at the top of files say) that give an overall idea about how
things fit together - insightful remarks.

Probably most importantly the principal types are largely
undocumented. What invariants apply to them, when and how they will be
used. Ok, tokens are fairly self-explanatory and conventional, but
Symbols... Now I would hasard to say a symbol represents anything that
will be manifested in the compiled code, but this is probably
inaccurate (I am not sure what happens to unused types for instance if
this is true).

A couple of questions then:-
 -Preprocessing operates on tokens (i.e. before symbols are created).
So what role to NS_PREPROCESSOR and SYM_PREPROCESSOR have (and why are
both required)?

 -What is the meaning of SYM_NODE? (A block or statement in the code??)

From the top of symbol.h:
/*
 * An identifier with semantic meaning is a "symbol".
 *
 * There's a 1:n relationship: each symbol is always
 * associated with one identifier, while each identifier
 * can have one or more semantic meanings due to C scope
 * rules.
 *
 * The progression is symbol -> token -> identifier. The
 * token contains the information on where the symbol was
 * declared.
 */

Perhaps this could be elaborated upon.
"The progression is symbol -> token -> identifier."
Is this correct? Not wanting to embarrass myself, I would have thought
it would be something like
tokens->(identifier,symbol), i.e. we start with tokens, which groups
of which form symbols. One in the group will be the identifier. The
identifier structure itself is not namespace specific, so they are
shared between namespaces.

Sorry could say more but that was already longer than intended!

- Mike


On 5/9/07, Mish Mash <khalota@gmail.com> wrote:
> dear all,
>
> I'm trying to use sparse for writing various source code analysis
> tools (I was using ctool previously). I'm currently going through the
> source trying to figure out what I need. Given the excessive amounts
> of comments I'm having to wade through, this probably isn't the
> fastest way of figuring the beast out ;)
>
> Does anyone have any notes they've taken or can point me at code that
> uses sparse to help get a rough idea of how to use the beast? (Ideally
> slightly more detailed than Randy Dunlap's howto) I noticed smatch now
> uses sparse and i've applied their patch which I'm going over. Is
> there anything better? (I've already found the no longer very useful
> presentation at http://developer.osdl.org/dmo/sparse/)
>
> Thanks!
> nessim
> -
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
