From: Pavel Roskin <proski@gnu.org>
Subject: Re: Sparse crash when mixing int and enum in ternary operator
Date: Tue, 09 Mar 2010 15:11:57 -0500
Message-ID: <1268165517.23196.22.camel@mj>
References: <1268097872.16227.10.camel@mj>
	 <201003091446.50092.kdudka@redhat.com> <1268159719.23196.12.camel@mj>
	 <201003092006.23686.kdudka@redhat.com>  <20100309191551.GB4586@feather>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:26922 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754484Ab0CIUL6 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 9 Mar 2010 15:11:58 -0500
In-Reply-To: <20100309191551.GB4586@feather>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Kamil Dudka <kdudka@redhat.com>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

On Tue, 2010-03-09 at 11:15 -0800, Josh Triplett wrote:
> On Tue, Mar 09, 2010 at 08:06:23PM +0100, Kamil Dudka wrote:
> > On Tuesday 09 of March 2010 19:35:19 Pavel Roskin wrote:
> > > I removed the outside conditional, and sparse would still crash on this:
> > >
> > > crypto_has_alg(alg, type, mask ?: CRYPTO_ALG_TYPE_MASK);
> > >
> > > but not on this:
> > >
> > > crypto_has_alg(alg, type, mask ? mask: CRYPTO_ALG_TYPE_MASK);
> > >
> > > Apparently, the "?:" notation is confusing sparse now.
> > 
> > To be frank, I've never seen that notation before.  From what I understand, 
> > the variants above should be equivalent with each other, right?
> 
> Yes, except that the first variant would not evaluate "mask" twice, even
> if it consisted of an expression with side effects.  See
> http://gcc.gnu.org/onlinedocs/gcc/Conditionals.html .
> 
> (When I go to look up something in the GCC manual, more often than not I
> end up in Chapter 6, "Extensions to the C Language Family". :) )

Ironically, the fix for :? may benefit from that operator:

do_warn_for_enum_conversions(expr->cond_true ?: expr->conditional, type);
do_warn_for_enum_conversions(expr->cond_false ?: expr->conditional, type);

At least I was able to run sparse on the whole kernel (wireless-testing,
which is based on 2.6.34-rc1) without crashing or reporting anything
strange.

Actually, omitting the false conditional appears to be invalid.

-- 
Regards,
Pavel Roskin
