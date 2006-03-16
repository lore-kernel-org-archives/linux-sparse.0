From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: case label types
Date: Wed, 15 Mar 2006 17:29:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603151721130.3618@g5.osdl.org>
References: <200603160107.k2G17Bo25114@troll.rentec.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:50405 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751735AbWCPB3Y (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 15 Mar 2006 20:29:24 -0500
In-Reply-To: <200603160107.k2G17Bo25114@troll.rentec.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Morten Welinder <terra@gnome.org>
Cc: linux-sparse@vger.kernel.org



On Wed, 15 Mar 2006, Morten Welinder wrote:
> 
> Shouldn't sparse complain over this kind of code, or does it have
> legitimate uses?

Hm.. Making sparse complain is probably a good idea.

> Specifically, enum constants from two different enums occur in the
> same switch.

However, this is actually no different from

	typedef enum { A1, A2 } enumA;
	typedef enum { B1 = 10, B2 } enumB;

	..
	if (A1 == B1)
		..

and the lack of warning comes from the exact same cause. Indeed, these 
days (since commit 464710af, to be exact), the case type-checking shares 
the exact same logic - it does

	...
	if (compatible_restricted_binop(SPECIAL_EQUAL, &switch_expr, &case_expr))
		return;
	..

so it literally considers the case/switch expression equality testing to 
be 100% the same as the binop "==" test.

Oh, except there is a bug there: it _meant_ to check that they are both 
integer types, but it does that wrong:

	if (is_int_type(switch_type) && is_int_type(case_type))
		return;

which looks way too permissive. That should probably be testing for 
"compatible_integer_binop(switch_type, case_type)" instead.

I assume that in general we _do_ want the case/switch statements to have 
the same test as if you tested for equality explicitly.

Hmm? 

		Linus
