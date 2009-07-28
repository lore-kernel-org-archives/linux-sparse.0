From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Detect unused header files?
Date: Tue, 28 Jul 2009 23:04:04 +0200
Message-ID: <20090728210404.GA21187@merkur.ravnborg.org>
References: <20090728181803.GA20845@merkur.ravnborg.org> <70318cbf0907281336p47b68b5cg44a3e7206646cb80@mail.gmail.com> <alpine.LFD.2.00.0907281634400.3974@localhost> <70318cbf0907281349k72a71b8fyc10d80992e4b1db9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from pfepb.post.tele.dk ([195.41.46.236]:44477 "EHLO
	pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbZG1VEE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 28 Jul 2009 17:04:04 -0400
Content-Disposition: inline
In-Reply-To: <70318cbf0907281349k72a71b8fyc10d80992e4b1db9@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>, sparse <linux-sparse@vger.kernel.org>

On Tue, Jul 28, 2009 at 01:49:57PM -0700, Christopher Li wrote:
> On Tue, Jul 28, 2009 at 1:36 PM, Robert P. J. Day<rpjday@crashcourse.=
ca> wrote:
> > sure you can. =A0no one should be counting on the inclusion of head=
er
> > files by other header files (except possibly in unusual situations,
> > which i can't even think of at the moment). =A0if your program need=
s the
> > contents of a header file, it's your responsibility to include it.
>=20
> The case I have in mind is that, some API level header file include s=
ome
> internal header file for constant defines. For example:
>=20
> drivers/ieee1394/host.h include drivers/ieee1394/csr.h.
>=20
> The "csr.h" is just the register define. It is not used in this heade=
r file
> itself. I did not check very closely, for augments sake pretend those
> inline function are not there. It just have register defines.
>=20
> Should the C program changed to include "csr.h" directly? I don't thi=
nk so.

Agreed on this one.

So we should add some intelligence when we 'fix' these warnings.
This is sometimes causing us troubles.

I need to see the results before I can judge if this will
be a big issue.

The first challenge will anyway to make all the header files self conta=
ined.

	Sam
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
