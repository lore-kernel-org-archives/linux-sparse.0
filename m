From: Bernd Petrovitsch <bernd@firmix.at>
Subject: Re: Pointer arithmetic error
Date: Fri, 27 Jun 2008 16:45:26 +0200
Message-ID: <1214577926.20755.98.camel@tara.firmix.at>
References: <486428D7.8080603@cowlark.com>
	 <70318cbf0806261651u7a163d54m4d100012bce5db49@mail.gmail.com>
	 <48643191.307@cowlark.com> <1214560196.20755.73.camel@tara.firmix.at>
	 <4864C710.8000208@cowlark.com> <1214565644.20755.80.camel@tara.firmix.at>
	 <4864F31C.3090606@cowlark.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ns.firmix.at ([62.141.48.66]:2093 "EHLO ns.firmix.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755372AbYF0Ope (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 27 Jun 2008 10:45:34 -0400
Received: from ns.firmix.at (localhost [127.0.0.1])
	by ns.firmix.at (8.14.1/8.14.1) with ESMTP id m5REjU6W002988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Fri, 27 Jun 2008 16:45:30 +0200
Received: (from defang@localhost)
	by ns.firmix.at (8.14.1/8.14.1/Submit) id m5REjRd9002986
	for <linux-sparse@vger.kernel.org>; Fri, 27 Jun 2008 16:45:27 +0200
In-Reply-To: <4864F31C.3090606@cowlark.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Given <dg@cowlark.com>
Cc: linux-sparse@vger.kernel.org

On Fre, 2008-06-27 at 15:03 +0100, David Given wrote:
> Bernd Petrovitsch wrote:
> > It is done IMHO with the false knowledge that "sizeof(int) == 4 *
> > sizeof(char)".
> 
> No, it's correctly been told that ints are 32 bits wide, but then it's 
> converting this to *bytes* (not chars) by dividing by the hard-coded 

That's the bug. there is no difference between "byte" and "char". Tell
it that a char has 32 bits too *if* it's the case.

> constant 8.

Why do you (or sparse) want to divide a the size of a type where
"sizeof(type) == 1"?
Use (a correct) CHAR_BIT for that.

> (By 'byte' I'm referring to the quantum of addressingness of the 
> underlying machine architecture. In other words, the numbers that are 
> used as parameters as offsets into load and store. This isn't something 
> that's exposed to C except on architectures where sizeof(byte) == 
> sizeof(char), i.e., all sensible ones.)

Such hardware-specific issues must be implemented by the compiler. So
you probably have to extend "sparse" for that feature.

> [...]
> > ACK. Therefore "sizeof(char) == 1" must always hold.
> 
> Yes; but that is only true from C's perspective.

Is there another remotely relevant perspective (let alone more
important) in a C parser?

> We're dealing with things from the machine code perspective, where 
> sizeof(byte) == 1, and sizeof(char) is not necessarily the same as 
> sizeof(byte).

And that's AFAIU the problem: "sizeof(char) == 1" in C (K&R, c8x, c99)
per definitionem. There is no way around it. For all architectures in
the world, past, present and future.

If your hardware has 32bit char, short and int types, there is no way in
C to define a "byte" in a somewhat sane way. Yes, there are bitfields
but that tend to get somewhat clumsy.

Perhaps the are some compiler-specific extensions for such strange
hardware. But then you leave the defined ground and need to implement
them into "sparse" too.

> I find it really helps with this stuff if you are capable of holding two 
> completely contradictory beliefs at the same time. A certain level of 

I'm just pointing out the view of "C" (or what I understand it is).
Since "sparse" is a C code parser, this should matter most (if not all
and only) IMNSHO.
I don't think the (above newly beyond "C" introduced) concept of "byte"
for your specific, unknown and secret CPU/architecture is helpful in any
way.

> insanity can help too...

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services


