From: Bernd Petrovitsch <bernd@sysprog.at>
Subject: Re: modifier_string() inconsistency with modifiers
Date: Sun, 22 Aug 2010 10:42:19 +0200
Message-ID: <1282466539.5200.1.camel@thorin>
References: <1282300429.10440.230.camel@thorin>
	 <AANLkTikugbBQ1gYVAdFRxWVmEX-odjq+Y5wA4mnN7Vnj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:1905 "EHLO
	esgaroth.petrovitsch.priv.at" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751605Ab0HVImZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 22 Aug 2010 04:42:25 -0400
In-Reply-To: <AANLkTikugbBQ1gYVAdFRxWVmEX-odjq+Y5wA4mnN7Vnj@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On Fre, 2010-08-20 at 16:03 -0700, Christopher Li wrote:
> On Fri, Aug 20, 2010 at 3:33 AM, Bernd Petrovitsch <bernd@sysprog.at> wrote:
> >
> > Well, the equivalent for "MOD_WEAK" is "[structof]" - which seems wrong
> > to me.
> > And the parts for "inline" also doesn't fit AFAICS.
> >
> > What did I actually miss?
> 
> Nothing. We remove some bits from the modifier but forget to update
> the modifier_string function.
> 
> Care for a patch?

Not a big problem.
Hmm, is it prudent to use c99, e.g. for named initializers und array?

	Bernd
-- 
mobile: +43 664 4416156              http://www.sysprog.at/
    Linux Software Development, Consulting and Services

