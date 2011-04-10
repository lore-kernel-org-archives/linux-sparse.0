From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] unify usage of VOID
Date: Sun, 10 Apr 2011 15:20:31 -0700
Message-ID: <BANLkTi=VYG-YwbSXksBgUayZfwTOWtfYiQ@mail.gmail.com>
References: <4DA1D9A1.3090109@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34093 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755199Ab1DJWUc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 10 Apr 2011 18:20:32 -0400
Received: by wya21 with SMTP id 21so4337131wya.19
        for <linux-sparse@vger.kernel.org>; Sun, 10 Apr 2011 15:20:31 -0700 (PDT)
In-Reply-To: <4DA1D9A1.3090109@seznam.cz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?ISO-8859-1?Q?Jan_Pokorn=FD?= <pokorny_jan@seznam.cz>
Cc: linux-sparse@vger.kernel.org

Hi Jan,

You are one fire with this sparse code :-)

I will take a closer look of your patch series tonight.

Thanks

Chris


On Sun, Apr 10, 2011 at 9:24 AM, Jan Pokorn=FD <pokorny_jan@seznam.cz> =
wrote:
> Also remove unneeded empty initializator of `void_pseudo'.
>
> Signed-off-by: Jan Pokorny <pokorny_jan@seznam.cz>
> ---
> =A0linearize.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/linearize.c b/linearize.c
> index f2034ce..46c9726 100644
> --- a/linearize.c
> +++ b/linearize.c
> @@ -33,7 +33,7 @@ struct access_data;
> =A0static pseudo_t add_load(struct entrypoint *ep, struct access_data=
 *);
> =A0static pseudo_t linearize_initializer(struct entrypoint *ep, struc=
t expression *initializer, struct access_data *);
>
> -struct pseudo void_pseudo =3D {};
> +struct pseudo void_pseudo;
>
> =A0static struct position current_pos;
>
> @@ -1880,7 +1880,7 @@ pseudo_t linearize_statement(struct entrypoint =
*ep, struct statement *stmt)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct basic_block *active;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pseudo_t src =3D linearize_expression(=
ep, expr);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0active =3D ep->active;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (active && src !=3D &void_pseudo) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (active && src !=3D VOID) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct instruction *ph=
i_node =3D first_instruction(bb_return->insns);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pseudo_t phi;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!phi_node) {
> --
> 1.7.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spars=
e" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
