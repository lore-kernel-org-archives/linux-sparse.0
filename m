From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Subject: Re: [PATCH] sparse: gcc 4.1 warnings
Date: Tue, 11 Apr 2006 11:19:09 +0200
Message-ID: <20060411091908.GC11643@wohnheim.fh-wedel.de>
References: <20060408041419.GA8943@havoc.gtf.org> <20060410132157.4AF15C000E2@dunnock.rentec.com> <443AF8A4.2090007@garzik.org> <20060411085602.GA11643@wohnheim.fh-wedel.de> <20060411091044.GA4359@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:47791 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932381AbWDKJTv (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 11 Apr 2006 05:19:51 -0400
Content-Disposition: inline
In-Reply-To: <20060411091044.GA4359@taniwha.stupidest.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Chris Wedgwood <cw@f00f.org>
Cc: Jeff Garzik <jeff@garzik.org>, Morten Welinder <terra@gnome.org>, linux-sparse@vger.kernel.org

On Tue, 11 April 2006 02:10:44 -0700, Chris Wedgwood wrote:
> On Tue, Apr 11, 2006 at 10:56:02AM +0200, J?rn Engel wrote:
>=20
> > And yes, this is really obnoxious.  I have read code before that
> > constantly does
> > 	(void) this(...);
> > 	(void) that(...);
> > and didn't like it much.  Ignoring the issue and fixing the code
> > checker instead might be a better idea.
>=20
> why not leave it just as it is?
>=20
> making code ugly and unreadable because some random very of gcc is
> being stilly doesn't seem ideal

Absolutely!

J=F6rn

--=20
You can't tell where a program is going to spend its time. Bottlenecks
occur in surprising places, so don't try to second guess and put in a
speed hack until you've proven that's where the bottleneck is.
-- Rob Pike
