From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: Sparse crash when mixing int and enum in ternary operator
Date: Tue, 9 Mar 2010 11:15:52 -0800
Message-ID: <20100309191551.GB4586@feather>
References: <1268097872.16227.10.camel@mj>
 <201003091446.50092.kdudka@redhat.com>
 <1268159719.23196.12.camel@mj>
 <201003092006.23686.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:43465 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209Ab0CITQY (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 9 Mar 2010 14:16:24 -0500
Received: from relay2-v.mail.gandi.net (relay2-v.mail.gandi.net [217.70.178.76])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id ACFA13863F
	for <linux-sparse@vger.kernel.org>; Tue,  9 Mar 2010 20:16:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201003092006.23686.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: Pavel Roskin <proski@gnu.org>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

On Tue, Mar 09, 2010 at 08:06:23PM +0100, Kamil Dudka wrote:
> On Tuesday 09 of March 2010 19:35:19 Pavel Roskin wrote:
> > I removed the outside conditional, and sparse would still crash on this:
> >
> > crypto_has_alg(alg, type, mask ?: CRYPTO_ALG_TYPE_MASK);
> >
> > but not on this:
> >
> > crypto_has_alg(alg, type, mask ? mask: CRYPTO_ALG_TYPE_MASK);
> >
> > Apparently, the "?:" notation is confusing sparse now.
> 
> To be frank, I've never seen that notation before.  From what I understand, 
> the variants above should be equivalent with each other, right?

Yes, except that the first variant would not evaluate "mask" twice, even
if it consisted of an expression with side effects.  See
http://gcc.gnu.org/onlinedocs/gcc/Conditionals.html .

(When I go to look up something in the GCC manual, more often than not I
end up in Chapter 6, "Extensions to the C Language Family". :) )

- Josh Triplett
