From: Bernd Petrovitsch <bernd@sysprog.at>
Subject: Re: including sparse headers in C++ code
Date: Wed, 10 Nov 2010 11:52:17 +0100
Message-ID: <1289386337.2606.0.camel@thorin>
References: <AANLkTinGSRQYqR2h+V0nAB+vn4xWCGxgbmGHuMm-xHyB@mail.gmail.com>
	 <AANLkTinaDZZmyeaK+rAvLCdZ-90n17WhABRsZGUBBcSH@mail.gmail.com>
	 <1286710919.24953.2.camel@thorin> <201010101352.10864.kdudka@redhat.com>
	 <1286790249.24953.14.camel@thorin>
	 <AANLkTin00gg79Zdg1JJgaaK+2wzgu9Xpr719MYOebQ+J@mail.gmail.com>
	 <20101011191219.GD8537@feather> <1286981110.14103.86.camel@thorin>
	 <20101020072945.GA3232@ZenIV.linux.org.uk> <1287567544.7542.7.camel@thorin>
	 <AANLkTikBMpuwHZpAsSmcP_5MC3GJQNZE3SrRT6VQ8boS@mail.gmail.com>
	 <1288358560.7795.34.camel@thorin>
	 <AANLkTinmmLf9dMvLfWk09kGV6RbEo9HMV8ds=yGEQyMw@mail.gmail.com>
	 <1289309285.14246.16.camel@thorin>
	 <AANLkTi=Z2J24+ECrLFDY6PQZOi04C1ecLPvhorbSUut4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:5106 "EHLO
	esgaroth.petrovitsch.priv.at" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751041Ab0KJKwm (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 10 Nov 2010 05:52:42 -0500
In-Reply-To: <AANLkTi=Z2J24+ECrLFDY6PQZOi04C1ecLPvhorbSUut4@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Kamil Dudka <kdudka@redhat.com>, Tomas Klacko <tomas.klacko@gmail.com>, linux-sparse@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>

On Die, 2010-11-09 at 14:52 -0800, Christopher Li wrote: 
> On Tue, Nov 9, 2010 at 5:28 AM, Bernd Petrovitsch <bernd@sysprog.at> wrote:
> > Frankly, I don't understand what you mean (especially with the pseudo_t)
> > - which also explains why the suboptimal variable naming and I cannot
> > come up with a better name.
> 
> Oh, sorry for the confusion. I mean the you can use some thing like:
> true_pseudo and
> false_pseudo instead of calling it expressions. Pseduo is not an expression.
> 
> I will make that adjustment for you and post the patch on the list. If Al don't
> complain I will submit it. All right?

Yes, please.
Signed-off-by: Bernd Petrovitsch <bernd@sysprog.at>

Bernd
-- 
mobile: +43 664 4416156              http://www.sysprog.at/
    Linux Software Development, Consulting and Services

