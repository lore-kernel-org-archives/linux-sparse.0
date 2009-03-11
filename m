From: Christopher Li <sparse@chrisli.org>
Subject: Re: Braino in attribute_packed()
Date: Wed, 11 Mar 2009 12:39:32 -0700
Message-ID: <70318cbf0903111239x6c2cfed6ybc997c835500c3dc@mail.gmail.com>
References: <E1LhQct-0006sH-5W@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.235]:18758 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbZCKTjf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 11 Mar 2009 15:39:35 -0400
Received: by rv-out-0506.google.com with SMTP id g37so146143rvb.1
        for <linux-sparse@vger.kernel.org>; Wed, 11 Mar 2009 12:39:32 -0700 (PDT)
In-Reply-To: <E1LhQct-0006sH-5W@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

All applied.

Thanks!

Chris

On Wed, Mar 11, 2009 at 8:45 AM, Al Viro <viro@ftp.linux.org.uk> wrote:
>
> D'oh...
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> =A0parse.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/parse.c b/parse.c
> index f16d321..e2b47e3 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -943,7 +943,7 @@ static struct token *ignore_attribute(struct toke=
n *token, struct symbol *attr,
>
> =A0static struct token *attribute_packed(struct token *token, struct =
symbol *attr, struct decl_state *ctx)
> =A0{
> - =A0 =A0 =A0 if (!&ctx->ctype.alignment)
> + =A0 =A0 =A0 if (!ctx->ctype.alignment)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctx->ctype.alignment =3D 1;
> =A0 =A0 =A0 =A0return token;
> =A0}
> --
> 1.5.6.5
>
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
