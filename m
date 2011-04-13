From: Diego Elio =?ISO-8859-1?Q?Petten=F2?= <flameeyes@gmail.com>
Subject: Re: [PATCH 2/3] build: add an all-installable target that builds
 the targets to install.
Date: Wed, 13 Apr 2011 20:35:26 +0200
Message-ID: <1302719726.2295.20.camel@raven.home.flameeyes.eu>
References: <1302692766-30217-1-git-send-email-flameeyes@gmail.com>
	 <1302692766-30217-2-git-send-email-flameeyes@gmail.com>
	 <20110413183404.GB2090@feather>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58853 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756652Ab1DMSfa (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 13 Apr 2011 14:35:30 -0400
Received: by wwa36 with SMTP id 36so1072732wwa.1
        for <linux-sparse@vger.kernel.org>; Wed, 13 Apr 2011 11:35:29 -0700 (PDT)
In-Reply-To: <20110413183404.GB2090@feather>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Il giorno mer, 13/04/2011 alle 11.34 -0700, Josh Triplett ha scritto:
>=20
> Why not just "make install" instead?  You don't have to separately
> make
> and make install; make install will build all the installed programs
> and
> then install them.=20

Most distributions =E2=80=93 including Gentoo =E2=80=93 prefer running =
the steps
separately, adding safety checks between one step and the other.

--=20
Diego Elio Petten=C3=B2 =E2=80=94 Flameeyes
http://blog.flameeyes.eu/

--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
