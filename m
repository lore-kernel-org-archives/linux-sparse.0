From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Bug#873508: sparse test failures on ppc32le (and other not so
 common archs)
Date: Wed, 27 Sep 2017 10:40:55 +0200
Message-ID: <CAExDi1R4cFouc2YmCv6dfn2cKqWErN7YQ1r-_Caj9K1s_yH90A@mail.gmail.com>
References: <c1cfea1b-c9e6-0df2-855e-cf66e25c9ccc@ramsayjones.plus.com>
 <20170830173652.2s26nti2s2mgupnd@taurus.defre.kleine-koenig.org>
 <CANeU7QmV0z58dGW2NTE+qH33OqW+WWCHZARF=h=XiiwhnS5jPg@mail.gmail.com>
 <20170831205514.vxmirle2yoc3rm44@taurus.defre.kleine-koenig.org>
 <c0e4a9fe-05ff-1280-f1ee-0c757ba3310b@ramsayjones.plus.com>
 <20170901074643.rivm2rit53mavkjr@taurus.defre.kleine-koenig.org>
 <150392922734.24087.13050909898214597041.reportbug@curie.anarc.at>
 <20170921185823.5fnxchdowq5krxy3@taurus.defre.kleine-koenig.org>
 <20170926181101.jas3ytdiro7o7mj7@taurus.defre.kleine-koenig.org> <20170927080007.jz2vfe4ekjjowkbe@taurus.defre.kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:33558 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbdI0Ik5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 27 Sep 2017 04:40:57 -0400
Received: by mail-io0-f194.google.com with SMTP id j26so5836236iod.0
        for <linux-sparse@vger.kernel.org>; Wed, 27 Sep 2017 01:40:56 -0700 (PDT)
In-Reply-To: <20170927080007.jz2vfe4ekjjowkbe@taurus.defre.kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Christopher Li <sparse@chrisli.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, 873508@bugs.debian.org, Antoine Beaupre <anarcat@debian.org>

On Wed, Sep 27, 2017 at 10:00 AM, Uwe Kleine-K=C3=B6nig
<uwe@kleine-koenig.org> wrote:
> Hello,
>
> On Tue, Sep 26, 2017 at 08:11:01PM +0200, Uwe Kleine-K=C3=B6nig wrote:
>> And ppc64 and x32 need the respective cpp defines added I think. If
>> noone beats me to it, I will look into the latter at least during the
>> next few days.
>
> Looking at ppc64, the following fixes the build:
>
> diff --git a/cgcc b/cgcc
> index a8d7b4f217fe..a1c02899c623 100755
> --- a/cgcc
> +++ b/cgcc
> @@ -286,7 +286,7 @@ sub add_specs {
>      } elsif ($spec eq 'ppc64') {
>         return (' -D__powerpc__=3D1 -D__PPC__=3D1 -D_STRING_ARCH_unaligne=
d=3D1' .
>                 ' -D__powerpc64__=3D1 -D__PPC64__=3D1' .
> -               ' -D_CALL_ELF=3D2' .
> +               ' -D_CALL_ELF=3D1' .
>                 ' -m64' .
>                 &float_types (1, 1, 21, [24,8], [53,11], [113,15]));
>      } elsif ($spec eq 's390x') {
>
> I wonder if that could be right. Luc, you added =3D2 in
> e0306fe0b725af6e2e7ff59d7f0d99c96315791a, maybe you can comment?

Neither =3D2 or =3D1 is correct, it depends on which version of the ELF
ABI you're using.
This in turn (as I understood) is most of the time tied to fact that
you're using ppc64le
(which normally needs ELFv2) or not.

I can't look at this now but will do this evening.

-- Luc
