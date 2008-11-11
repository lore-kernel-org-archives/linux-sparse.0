From: =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
Subject: Re: Hard-coded gcc header path
Date: Tue, 11 Nov 2008 21:28:49 +0100
Message-ID: <20081111202849.GD25986@logfs.org>
References: <20081111135816.GA25986@logfs.org> <1226412106.4478.5.camel@johannes.berg> <20081111141459.GB25986@logfs.org> <20081111201328.GA10073@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lazybastard.de ([212.112.238.170]:36275 "EHLO
	longford.logfs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbYKKU3B (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 11 Nov 2008 15:29:01 -0500
Content-Disposition: inline
In-Reply-To: <20081111201328.GA10073@artemis.corp>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org, 505177@bugs.debian.org

On Tue, 11 November 2008 21:13:28 +0100, Pierre Habouzit wrote:
> On Tue, Nov 11, 2008 at 02:15:29PM +0000, J=C3=B6rn Engel wrote:
> >=20
> > Then the short-term solution for debian is clear.  Simply rebuild t=
he
> > package and add a dependency on a specific gcc version.
>=20
> Which sucks badly because the default gcc is not always the same on
> every arch, and more importantly, people may want to use different GC=
Cs.
> It would look like a better idea to ask gcc for its include path
> properly.

Maybe not even that.  It is conceivable to want sparse on systems that
don't even have gcc installed.  The BSDs seem to favor pcc lately.  So
the preferred long-term solution would be for sparse to ship its own
headers.

J=C3=B6rn

--=20
To recognize individual spam features you have to try to get into the
mind of the spammer, and frankly I want to spend as little time inside
the minds of spammers as possible.
-- Paul Graham
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
