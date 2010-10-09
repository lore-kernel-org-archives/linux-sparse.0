From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: including sparse headers in C++ code
Date: Sat, 9 Oct 2010 13:59:31 -0700
Message-ID: <20101009205930.GA4684@feather>
References: <AANLkTinGSRQYqR2h+V0nAB+vn4xWCGxgbmGHuMm-xHyB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:46142 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757202Ab0JIVAF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 9 Oct 2010 17:00:05 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id AB059861F5
	for <linux-sparse@vger.kernel.org>; Sat,  9 Oct 2010 23:00:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTinGSRQYqR2h+V0nAB+vn4xWCGxgbmGHuMm-xHyB@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Tomas Klacko <tomas.klacko@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Sat, Oct 09, 2010 at 06:40:26PM +0200, Tomas Klacko wrote:
> I am including sparse headers in a C++ code,
> but this does not work because of the use of keywords
> like new and namespace, (and retyping).
> 
> What is your stance on this?
> I mean, would you accept a patch or is there
> some other way which I have missed?

It seems reasonable to avoid the use of C++ keywords in Sparse *headers*
(though unnecessary in *source*).  Looks like this will primarily cause
pain due to "enum namespace" and the various places using it.  Seems
easy enough to change those all to "ns".  "new" mostly seems to get used
as a parameter name or local variable name; for the former we could omit
it, and for the latter we could trivially call it something more
specific like "newlist" or "newptr".

So, I'd tend to guess "patches welcome" (again, for headers only, plus
minimal corresponding source changes when required).  I wouldn't
anticipate other Sparse developers objecting strongly, but if they do
your mail seems like the right way to find out.  The various reasons
given for *not* making the Linux kernel headers compatible don't seem to
apply here, though.

- Josh Triplett
