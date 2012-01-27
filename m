From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] evaluate: reject post-ops on void*
Date: Fri, 27 Jan 2012 03:42:56 -0800
Message-ID: <CANeU7Qnrjf9xAerY3azSUfSg1QBwrLSSVgXQLm_WVad5qnatnQ@mail.gmail.com>
References: <4F1C9C49.2050707@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60575 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753753Ab2A0Lm5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 27 Jan 2012 06:42:57 -0500
Received: by yenm6 with SMTP id m6so723296yen.19
        for <linux-sparse@vger.kernel.org>; Fri, 27 Jan 2012 03:42:56 -0800 (PST)
In-Reply-To: <4F1C9C49.2050707@seznam.cz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?ISO-8859-1?Q?Jan_Pokorn=FD?= <pokorny_jan@seznam.cz>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Sorry for the late reply.

On Sun, Jan 22, 2012 at 3:31 PM, Jan Pokorn=FD <pokorny_jan@seznam.cz> =
wrote:
> Following example haven't been linearized correctly:
>
> =A0 =A0 =A0 =A0static void *inc_ptr(void *a) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ++a;
> =A0 =A0 =A0 =A0}
>
> test-linearize:
>
> =A0 =A0 =A0 =A0<entry-point>
> =A0 =A0 =A0 =A0add.32 =A0 =A0 =A0%r2 <- %arg1, $-1
> =A0 =A0 =A0 =A0ret.32 =A0 =A0 =A0%r2

Yes, you discover a bug in the area we did not treat
type size consistently.

> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -1711,7 +1711,8 @@ static struct symbol *evaluate_postop(struct ex=
pression *expr)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0multiply =3D 1;
> =A0 =A0 =A0 =A0} else if (class =3D=3D TYPE_PTR) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct symbol *target =3D examine_poin=
ter_target(ctype);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!is_function(target))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* beside function, reject also void* (=
due to sizeof(void)) */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (target !=3D &void_ctype && !is_func=
tion(target))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0multiply =3D bits_to_b=
ytes(target->bit_size);
> =A0 =A0 =A0 =A0}

Good catch, but it does not cover all the special case yet.
If you look at evaluate_sizeof(), there are 3 different types need spec=
ial
handling: void, bool, function.

Same thing should be apply to implicit sizeof operations. They should
share some code rather than enumerate the special case in two different
places. Let me think about it more.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
