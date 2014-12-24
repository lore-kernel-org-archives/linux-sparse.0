From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: Re: [PATCH] sparse: Make struct token::special signed
Date: Wed, 24 Dec 2014 12:07:10 +0100
Message-ID: <87egrp9uht.fsf@rasmusvillemoes.dk>
References: <1419340606-15606-1-git-send-email-rv@rasmusvillemoes.dk>
	<CA+55aFwW30VbRy7uiBZn-gmnYi7B7jr8g=rvR-_uhYxV3U6_Vw@mail.gmail.com>
	<1419397290.27103.72.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:44427 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbaLXLHO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Dec 2014 06:07:14 -0500
Received: by mail-lb0-f171.google.com with SMTP id w7so6747870lbi.16
        for <linux-sparse@vger.kernel.org>; Wed, 24 Dec 2014 03:07:12 -0800 (PST)
In-Reply-To: <1419397290.27103.72.camel@kernel.crashing.org> (Benjamin
	Herrenschmidt's message of "Wed, 24 Dec 2014 06:01:30 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

On Wed, Dec 24 2014, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Tue, 2014-12-23 at 11:01 -0800, Linus Torvalds wrote:
>> On Tue, Dec 23, 2014 at 5:16 AM, Rasmus Villemoes <rv@rasmusvillemoes.dk> wrote:
>> > There doesn't seem to be any reason for the special member of struct
>> > token to be unsigned; AFAICT it is only ever being directly compared
>> > to explicit characters and the SPECIAL_* enum constants using ==, !=
>> > and in a switch statement. Making it plain int avoids an annoying
>> > warning from match_op in token.h when compiling with -Wsign-compare.
>> 
>> Please don't use -Wsign-cpmpare to make decisions about code.
>> 
>> "unsigned" is generally the much preferred type if there are no
>> reasons for it to be signed. And -Wsign-compare on its own is not a
>> reason, since it gives insane warnings for good code.
>> 
>> -Wsign-compare is basically a "you can walk through the warnings and
>> see if any of them are actually valid" thing. It's not worth it in any
>> other form. Trying to be sign-compare clean will result in actively
>> *worse* code in some circumstances (ie pointless casts etc etc).
>
> Additionally "compare with characters" trips another flag, chars are
> unsigned by default on some archs :)

And signed on others... if anything, that seems to be an argument _for_
the patch, since an int can always represent the entire range of char,
while that is not true for unsigned.

Anyway, I'm not going to pursue this further.

Rasmus
