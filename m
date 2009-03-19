From: Hannes Eder <hannes@hanneseder.net>
Subject: Re: [PATCH] test-suite: new preprocessor test case
Date: Thu, 19 Mar 2009 19:51:22 +0100
Message-ID: <154e089b0903191151q37ab7b20o43838845af12966f@mail.gmail.com>
References: <20090319175544.13691.42362.stgit@f10box.hanneseder.net>
	 <20090319182628.GB28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:34966 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196AbZCSSvZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 19 Mar 2009 14:51:25 -0400
Received: by bwz17 with SMTP id 17so621624bwz.37
        for <linux-sparse@vger.kernel.org>; Thu, 19 Mar 2009 11:51:22 -0700 (PDT)
In-Reply-To: <20090319182628.GB28946@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

On Thu, Mar 19, 2009 at 7:26 PM, Al Viro <viro@zeniv.linux.org.uk> wrot=
e:
> On Thu, Mar 19, 2009 at 06:56:11PM +0100, Hannes Eder wrote:
>> Sparse currently fails on this test.
>
> It doesn't. =A06.10.3p11: "If there are sequences of preprocessing to=
kens
> within the list of arguments that would otherwise act as preprocessin=
g
> directives, the behavior is undefined."
>
> You are asking for identical nasal demons from two implementations, w=
hen
> it's not even promised that the same kind will fly on two invocations=
 of
> the same implementation...
>
> Seriously, this is undefined behaviour *and* it's extermely hard to c=
ome
> up with self-consistent semantics for it. =A0Standard doesn't even tr=
y and
> implementations are doing whatever's more convenient at the moment. =A0=
Try
> to think of it and you'll come up with really ugly corner cases very =
fast.
>
> What we probably ought to do is a warning when such stuff happens.

Ok, I see. It's not a bug, but I wouldn't consider it as a feature eith=
er :)

When currently running sparse agains the current linux-next tree, a
lot of checks produce error messages like this:

include/linux/skbuff.h:381:9: error: expected preprocessor identifier

where gcc happily compiles it, because it preprocesses it differently

e.g.

$ gcc -E -P validation/preprocessor/preprocessor22.c
struct { int b; } a;;

comparing to

$ sparse -E
struct {
} a;;

This difference makes sparse at the moment less applicable to the
linux(-next) tree.

What can be done about that?

-Hannes
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
