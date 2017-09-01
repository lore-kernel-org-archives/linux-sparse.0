From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse test failures on ppc32le (and other not so common archs)
Date: Fri, 1 Sep 2017 07:51:16 -0400
Message-ID: <CANeU7Qn3X7pp_ZQXjqzywpnF7e6SjhMHoa87MNR9ocaf0xEmvw@mail.gmail.com>
References: <20170830161435.krq44m5zub4mq43x@taurus.defre.kleine-koenig.org>
 <c1cfea1b-c9e6-0df2-855e-cf66e25c9ccc@ramsayjones.plus.com>
 <20170830173652.2s26nti2s2mgupnd@taurus.defre.kleine-koenig.org>
 <CANeU7QmV0z58dGW2NTE+qH33OqW+WWCHZARF=h=XiiwhnS5jPg@mail.gmail.com>
 <20170831205514.vxmirle2yoc3rm44@taurus.defre.kleine-koenig.org>
 <c0e4a9fe-05ff-1280-f1ee-0c757ba3310b@ramsayjones.plus.com> <20170901074643.rivm2rit53mavkjr@taurus.defre.kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:33445 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751499AbdIALvS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 1 Sep 2017 07:51:18 -0400
Received: by mail-yw0-f169.google.com with SMTP id s62so7167638ywg.0
        for <linux-sparse@vger.kernel.org>; Fri, 01 Sep 2017 04:51:17 -0700 (PDT)
In-Reply-To: <20170901074643.rivm2rit53mavkjr@taurus.defre.kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, 873508@bugs.debian.org, Antoine Beaupre <anarcat@debian.org>

On Fri, Sep 1, 2017 at 3:46 AM, Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.or=
g> wrote:
\>
> Nearly right. I'm responsible for the sparse Debian package and the
> problem at hand is https://bugs.debian.org/873508. This bug report has
> "Severity: serious" wihch might eventually result in the removal of
> sparse from the Debian archive.
>
> @anarcat: Given that cgcc seems to work, would you agree to apply the
> following patch to horst:
>
> diff --git a/Makefile b/Makefile
> index 4f924fa..d563652 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -110,7 +110,7 @@ $(NAME): $(OBJS)
>  $(OBJS): .buildflags
>
>  check:
> -       sparse $(CFLAGS) *.[ch]
> +       cgcc -no-compile $(CFLAGS) *.[ch]

You patch definitely works.
I think it is the better way to fix it.
Sparse "selfcheck" target was doing the same thing.
It is using "cgcc -no-compile" already.

I suggest in your patch you can do some thing
similar to "selfcheck" target:

CHECKER =3D cgcc -no-compile

         $(CHECKER) $(CFLAGS) *.[ch]

Later when we update sparse to handle architecture
properly. We can just invoke make with "CHECKER=3Dxxxx"
to test.


> and downgrade the bug to "important"? That would be a compromise that
> buys us a bit of time.

Agree.

>
> This only solves a part of the problem because the bug report is about
> sparse itself, not it's llvm part.

I agree with that too.

Chris
