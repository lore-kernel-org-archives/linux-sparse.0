From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] flow.c: make comment for `dominates' reflect code
Date: Wed, 13 Apr 2011 02:05:58 -0700
Message-ID: <BANLkTikzS0Ah+fn22MWeVtBMYg97c7Fz=A@mail.gmail.com>
References: <4D9E3DE7.3080003@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51231 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757894Ab1DMJF7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 13 Apr 2011 05:05:59 -0400
Received: by vws1 with SMTP id 1so280378vws.19
        for <linux-sparse@vger.kernel.org>; Wed, 13 Apr 2011 02:05:58 -0700 (PDT)
In-Reply-To: <4D9E3DE7.3080003@seznam.cz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?ISO-8859-1?Q?Jan_Pokorn=FD?= <pokorny_jan@seznam.cz>
Cc: linux-sparse@vger.kernel.org

Applied.

Chris

On Thu, Apr 7, 2011 at 3:42 PM, Jan Pokorn=FD <pokorny_jan@seznam.cz> w=
rote:
> Signed-off-by: Jan Pokorny <pokorny_jan@seznam.cz>
> ---
> =A0flow.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/flow.c b/flow.c
> index 5bd9a1d..7db9548 100644
> --- a/flow.c
> +++ b/flow.c
> @@ -284,8 +284,8 @@ static inline int same_memop(struct instruction *=
a, struct instruction *b)
> =A0}
>
> =A0/*
> - * Return 1 if "one" dominates the access to 'pseudo'
> - * in insn.
> + * Return 1 if "dom" dominates the access to "pseudo"
> + * in "insn".
> =A0*
> =A0* Return 0 if it doesn't, and -1 if you don't know.
> =A0*/
> --
> 1.7.1
>
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
