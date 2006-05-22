From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Subject: Re: [PATCH] let sparse warn on &inline_function
Date: Mon, 22 May 2006 10:36:51 +0200
Message-ID: <20060522083650.GA19072@wohnheim.fh-wedel.de>
References: <200605201621.48466.mb@bu3sch.de> <446F3149.4060606@knosof.co.uk> <200605201734.40756.mb@bu3sch.de> <446F3B91.6020709@knosof.co.uk> <20060521193709.GA22520@wohnheim.fh-wedel.de> <4470EBB6.6030404@knosof.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:53388 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1750711AbWEVIgv (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 May 2006 04:36:51 -0400
Content-Disposition: inline
In-Reply-To: <4470EBB6.6030404@knosof.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Derek M Jones <derek@knosof.co.uk>
Cc: Michael Buesch <mb@bu3sch.de>, linux-sparse@vger.kernel.org

On Sun, 21 May 2006 23:37:42 +0100, Derek M Jones wrote:
>=20
> >>It makes perfect sense for me to want 'direct' calls to be
> >>inlined and be willing to accept that calls via pointers
> >>will not be inlined.
> >
> >Does this still make sense with CONFIG_CC_OPTIMIZE_FOR_SIZE set?
>=20
> Using the inline specifier may or may not make sense in this case.

And this is exactly what warnings are all about.  If the code in
question may make sense, but there is a certain likelyhood that it
does not, print a warning.

J=F6rn

--=20
Victory in war is not repetitious.
-- Sun Tzu
