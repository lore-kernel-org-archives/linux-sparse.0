From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: Spurious symbol 'foo' was not declared
Date: Sun, 18 Jul 2010 13:35:43 -0700
Message-ID: <20100718203542.GA3665@feather>
References: <AANLkTikqtMvb3fdg4aKR1KStEBhg1yDM-0YpR0VGHtiT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:54192 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757252Ab0GRUj3 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 18 Jul 2010 16:39:29 -0400
Received: from mrelay2-v.mgt.gandi.net (relay2-v.mail.gandi.net [217.70.178.76])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id C7AEE84142
	for <linux-sparse@vger.kernel.org>; Sun, 18 Jul 2010 22:36:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTikqtMvb3fdg4aKR1KStEBhg1yDM-0YpR0VGHtiT@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Morten Welinder <mortenw@gnome.org>
Cc: linux-sparse@vger.kernel.org

On Sun, Jul 18, 2010 at 04:16:37PM -0400, Morten Welinder wrote:
> I think sparse issues a spurious warning about "static" for this prog=
ram.
> Right?
>=20
> Morten
>=20
> static void foo (int);
> void foo (int a) { }
>=20
> welinder@anemone:~> cgcc -Wall -c sss.c
> sss.c:2:6: warning: symbol 'foo' was not declared. Should it be stati=
c?
> sss.c:2: warning: =E2=80=98foo=E2=80=99 defined but not used

The second warning comes from gcc, I think.  But yes, the first warning
represents a long-standing sparse bug; "static" in the prototype doesn'=
t
propagate to the definition.

- Josh Triplett
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
