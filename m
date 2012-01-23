From: =?ISO-8859-1?Q?Jan_Pokorn=FD?= <pokorny_jan@seznam.cz>
Subject: Re: [RFC] evaluate: pointer arithmetics on plain void*
Date: Mon, 23 Jan 2012 17:17:41 +0100
Message-ID: <4F1D8825.3090308@seznam.cz>
References: <4F1C9C49.2050707@seznam.cz> <4F1D3741.2030604@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fep12.mx.upcmail.net ([62.179.121.32]:38765 "EHLO
	fep12.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780Ab2AWQRo (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 23 Jan 2012 11:17:44 -0500
In-Reply-To: <4F1D3741.2030604@seznam.cz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: Christopher Li <sparse@chrisli.org>

Hi again,

On 01/23/2012 11:32 AM, Jan Pokorn=FD wrote:
> Hm, I was talking about post-ops only, the example showed a failing p=
re-op
> ...both is a single case as evaluate_preop boils down to evaluate_pos=
top.
>=20
> I went through evaluate.c again and I think these cases should be som=
ehow
> unified (stating current state):
>=20
> 1. evaluate_postop:
>   a. function: error ("bad argument type for ++/--")
>   b. void*:    nothing, but buggy evaluation (add/sub -1)

that "buggy evaluation" is a kind of regression that can be tracked dow=
n
to commit [1], which first started the "void !=3D char" idea and which
missed that evaluate_postop function.

> 2. evaluate_ptr_add
>   a. function: warning ("arithmetics on pointers to functions")
>   b. void*:    nothing, sizeof(void) implicitly considered as 1
>=20
> 3. evaluate_sizeof:
>   a. function: warning ("expression using sizeof on a function")
>   b. void:     warning ("expression using sizeof(void)")
>   (c. bool:     warning ("expression using sizeof bool"))
>=20
> 4. evaluate_ptrsizeof:
>   - ?
>=20
>=20
> The original patch makes 1b. an equivalent to 1a.  The alternative
> is to handle 1b. in a similar way as 2b.  Maybe both would deserve
> a warning.

The most moderate alternative is to take what what used in
evaluate_ptr_add into evaluate_postop.

However, the question whether to follow assumptions that GCC makes
emerges.  I tried also clang -pedantic, I got:

	warning: arithmetic on a pointer to void is a GNU extension
	         [-pedantic,-Wpointer-arith]

> Still, there is at least one inconsistency: 1a. vs 2a. (error vs warn=
ing).

[1] http://git.kernel.org/?p=3Ddevel/sparse/sparse.git;a=3Dcommit;h=3D4=
05cd6e

--=20
Jan
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
