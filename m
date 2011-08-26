From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 4/5] sparse, i386: Fix boolean bit size
Date: Thu, 25 Aug 2011 20:59:49 -0700
Message-ID: <CANeU7QktGkA-u9x7FzDUosVjNfhYeNv0C9o0G9n=SmuivWeNpQ@mail.gmail.com>
References: <1314021451-24808-1-git-send-email-penberg@kernel.org>
	<1314021451-24808-4-git-send-email-penberg@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55109 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059Ab1HZD7u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 25 Aug 2011 23:59:50 -0400
Received: by qwk3 with SMTP id 3so1753396qwk.19
        for <linux-sparse@vger.kernel.org>; Thu, 25 Aug 2011 20:59:49 -0700 (PDT)
In-Reply-To: <1314021451-24808-4-git-send-email-penberg@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: linux-sparse@vger.kernel.org, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Aug 22, 2011 at 6:57 AM, Pekka Enberg <penberg@kernel.org> wrot=
e:
> The value of 'ctype->bit_size' is set to 1 for booleans which confuse=
s the i386
> backend:
>
> =A0./compile allocate.c
> =A0compile: compile-i386.c:1406: emit_binop: Assertion `0' failed.
> =A0Aborted
>
> Looking at the code, we assume that "bit_size / 8" gives a sane resul=
t on
> various places. This patch fixes the problem by bumping bit_size to 8=
 for
> booleans. This also makes sizeof(_Bool) return 1 which is consistent =
with what
> GCC 4.4.3, for example, does.
>
> diff --git a/target.c b/target.c
> index 17b228a..6a535bc 100644
> --- a/target.c
> +++ b/target.c
> @@ -14,7 +14,7 @@ int max_alignment =3D 16;
> =A0/*
> =A0* Integer data types
> =A0*/
> -int bits_in_bool =3D 1;
> +int bits_in_bool =3D 8;

I object this part. I consider the sizeof(_Bool) =3D=3D 1 as external b=
ehaviour.
But internally we should know that the real useful part of bool is in j=
ust one
bit, not any bit of that  1 byte storage.

Allowing _Bool to be addressable is a separate issue. I consider those
rest of 7 bit as paddings. Not the useful part of _Bool.

> =A0int bits_in_char =3D 8;
> =A0int bits_in_short =3D 16;
> =A0int bits_in_int =3D 32;
> diff --git a/validation/sizeof-bool.c b/validation/sizeof-bool.c
> index 6c68748..31b0585 100644
> --- a/validation/sizeof-bool.c
> +++ b/validation/sizeof-bool.c
> @@ -4,9 +4,6 @@ static int a(void)
> =A0}
> =A0/*
> =A0* check-name: sizeof(_Bool) is valid
> - * check-description: sizeof(_Bool) was rejected because _Bool is no=
t an even
> - * number of bytes
> =A0* check-error-start
> -sizeof-bool.c:3:16: warning: expression using sizeof bool
> =A0* check-error-end
> =A0*/

We should just fix the validation.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
