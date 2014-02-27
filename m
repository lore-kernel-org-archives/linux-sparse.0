From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH V2] sparse: Allow override of sizeof(bool) warning
Date: Thu, 27 Feb 2014 17:01:12 +0100
Message-ID: <20140227160112.GG18191@pd.tnic>
References: <20140227022857.GC23659@thin>
 <1393469594.24588.71.camel@joe-AO722>
 <20140227025845.GA25145@thin>
 <530EB103.5070406@zytor.com>
 <1393472326.24588.82.camel@joe-AO722>
 <60797a1a-1a83-468e-9629-abf4e8712d65@email.android.com>
 <20140227082529.GA18210@pd.tnic>
 <dbc47544-a6f6-4ab4-80b0-25d93a1666e2@email.android.com>
 <20140227152435.GA7982@thunk.org>
 <530F5E53.5070208@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:37102 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753076AbaB0QBT (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 27 Feb 2014 11:01:19 -0500
Content-Disposition: inline
In-Reply-To: <530F5E53.5070208@zytor.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Joe Perches <joe@perches.com>, Ben Pfaff <blp@nicira.com>, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Feb 27, 2014 at 07:48:35AM -0800, H. Peter Anvin wrote:
> No, but I think we can certainly make a list... a lot of it right now
> sits in various people's heads.
> 
> Here are a couple:
> 
> - Bytes are 8 bits
> - Signed integers will be 2's complement
> - sizeof char, short, int, long, and long long will be 1, 2, 4, 4, 8 or
		^					   ^
	       bool, 					  ,1 ,


>   1, 2, 4, 8, 8 on 32- and 64-bit processors, respectively.
> - sizeof(long) == sizeof(void *)
> - NULL is represented by all zero
> - Structures will not add padding as long as all the members are
>   naturally aligned.
> 
> Someone want to set up a collaborative document of some kind and collect
> more?

https://wiki.kernel.org/ but I hear spammers love it.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
