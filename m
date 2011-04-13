From: Diego Elio =?ISO-8859-1?Q?Petten=F2?= <flameeyes@gmail.com>
Subject: Re: sparse, gcc 4.6 and a few build changes
Date: Wed, 13 Apr 2011 13:06:02 +0200
Message-ID: <1302692762.15959.50.camel@raven.home.flameeyes.eu>
References: <1302226355.2407.7.camel@raven.home.flameeyes.eu>
	 <BANLkTinOwWW0T6D+oFiNakXrc8SbpgqcpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59640 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756965Ab1DMLF6 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 13 Apr 2011 07:05:58 -0400
Received: by wya21 with SMTP id 21so383352wya.19
        for <linux-sparse@vger.kernel.org>; Wed, 13 Apr 2011 04:05:56 -0700 (PDT)
In-Reply-To: <BANLkTinOwWW0T6D+oFiNakXrc8SbpgqcpQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Chris,

Il giorno mer, 13/04/2011 alle 01.53 -0700, Christopher Li ha scritto:
> The series looks good except the CFLAGS over ride change.
>=20
> The CFLAGS obvious have two parts. Some of it can be savely
> overwrite. Some of shouldn't be overwrite otherwise sparse can't
> compile correctly.

Yes I know =E2=80=94 that's why I used the "?=3D" setter: if CFLAGS is =
set in the
environment, it'll be used instead of the "CFLAGS ?=3D" line; all the +=
=3D
lines will be maintained instead. This does obviously not work if you
use "make CFLAGS=3D$something".

> I think it'd better seperate out the overwrite part of CFLAGS with
> the rest of CFLAGS, just like the git makefile.

I don't know much the git Makefiles, but I'll look into it; in the mean
time the other three patches should work fine by themselves.

> Some thing like the patch I attached. You might need to make some
> changes to merge with your branch.

Attachment is missing ;)

> Can you rebase your series on the sparse chrisl branch?
> http://git.kernel.org/?p=3Ddevel/sparse/chrisl/sparse.git;a=3Dsummary

It looks like no changes are needed for that at least, I'll send the
remaining three patches for now then.

--=20
Diego Elio Petten=C3=B2 =E2=80=94 Flameeyes
http://blog.flameeyes.eu/

--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
