From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [RFC][PATCH] fix casting constant to _Bool
Date: Sat, 16 Jun 2012 10:10:18 +0300
Message-ID: <CAOJsxLGAQ2Dn-NiJ1FkD+JxL2Bp7ni-jwptgT99QrW21KrdFzg@mail.gmail.com>
References: <1339829720-2069-1-git-send-email-xi.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:52523 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753751Ab2FPHKT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 16 Jun 2012 03:10:19 -0400
Received: by obbtb18 with SMTP id tb18so5129646obb.19
        for <linux-sparse@vger.kernel.org>; Sat, 16 Jun 2012 00:10:18 -0700 (PDT)
In-Reply-To: <1339829720-2069-1-git-send-email-xi.wang@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Xi Wang <xi.wang@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>

On Sat, Jun 16, 2012 at 9:55 AM, Xi Wang <xi.wang@gmail.com> wrote:
> Casting to _Bool requires a zero test rather than truncation.
>
> Signed-off-by: Xi Wang <xi.wang@gmail.com>
> ---
> A simple example is:
>
> =A0_Bool x =3D 0x200;
>
> x should have been true rather than false.
>
> BTW, this patch also disables the warning "cast truncates bits from
> constant value". =A0Does that sound good?

That's unfortunate.

> A more serious problem is something like:
>
> =A0_Bool foo(int x) { return x; }
>
> sparse emits:
>
> =A0scast.1 =A0 =A0 %r2 <- (32) %arg1
>
> which makes sparse-llvm generate:
>
> =A0%R2 =3D trunc i32 %0 to i1
>
> My experimental backend "splay" has to treat _Bool specifically to
> generate:
>
> =A0%0 =3D icmp ne i32 %x, 0
>
> Should we leave the conversion job to backends, or should we just fix
> the sparse IR (e.g., emitting setne rather than scast for casts to _B=
ool)?

It'd be best if the backend didn't have to do anything special here.
Can we have it both ways? Not disable the warning but still deal with
it in the frontend?

> ---
> =A0expand.c | =A0 =A06 ++++++
> =A01 file changed, 6 insertions(+)
>
> diff --git a/expand.c b/expand.c
> index 63a9075..ee818a4 100644
> --- a/expand.c
> +++ b/expand.c
> @@ -92,6 +92,12 @@ void cast_value(struct expression *expr, struct sy=
mbol *newtype,
> =A0 =A0 =A0 =A0value =3D get_longlong(old);
>
> =A0Int:
> + =A0 =A0 =A0 // _Bool requires a zero test rather than truncation.
> + =A0 =A0 =A0 if (is_bool_type(newtype)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 expr->value =3D value ? 1 : 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0// Truncate it to the new size
> =A0 =A0 =A0 =A0signmask =3D 1ULL << (new_size-1);
> =A0 =A0 =A0 =A0mask =3D signmask | (signmask-1);
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spars=
e" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
