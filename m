From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] build: make PREFIX overwritable on the commandline
Date: Sat, 23 Sep 2017 07:20:27 -0400
Message-ID: <CANeU7QnCU7qfFzRGMC-v=Q5onaJgSUvAqiUWJT0FaKHc_Qp2RQ@mail.gmail.com>
References: <20170922212524.8095-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:50503 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbdIWLU2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 23 Sep 2017 07:20:28 -0400
Received: by mail-yw0-f174.google.com with SMTP id u11so2220367ywh.7
        for <linux-sparse@vger.kernel.org>; Sat, 23 Sep 2017 04:20:28 -0700 (PDT)
In-Reply-To: <20170922212524.8095-1-uwe@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Sep 22, 2017 at 5:25 PM, Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.o=
rg> wrote:
> This way I can just use
>
>         make install PREFIX=3D/usr
>
> on the command line to install sparse into the system.
>
>  DESTDIR=3D
> -PREFIX=3D$(HOME)
> +PREFIX ?=3D $(HOME)

Are you sure you need this patch to use "make install PREFIX=3D/usr" ?

Variable that assign from the command line will ignore other normal assignm=
ent.
You need to use override to assign to command line variables.

This patch can show it:
diff --git a/Makefile b/Makefile
index a4653aa1..868e7816 100644
--- a/Makefile
+++ b/Makefile
@@ -55,6 +55,7 @@ endif

 DESTDIR=3D
 PREFIX=3D$(HOME)
+$(info prefix origin: $(origin PREFIX) value: $(PREFIX))
 BINDIR=3D$(PREFIX)/bin
 LIBDIR=3D$(PREFIX)/lib
 MANDIR=3D$(PREFIX)/share/man


When I invoke with PREFIX=3D/usr/local/

$ make PREFIX=3D/usr/local/ clean
prefix origin: command line value: /usr/local/

So your patch is not needed.

Chris
