From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 6/6] build: replace *_EXTRA_OBJS by local assignments to
 LDFLAGS and LOADLIBES
Date: Fri, 6 Oct 2017 12:19:15 -0700
Message-ID: <CANeU7Q=Ucf62ZXCNo8JuYooXpPmtESentW1XwpW4XU8OymZ66Q@mail.gmail.com>
References: <20171004132605.24734-1-uwe@kleine-koenig.org> <20171004132605.24734-7-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37161 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751980AbdJFTTR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 6 Oct 2017 15:19:17 -0400
Received: by mail-qt0-f193.google.com with SMTP id 32so8769422qtp.4
        for <linux-sparse@vger.kernel.org>; Fri, 06 Oct 2017 12:19:16 -0700 (PDT)
In-Reply-To: <20171004132605.24734-7-uwe@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Oct 4, 2017 at 6:26 AM, Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.or=
g> wrote:
> ---
>  Makefile | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index f6c577c02143..50e7b99b6107 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -62,8 +62,8 @@ INST_MAN1=3Dsparse.1 cgcc.1
>  ifeq ($(HAVE_LIBXML),yes)
>  PROGRAMS+=3Dc2xml
>  INST_PROGRAMS+=3Dc2xml
> -c2xml_EXTRA_OBJS =3D `$(PKG_CONFIG) --libs libxml-2.0`
> -LIBXML_CFLAGS :=3D $(shell $(PKG_CONFIG) --cflags libxml-2.0)
> +c2xml: LOADLIBES +=3D $(shell $(PKG_CONFIG) --libs libxml-2.0)
> +c2xml: CFLAGS +=3D $(shell $(PKG_CONFIG) --cflags libxml-2.0)


This is by design.

The problem with target specific variable is that, you can't easily
access it out side of the target specific scope.

For example in the debug target branch, it go through a loop
to process all objects, including the extra objects. You can't do that if
you use target specific variables.

 $(foreach @F,$(PROGRAMS),$(eval $(@F): $(EXTRA_OBJS) $(LIBS)))
-$(foreach @F,$(PROGRAMS),$(eval debug/$(@F): $(addprefix debug/,
$(EXTRA_OBJS)) $(DBG_LIBS)))
+$(foreach @F,$(PROGRAMS),$(eval dbgbuild/$(@F): $(addprefix
dbgbuild/, $(EXTRA_OBJS)) $(DBG_LIBS)))

Chris
