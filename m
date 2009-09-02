From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] add warnings enum-to-int and int-to-enum
Date: Wed, 2 Sep 2009 13:56:47 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0909021313190.28290@iabervon.org>
References: <20090830153202.4dc5c58c@s6510> <200908312104.54990.kdudka@redhat.com> <20090831205353.GA6239@josh-work.beaverton.ibm.com> <200909012359.09678.kdudka@redhat.com> <20090901232433.GC3947@josh-work.beaverton.ibm.com>
 <20090901172708.286657ec@nehalam>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from iabervon.org ([66.92.72.58]:60315 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752407AbZIBR4p (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 2 Sep 2009 13:56:45 -0400
In-Reply-To: <20090901172708.286657ec@nehalam>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: Josh Triplett <josh@joshtriplett.org>, Kamil Dudka <kdudka@redhat.com>, linux-sparse@vger.kernel.org

On Tue, 1 Sep 2009, Stephen Hemminger wrote:

> there is lots of code that does:
> 
> enum {
>    my_register_1   = 0x001,
>    my_register_2   = 0x002,
> };

It feels to me like the explicit numeric values are what make these 
constants sensible to use directly as ints, and that it's only sensible to 
use a non-constant value of an enum type as an int (without an explicit 
cast) if all of the enum values have explicit numeric values.

I think:

  enum {
    my_register_zero
    ...
    my_register_twdr
    my_register_twcr
    ...
  };

  void () {
    write_register(my_register_twdr, SETUP_TWDR);
  }

is asking for trouble in a way that this warning is about.

	-Daniel
*This .sig left intentionally blank*
