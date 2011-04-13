From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 2/3] build: add an all-installable target that builds the
 targets to install.
Date: Wed, 13 Apr 2011 11:34:04 -0700
Message-ID: <20110413183404.GB2090@feather>
References: <1302692766-30217-1-git-send-email-flameeyes@gmail.com>
 <1302692766-30217-2-git-send-email-flameeyes@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:48365 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756925Ab1DMSee convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 13 Apr 2011 14:34:34 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id 11C3F386D3
	for <linux-sparse@vger.kernel.org>; Wed, 13 Apr 2011 20:34:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1302692766-30217-2-git-send-email-flameeyes@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Diego Elio =?iso-8859-1?Q?Petten=F2?= <flameeyes@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Apr 13, 2011 at 01:06:05PM +0200, Diego Elio Petten=F2 wrote:
> This is useful for distributions that don't want to build content tha=
t
> won't be installed.
> ---
>  Makefile |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index e08143a..ffb513f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -118,7 +118,9 @@ SED_PC_CMD =3D 's|@version@|$(VERSION)|g;		\
> =20
>  all: $(PROGRAMS) sparse.pc
> =20
> -install: $(INST_PROGRAMS) $(LIBS) $(LIB_H) sparse.pc
> +all-installable: $(INST_PROGRAMS) $(LIBS) $(LIB_H) sparse.pc
> +
> +install: all-installable
>  	$(Q)install -d $(DESTDIR)$(BINDIR)
>  	$(Q)install -d $(DESTDIR)$(LIBDIR)
>  	$(Q)install -d $(DESTDIR)$(MAN1DIR)

Why not just "make install" instead?  You don't have to separately make
and make install; make install will build all the installed programs an=
d
then install them.

- Josh Triplett
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
