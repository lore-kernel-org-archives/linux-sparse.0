From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Re: error, types differ in signedness
Date: Mon, 05 Feb 2007 20:12:55 -0500
Message-ID: <20070205201255.j8kk0w80gsggo4oo@webmail.spamcop.net>
References: <20070205105420.6f19a57d.rdunlap@xenotime.net>
	<20070205200617.GA14964@chrisli.org> <1170714431.1453.10.camel@dv>
	<20070206001622.GB14964@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mailgate.cesmail.net ([216.154.195.36]:39290 "HELO
	mailgate.cesmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965431AbXBFBTg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 5 Feb 2007 20:19:36 -0500
In-Reply-To: <20070206001622.GB14964@chrisli.org>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-sparse@vger.kernel.org

Quoting Christopher Li <sparse@chrisli.org>:

> > I would prefer that sparse emits a specific warning about function vs
> > function pointer mismatch.  Even if it doesn't matter, it makes the code
> > easier to read and safer to modify.
>
> I did not find a easy way to do it yet.

I see.  I thought it was easy.  Then your patch is fine for me.  It's better to
have no warning than a misleading warning about a stylistic issue.

--
Regards,
Pavel Roskin
