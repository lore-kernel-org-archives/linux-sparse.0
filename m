From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [RFC 3/3] irq: Privatize irq_common_data::state_use_accessors
Date: Tue, 15 Dec 2015 08:56:25 +0800
Message-ID: <20151215005625.GK1072@fixme-laptop.cn.ibm.com>
References: <1449888962-29348-1-git-send-email-boqun.feng@gmail.com>
 <1449888962-29348-4-git-send-email-boqun.feng@gmail.com>
 <20151214095021.GM6357@twins.programming.kicks-ass.net>
 <alpine.DEB.2.11.1512141102470.4336@nanos>
 <20151214120021.GJ1072@fixme-laptop.cn.ibm.com>
 <alpine.DEB.2.11.1512141657430.4336@nanos>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0hHDr/TIsw4o3iPK"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ob0-f196.google.com ([209.85.214.196]:36371 "EHLO
	mail-ob0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932907AbbLOA5A (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 14 Dec 2015 19:57:00 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1512141657430.4336@nanos>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org, Christopher Li <sparse@chrisli.org>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Jiang Liu <jiang.liu@linux.intel.com>, Marc Zyngier <marc.zyngier@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Brian Norris <computersforpeace@gmail.com>


--0hHDr/TIsw4o3iPK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 14, 2015 at 04:59:45PM +0100, Thomas Gleixner wrote:
> On Mon, 14 Dec 2015, Boqun Feng wrote:
> > Probably something like this(untested, only run "make kernel/irq/")?
> >=20
> > Subject: [RFC v2 3/3] irq: Privatize irq_common_data::state_use_accesso=
rs
> >=20
> > According to Peter Zijlstra, irq_common_data::state_use_accessors is not
> > designed for public use. Therefore make it private so that people who
> > write code accessing it directly will get blamed by sparse.
> >=20
> > Also macro __irqd_to_state() is for _designed_ accesses to irq_data's
> > state only, it's better to limit its scope, therefore put all its
> > callers together and #undef it after use.
>=20
> That exposes the set/clr functions to the global header file, while
> today those are restricted to the core internals header. There is a
> reason why I did not make them public ....
>=20

Oops, I wasn't aware of that... then I guess we should define and undef
__irqd_to_state twice, in include/linux/irq.h and in
kernel/irq/internals.h, right?

Regards,
Boqun

--0hHDr/TIsw4o3iPK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWb2UzAAoJEEl56MO1B/q40vEH/R/eD8QUp/rmVcz3UaaveFDJ
iG9zZOzTdH0zLshMqUBzA5H4bfwFAnBZMM40QNcHYiTvGpgjCHss7TmXbG3BFi/9
Y2uOWI+ashuItLjXMdldriubRklty5z2GJki/3eqgrwrUmyU50SfbjI17zEtxn0t
GMZj8sJHMY76x/YLxEY+SEyMH95zplYPPm9826kZeMFWNV0n70ZKnWAL9gbD4dcA
1Qjz5J2DIBA7XxuJ15qg3l4GkLeNmiQd/P69d9f4AONB1rqwVCE4EsUbuj8AHjMt
jFyxfekdRaIb70YlBBKM62DNKUMU4buv3DPGFsGou3mEDROO1xvlZAR/gmHjzrg=
=D/Ip
-----END PGP SIGNATURE-----

--0hHDr/TIsw4o3iPK--
