From: Bernd Petrovitsch <bernd@sysprog.at>
Subject: Re: including sparse headers in C++ code
Date: Wed, 20 Oct 2010 11:39:04 +0200
Message-ID: <1287567544.7542.7.camel@thorin>
References: <AANLkTinGSRQYqR2h+V0nAB+vn4xWCGxgbmGHuMm-xHyB@mail.gmail.com>
	 <AANLkTinaDZZmyeaK+rAvLCdZ-90n17WhABRsZGUBBcSH@mail.gmail.com>
	 <1286710919.24953.2.camel@thorin> <201010101352.10864.kdudka@redhat.com>
	 <1286790249.24953.14.camel@thorin>
	 <AANLkTin00gg79Zdg1JJgaaK+2wzgu9Xpr719MYOebQ+J@mail.gmail.com>
	 <20101011191219.GD8537@feather> <1286981110.14103.86.camel@thorin>
	 <20101020072945.GA3232@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:2692 "EHLO
	esgaroth.petrovitsch.priv.at" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751003Ab0JTJj2 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 20 Oct 2010 05:39:28 -0400
In-Reply-To: <20101020072945.GA3232@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, Al Viro <viro@ZenIV.linux.org.uk>
Cc: Kamil Dudka <kdudka@redhat.com>, Tomas Klacko <tomas.klacko@gmail.com>, linux-sparse@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>

On Mit, 2010-10-20 at 08:29 +0100, Al Viro wrote: 
> On Wed, Oct 13, 2010 at 04:45:10PM +0200, Bernd Petrovitsch wrote:
> 
> > rename the local variables "true" and "false" to "if_true" and "if_false",
> > respectively to not clash with the well-known "keywords" defined by C99.
> > This is similar to commit 0be55c9.
> 
> These are not keywords...  Said that, things like

ACK, that's why "keywords" is quoted above.

> if (!cond->value)
>                         true = false;
>                 if (!true)
>                         true = cond;
> certainly reek of IOCCC.  I'd rather avoid "if_true" as replacement, though.
> If anything, true_expr and false_expr would make more sense.

I have no strong feelings about the replacement and just followed the
change in the referenced commit.
Chris, should I respin the patch with *_expr?

Bernd
-- 
mobile: +43 664 4416156              http://www.sysprog.at/
    Linux Software Development, Consulting and Services

