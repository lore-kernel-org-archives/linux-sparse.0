From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: [PATCH] add warnings enum-to-int and int-to-enum
Date: Wed, 2 Sep 2009 20:04:42 +0200
Message-ID: <200909022004.42548.kdudka@redhat.com>
References: <20090830153202.4dc5c58c@s6510> <20090901172708.286657ec@nehalam> <alpine.LNX.2.00.0909021313190.28290@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:25330 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670AbZIBSFn (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 2 Sep 2009 14:05:43 -0400
In-Reply-To: <alpine.LNX.2.00.0909021313190.28290@iabervon.org>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
Cc: Stephen Hemminger <shemminger@vyatta.com>, Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org

On Wednesday 02 of September 2009 19:56:47 Daniel Barkalow wrote:
> It feels to me like the explicit numeric values are what make these
> constants sensible to use directly as ints, and that it's only sensible to
> use a non-constant value of an enum type as an int (without an explicit
> cast) if all of the enum values have explicit numeric values.
>
> I think:
>
>   enum {
>     my_register_zero
>     ...
>     my_register_twdr
>     my_register_twcr
>     ...
>   };
>
>   void () {
>     write_register(my_register_twdr, SETUP_TWDR);
>   }
>
> is asking for trouble in a way that this warning is about.

Both examples are too abstract for me -- missing declaration
of write_register(), etc. Please attach a minimal example as a file which I 
can compile and test. I'll check if the "trouble" is covered by the warnings 
or not, and perhaps implement what's missing. Thanks in advance!

Kamil
