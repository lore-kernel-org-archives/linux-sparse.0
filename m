From: Christopher Li <sparse@chrisli.org>
Subject: Re: Defect in linearization of short circuit &&
Date: Sun, 14 Feb 2010 15:09:53 -0800
Message-ID: <70318cbf1002141509u4ebc4ef5x51ec41f5f1452a7a@mail.gmail.com>
References: <4B77FD0F.50401@googlemail.com> <4B78655D.2080007@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:17018 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654Ab0BNXJy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 14 Feb 2010 18:09:54 -0500
Received: by qw-out-2122.google.com with SMTP id 5so353081qwi.37
        for <linux-sparse@vger.kernel.org>; Sun, 14 Feb 2010 15:09:53 -0800 (PST)
In-Reply-To: <4B78655D.2080007@googlemail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?ISO-8859-2?Q?Jacek_=A6liwerski?= <sliwers@googlemail.com>
Cc: linux-sparse@vger.kernel.org

2010/2/14 Jacek =C5=9Aliwerski <sliwers@googlemail.com>:
> Apparently, the issue is not with the linearization. =C2=A0I noticed =
that the
> condition has been parsed as:
>
> EXPR_BINOP
> =C2=A0* EXPR_LOGICAL
> =C2=A0 =C2=A0* EXPR_LOGICAL
> =C2=A0 =C2=A0 =C2=A0 * EXPR_PREOP
> =C2=A0 =C2=A0 =C2=A0 * EXPR_PREOP
> =C2=A0 =C2=A0* EXPR_COMPARE
> =C2=A0* EXPR_COMPARE
>
> After replacing EXPR_BINOP with EXPR_LOGICAL in the top node of the t=
ree,
> the linearization works just fine. =C2=A0Could someone explain me the=
 difference
> between EXPR_BINOP and EXPR_LOGICAL in this context?

EXPR_BINOP used in normal operation require two operands.
e.g.  a + b, a | b
Both operands will get evaluated.

EXPR_LOGICAL using for condition branching and it has the short curcit
behavior in mind. e.g. a || b

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
