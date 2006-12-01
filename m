From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: cast truncates bits from constant value (8000000000000000 becomes
 0)
Date: Fri, 1 Dec 2006 12:20:53 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612011215110.3695@woody.osdl.org>
References: <4563D00D.4010704@am.sony.com> <Pine.LNX.4.62.0612011516120.28210@pademelon.sonytel.be>
 <Pine.LNX.4.64.0612010723190.3695@woody.osdl.org> <45705D79.6000107@am.sony.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:27110 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S936545AbWLAUVI (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 1 Dec 2006 15:21:08 -0500
In-Reply-To: <45705D79.6000107@am.sony.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Linux/PPC Development <linuxppc-dev@ozlabs.org>, linux-sparse@vger.kernel.org, Andrew Pinski <Andrew_Pinski@PlayStation.Sony.Com>



On Fri, 1 Dec 2006, Geoff Levand wrote:
> 
> One of the gcc maintainers (Andrew Pinski) told me to set it up that
> way, so I figured it was safe.

It _is_ safe, as long as you stick to gcc, and as long as you don't mix 
signs in your values, for example.

But we actually want to let people compile even the kernel with other 
compilers than gcc. Most of the time, that means that we strongly 
encourage those compiler people to support all the gcc extensions (let's 
face it, standardization is good, and open standards work better than 
closed ones, and gcc is the most widely spread open and portable compiler 
BY FAR, so it would be stupid to _not_ do that).

But at times, some of the gcc extensions aren't necessarily that well 
defined or thought out, or simply not worth it. The extended type system 
for enums in gcc is just basically messy, and it doesn't really offer you 
anything important.

Compared with inline assembly, for example, inline assembly may be even 
messier and more complicated, but inline assembly definitely offers you 
something very important. The strange enum type extensions? What do they 
really offer above and beyond the standard C preprocessor #define's? Apart 
from some (very limited) name scoping advantages, there really isn't 
anything that it really helps with.

And as Al already mentioned, some of the extensions aren't even compatible 
within different versions of gcc itself. Admittedly they are all fairly 
special, but basically the "type" of different individual enum members 
simply isn't well-defined in all cases, and will even depend on thigns 
like the order they were declared in, if I recall correctly.

Messy, messy.

			Linus
