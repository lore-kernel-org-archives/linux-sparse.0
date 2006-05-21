From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Subject: Re: [PATCH] let sparse warn on &inline_function
Date: Sun, 21 May 2006 21:37:09 +0200
Message-ID: <20060521193709.GA22520@wohnheim.fh-wedel.de>
References: <200605201621.48466.mb@bu3sch.de> <446F3149.4060606@knosof.co.uk> <200605201734.40756.mb@bu3sch.de> <446F3B91.6020709@knosof.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:25303 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S964921AbWEUTiE (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 21 May 2006 15:38:04 -0400
Content-Disposition: inline
In-Reply-To: <446F3B91.6020709@knosof.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Derek M Jones <derek@knosof.co.uk>
Cc: Michael Buesch <mb@bu3sch.de>, linux-sparse@vger.kernel.org

On Sat, 20 May 2006 16:53:53 +0100, Derek M Jones wrote:
>=20
> >The whole purpose of sparse is to warn on things that are
> >not invalid to do, but don't make much sense. ;)
> >It simply does not really make sense to mark something
> >as "inline" and take pointers to it.
>=20
> It makes perfect sense for me to want 'direct' calls to be
> inlined and be willing to accept that calls via pointers
> will not be inlined.

Does this still make sense with CONFIG_CC_OPTIMIZE_FOR_SIZE set?

Imo this warning has a fair chance of catching things the developer
did not intend to write.  How to deal with things afterwards should -
as always - be up to the developer.

J=F6rn

--=20
Why do musicians compose symphonies and poets write poems?
They do it because life wouldn't have any meaning for them if they didn=
't.
That's why I draw cartoons.  It's my life.
-- Charles Shultz
