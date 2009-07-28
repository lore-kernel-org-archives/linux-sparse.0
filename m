From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: Detect unused header files?
Date: Tue, 28 Jul 2009 16:36:38 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0907281634400.3974@localhost>
References: <20090728181803.GA20845@merkur.ravnborg.org> <70318cbf0907281336p47b68b5cg44a3e7206646cb80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1543747825-1248813404=:3974"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from astoria.ccjclearline.com ([64.235.106.9]:50369 "EHLO
	astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841AbZG1UjU (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 28 Jul 2009 16:39:20 -0400
In-Reply-To: <70318cbf0907281336p47b68b5cg44a3e7206646cb80@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, sparse <linux-sparse@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1543747825-1248813404=:3974
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 28 Jul 2009, Christopher Li wrote:

> But a lot of case we have the header file is used in *another*
> file.
>
> >
> > Sample:
> >
> > cat foo.h:
> > #include <linux/types.h>
> > #include <linux/swab.h>
> >
> > struct foo {
> > =A0 =A0 =A0 =A0__u32 bar;
> > =A0 =A0 =A0 =A0__u32 baz;
> > };
> >
> > EOF
> >
> >
> > Here <linux/swab.h> is obviously not used.
> > And I would like sparse to flag this...
>
> I don't think it is can be turn on by default. What if some user
> space program want to include foo.h and use the definitional inside
> "swab.h"? In that case it will be OK. I don't think we can ban this
> kind of the usage case.

  sure you can.  no one should be counting on the inclusion of header
files by other header files (except possibly in unusual situations,
which i can't even think of at the moment).  if your program needs the
contents of a header file, it's your responsibility to include it.

rday
--


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Robert P. J. Day                               Waterloo, Ontario, CANADA

        Linux Consulting, Training and Annoying Kernel Pedantry.

Web page:                                          http://crashcourse.ca
Twitter:                                       http://twitter.com/rpjday
"Kernel Newbie Corner" column @ linux.com:          http://cli.gs/WG6WYX
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--8323328-1543747825-1248813404=:3974--
