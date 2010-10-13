From: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Subject: Re: including sparse headers in C++ code
Date: Wed, 13 Oct 2010 13:39:53 +0200
Message-ID: <1286969993.14103.38.camel@thorin>
References: <AANLkTinGSRQYqR2h+V0nAB+vn4xWCGxgbmGHuMm-xHyB@mail.gmail.com>
	 <20101009205930.GA4684@feather>
	 <AANLkTinaDZZmyeaK+rAvLCdZ-90n17WhABRsZGUBBcSH@mail.gmail.com>
	 <AANLkTi=8EkK+_9pOA8fbDgYGfz-bPGj6XhLUnfSkdGeV@mail.gmail.com>
	 <20101011224656.GN19804@ZenIV.linux.org.uk>
	 <AANLkTinWYFf0CqBt9FJ9QyeGCU6754GotQM06U4vMqRa@mail.gmail.com>
	 <AANLkTimdy9TwwSJM=rwTjXdRsnove6A2b0=d4M_dOin0@mail.gmail.com>
	 <AANLkTimhh3zj8kgvaSQq9_CS711mLw8skrWL4yUgvJzT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:4726 "EHLO
	esgaroth.petrovitsch.priv.at" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753609Ab0JMLkF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 13 Oct 2010 07:40:05 -0400
In-Reply-To: <AANLkTimhh3zj8kgvaSQq9_CS711mLw8skrWL4yUgvJzT@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Tomas Klacko <tomas.klacko@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org

On Die, 2010-10-12 at 17:37 -0700, Christopher Li wrote:
[...] 
> > However, I can probably try doing:
> > struct symbol
> > {
> > ...
> > #ifndef __cplusplus
> >  enum namespace namespace;
> > #else
> >  enum name_space ns;
> > #endif
> 
> Even worse.

FullACK. That's IMHO the worst solution - sprinkling "#ifndef
__cplusplus" all over the place.

> I don't like the #ifndef __cplusplus at all. Try to keep it minimal.
> Just make it "enum name_space ns;" is clear better than maintain two
> different names.

*eg*
----  snip  ----
#ifdef __cplusplus 
#define namespace ns
#endif
----  snip  ----
at the top would be simpler and keep the source readable. Nevertheless I
wouldn't do it either.

[...] 
> > +#ifdef __cplusplus
> > +extern "C" {
> > +#endif
> 
> Can you move this into your C++ code before including the sparse headers?
> I don't want it in the sparse headers. Sparse is compiled in C,
> shouldn't need to know
> C++ at all.

That is something common in .h files if they are intended for "mixed
use" and C libs use in C++ applications.

[...] 
> > +#ifdef __cplusplus
> > +}
> > +#endif
> > +
[...]

Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
                     LUGA : http://www.luga.at

