From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/3] build: allow easy override of GCC_BASE
Date: Thu, 14 Apr 2011 02:59:38 -0700
Message-ID: <BANLkTinpDncAMG=CAXp0iKG7uuVKRw=eWA@mail.gmail.com>
References: <1302692766-30217-1-git-send-email-flameeyes@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59463 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757056Ab1DNJ7k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 14 Apr 2011 05:59:40 -0400
Received: by vws1 with SMTP id 1so1146807vws.19
        for <linux-sparse@vger.kernel.org>; Thu, 14 Apr 2011 02:59:39 -0700 (PDT)
In-Reply-To: <1302692766-30217-1-git-send-email-flameeyes@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?ISO-8859-1?Q?Diego_Elio_Petten=F2?= <flameeyes@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Will apply.

Chris

On Wed, Apr 13, 2011 at 4:06 AM, Diego Elio Petten=F2 <flameeyes@gmail.=
com> wrote:
> Sometimes gcc reports the wrong path for its own base (for instance w=
hen
> ICC is present in the same system); by allowing an override of GCC_BA=
SE in
> Makefile, it's easier for packages to fix this up.
> ---
> =A0Makefile | =A0 =A03 ++-
> =A01 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index cc6176f..e08143a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -21,7 +21,8 @@ HAVE_GCC_DEP:=3D$(shell touch .gcc-test.c && =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0echo 'yes'; rm -f .gcc-test.d .gcc-tes=
t.o .gcc-test.c)
> =A0HAVE_GTK2:=3D$(shell pkg-config --exists gtk+-2.0 2>/dev/null && e=
cho 'yes')
>
> -CFLAGS +=3D -DGCC_BASE=3D\"$(shell $(CC) --print-file-name=3D)\"
> +GCC_BASE =3D $(shell $(CC) --print-file-name=3D)
> +CFLAGS +=3D -DGCC_BASE=3D\"$(GCC_BASE)\"
>
> =A0ifeq ($(HAVE_GCC_DEP),yes)
> =A0CFLAGS +=3D -Wp,-MD,$(@D)/.$(@F).d
> --
> 1.7.5.rc1
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
