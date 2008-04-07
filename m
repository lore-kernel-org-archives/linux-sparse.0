From: Pavel Roskin <proski@gnu.org>
Subject: Re: rewrite_parent_branch: Assertion `changed' failed
Date: Mon, 07 Apr 2008 17:22:19 -0400
Message-ID: <1207603339.22430.48.camel@dv>
References: <47FA6DAF.3030600@gmail.com>  <47FA708D.5080203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:56818 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752719AbYDGVWW (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 7 Apr 2008 17:22:22 -0400
In-Reply-To: <47FA708D.5080203@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Mon, 2008-04-07 at 21:05 +0200, Jiri Slaby wrote:
> On 04/07/2008 08:53 PM, Jiri Slaby wrote:
> > Hi,
> >=20
> > I got this from sparse:
> >  CHECK   /home/l/latest/xxx/net/mac80211/ieee80211.c
> > sparse: flow.c:804: rewrite_parent_branch: Assertion `changed' fail=
ed.
> > /bin/sh: line 1:  8639 Ne=FAsp=EC=B9n=EC ukon=E8en (SIGABRT)       =
 sparse

That's "unsuccessful finish", for those less knowledgeable in Slavic
languages :-)

> It's 2.6.25-rc8-mm1 code. It's opensuse sparse-0.1-46, core from the
> crash is here:
> http://www.fi.muni.cz/~xslaby/sklad/core.sparse.bz2

If it's indeed version 0.1, I strongly suggest that you test the curren=
t
git version, which is version 0.4.1 plus 10 or so patches.

git://git.kernel.org/pub/scm/linux/kernel/git/josh/sparse.git

--=20
Regards,
Pavel Roskin
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
