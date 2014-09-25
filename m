From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 0/7] Silence even more W=2 warnings
Date: Thu, 25 Sep 2014 18:44:46 +0200
Message-ID: <20140925164446.GD28201@nazgul.tnic>
References: <AEF1C0F7-239C-436B-97A5-6AFF49FD9359@intel.com>
 <20140922184049.GB4709@pd.tnic>
 <3199350A-89CE-4BE7-8FE4-CA8CE4F87622@intel.com>
 <20140922192152.GD4709@pd.tnic>
 <1411415057.2513.8.camel@jtkirshe-mobl.jf.intel.com>
 <20140922195737.GE4709@pd.tnic>
 <1411416573.2513.19.camel@jtkirshe-mobl.jf.intel.com>
 <20140922203336.GF4709@pd.tnic>
 <1411420912.2513.32.camel@jtkirshe-mobl.jf.intel.com>
 <CAMuHMdU7VO01_qRGc0TV2K+nJJCu4sm0zbH773_zBWdaxSR1aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdU7VO01_qRGc0TV2K+nJJCu4sm0zbH773_zBWdaxSR1aQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>, "Rustad, Mark D" <mark.d.rustad@intel.com>, "sparse@chrisli.org" <sparse@chrisli.org>, "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

On Thu, Sep 25, 2014 at 09:45:29AM +0200, Geert Uytterhoeven wrote:
> Instead of grepping, you can feed the build log to linux-log-summary.
> Or when changing a driver, feed the before and after build logs to
> linux-log-diff. That way you won't miss the single new warning you've
> just introduced.
>=20
> https://github.com/geertu/linux-scripts

Yep, nice stuff: linux-log-summary does nicely summarize it all like
this here:

=2E..
include/linux/kernel.h:120:19: warning: cast from function call of type=
 =E2=80=98void *=E2=80=99 to non-matching type =E2=80=98long unsigned i=
nt=E2=80=99 [-Wbad-function-cast]: 40 warnings in 1 logs
include/linux/kernel.h:67:27: warning: conversion to =E2=80=98int=E2=80=
=99 from =E2=80=98long unsigned int=E2=80=99 may alter its value [-Wcon=
version]: 2 warnings in 1 logs
include/linux/kernel.h:67:33: warning: conversion to =E2=80=98long unsi=
gned int=E2=80=99 from =E2=80=98int=E2=80=99 may change the sign of the=
 result [-Wsign-conversion]: 3 warnings in 1 logs
=2E..

which I ran on a file built with W=3D123.

So I'd say everything needed is there to massage those build logs.

Thanks.

--=20
Regards/Gruss,
    Boris.
--
