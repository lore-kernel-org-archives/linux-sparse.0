From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 4/5] Fix some "plain integer as NULL pointer" warnings on
	cygwin
Date: Mon, 20 Jul 2009 13:31:20 -0700
Message-ID: <70318cbf0907201331v1c830779i89c9bef9d6706115@mail.gmail.com>
References: <4A623766.5020002@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f202.google.com ([209.85.212.202]:63295 "EHLO
	mail-vw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184AbZGTUbW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 20 Jul 2009 16:31:22 -0400
Received: by vwj40 with SMTP id 40so416225vwj.33
        for <linux-sparse@vger.kernel.org>; Mon, 20 Jul 2009 13:31:21 -0700 (PDT)
In-Reply-To: <4A623766.5020002@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sat, Jul 18, 2009 at 1:58 PM, Ramsay Jones<ramsay@ramsay1.demon.co.u=
k> wrote:
>
> These sparse warnings are caused by broken new-lib headers,
> which sometimes result in NULL being defined as 0, and at
> other times defined as ((void *)0).
>
> In essence, the only header which works correctly (by defining
> NULL as ((void *)0)) is stddef.h. The stdio.h and time.h headers
> also work, almost by accident, by indirectly including stddef.h.
> The other standard headers which are required to define the NULL
> macro, namely locale.h, stdlib.h, string.h and wchar.h, all
> define the macro as the 0 token. (This is a slightly simplified
> description of the problem).
>
> In order to suppress these warnings, include the stddef.h header
> at the start of ptrlist.c.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>
> Hi Chris,
>
> $ cat -n null-test.sh
> =A0 =A0 1 =A0#!/bin/bash
> =A0 =A0 2
> =A0 =A0 3 =A0# The C99 standard says that the following headers defin=
e NULL:
> =A0 =A0 4 =A0# =A0 locale.h (7.11), stddef.h (7.17), stdio.h (7.19.1)=
,
> =A0 =A0 5 =A0# =A0 stdlib.h (7.20), string.h (7.21.1), time.h (7.23.1=
),
> =A0 =A0 6 =A0# =A0 wchar.h (7.24.1).
> =A0 =A0 7
> =A0 =A0 8 =A0for i in locale.h stddef.h stdio.h stdlib.h string.h tim=
e.h wchar.h
> =A0 =A0 9 =A0do
> =A0 =A010 =A0 =A0 =A0 =A0 =A0printf "%10s: =A0" $i
> =A0 =A011 =A0 =A0 =A0 =A0 =A0printf "#include<%s>\nchar *xyz_ptr =3D =
NULL;\n" $i >t.c
> =A0 =A012 =A0 =A0 =A0 =A0 =A0cgcc -E t.c | grep xyz_ptr
> =A0 =A013 =A0done
> =A0 =A014 =A0rm t.c
> =A0 =A015
> $ ./null-test.sh

That is what I get in FC11:
  locale.h:  char *xyz_ptr =3D ((void *)0);
  stddef.h:  char *xyz_ptr =3D ((void *)0);
   stdio.h:  char *xyz_ptr =3D ((void *)0);
  stdlib.h:  char *xyz_ptr =3D ((void *)0);
  string.h:  char *xyz_ptr =3D ((void *)0);
    time.h:  char *xyz_ptr =3D ((void *)0);
   wchar.h:  char *xyz_ptr =3D ((void *)0);

Which system has this problem?

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
