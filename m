From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: bad asm goto ?
Date: Sun, 21 Aug 2011 21:01:27 -0700
Message-ID: <CAHLZz10y6-bxMRv=aJhza9EqT92gp=72f_w+7WopAL7GqPDP3A@mail.gmail.com>
References: <20101025213145.GA1822@redhat.com>
	<AANLkTikVt5BJ+2W3P+wYUR3DLzhTatXhAW45wdc0eoOe@mail.gmail.com>
	<20101025223957.GA5561@redhat.com>
	<AANLkTi=r6U3CVS5Br5ZTVVyNEfKzhqTcKkEk5+itwNe1@mail.gmail.com>
	<AANLkTik3OLbW=sM1PFi8uazBHiJbPD06d0ns2z0DQzzN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58432 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733Ab1HVEB2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Aug 2011 00:01:28 -0400
Received: by qwk3 with SMTP id 3so2782804qwk.19
        for <linux-sparse@vger.kernel.org>; Sun, 21 Aug 2011 21:01:28 -0700 (PDT)
In-Reply-To: <AANLkTik3OLbW=sM1PFi8uazBHiJbPD06d0ns2z0DQzzN@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Dave Jones <davej@redhat.com>, linux-sparse@vger.kernel.org

Ping, noticed you moving towards a 0.4.4 release and this was still not=
 applied.

Harvey

On Mon, Oct 25, 2010 at 8:10 PM, Christopher Li <sparse@chrisli.org> wr=
ote:
> It seems that the error is not from the goto. It is from the malforme=
d
> asm_clobber.
> For empty asm_clobber list, sparse currently add nil expr into the
> list. Evaluate will
> complain about the nil pointer thinking it has a bad type.
>
> Any way, this patch should fix it.
>
> Please let me know that help you or not. I am going to apply it after
> the 0.4.3 release.
>
> Chris
>
> diff --git a/evaluate.c b/evaluate.c
> index f8343c2..1fb03ed 100644
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -3221,7 +3221,7 @@ static void evaluate_asm_statement(struct state=
ment *stmt)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0FOR_EACH_PTR(stmt->asm_clobbers, expr) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!expr) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 sparse_error(stmt->pos, "bad asm output");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 sparse_error(stmt->pos, "bad asm clobbers");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (expr->type=
 =3D=3D EXPR_STRING)
> diff --git a/parse.c b/parse.c
> index 537055f..6b7d656 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -1894,7 +1894,8 @@ static struct token *parse_asm_clobbers(struct
> token *token, struct statement *s
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0do {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0token =3D prim=
ary_expression(token->next, &expr);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add_expression(clo=
bbers, expr);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (expr)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 add_expression(clobbers, expr);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} while (match_op(token, ','));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return token;
> =C2=A0}
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spars=
e" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
