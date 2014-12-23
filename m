From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] sparse: Make struct token::special signed
Date: Tue, 23 Dec 2014 11:01:09 -0800
Message-ID: <CA+55aFwW30VbRy7uiBZn-gmnYi7B7jr8g=rvR-_uhYxV3U6_Vw@mail.gmail.com>
References: <1419340606-15606-1-git-send-email-rv@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:60070 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbaLWTBL (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 23 Dec 2014 14:01:11 -0500
Received: by mail-qc0-f179.google.com with SMTP id c9so4925420qcz.24
        for <linux-sparse@vger.kernel.org>; Tue, 23 Dec 2014 11:01:10 -0800 (PST)
In-Reply-To: <1419340606-15606-1-git-send-email-rv@rasmusvillemoes.dk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

On Tue, Dec 23, 2014 at 5:16 AM, Rasmus Villemoes <rv@rasmusvillemoes.dk> wrote:
> There doesn't seem to be any reason for the special member of struct
> token to be unsigned; AFAICT it is only ever being directly compared
> to explicit characters and the SPECIAL_* enum constants using ==, !=
> and in a switch statement. Making it plain int avoids an annoying
> warning from match_op in token.h when compiling with -Wsign-compare.

Please don't use -Wsign-cpmpare to make decisions about code.

"unsigned" is generally the much preferred type if there are no
reasons for it to be signed. And -Wsign-compare on its own is not a
reason, since it gives insane warnings for good code.

-Wsign-compare is basically a "you can walk through the warnings and
see if any of them are actually valid" thing. It's not worth it in any
other form. Trying to be sign-compare clean will result in actively
*worse* code in some circumstances (ie pointless casts etc etc).

                     Linus
