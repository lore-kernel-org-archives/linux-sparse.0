From: =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
Subject: Re: Hard-coded gcc header path
Date: Tue, 11 Nov 2008 15:15:29 +0100
Message-ID: <20081111141459.GB25986@logfs.org>
References: <20081111135816.GA25986@logfs.org> <1226412106.4478.5.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lazybastard.de ([212.112.238.170]:56529 "EHLO
	longford.logfs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756728AbYKKOPo (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 11 Nov 2008 09:15:44 -0500
Content-Disposition: inline
In-Reply-To: <1226412106.4478.5.camel@johannes.berg>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-sparse@vger.kernel.org, 505177@bugs.debian.org

On Tue, 11 November 2008 15:01:46 +0100, Johannes Berg wrote:
>=20
> Well, sort of. The patch is actually determined at sparse build time,=
 so
> right now sparse requires you to build it against the same compiler t=
hat
> you are currently using. If you rebuild sparse with your shiny new
> compiler you'll notice that it'll end up with a different path in
> pre-process.h.

Then the short-term solution for debian is clear.  Simply rebuild the
package and add a dependency on a specific gcc version.

J=C3=B6rn

--=20
=46antasy is more important than knowledge. Knowledge is limited,
while fantasy embraces the whole world.
-- Albert Einstein
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
