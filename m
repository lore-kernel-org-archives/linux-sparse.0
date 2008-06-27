From: Bernd Petrovitsch <bernd@firmix.at>
Subject: Re: Pointer arithmetic error
Date: Fri, 27 Jun 2008 13:20:44 +0200
Message-ID: <1214565644.20755.80.camel@tara.firmix.at>
References: <486428D7.8080603@cowlark.com>
	 <70318cbf0806261651u7a163d54m4d100012bce5db49@mail.gmail.com>
	 <48643191.307@cowlark.com> <1214560196.20755.73.camel@tara.firmix.at>
	 <4864C710.8000208@cowlark.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ns.firmix.at ([62.141.48.66]:1519 "EHLO ns.firmix.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756346AbYF0LVv (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 27 Jun 2008 07:21:51 -0400
Received: from ns.firmix.at (localhost [127.0.0.1])
	by ns.firmix.at (8.14.1/8.14.1) with ESMTP id m5RBLgUt027158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Fri, 27 Jun 2008 13:21:42 +0200
Received: (from defang@localhost)
	by ns.firmix.at (8.14.1/8.14.1/Submit) id m5RBKjMH027114
	for <linux-sparse@vger.kernel.org>; Fri, 27 Jun 2008 13:20:45 +0200
In-Reply-To: <4864C710.8000208@cowlark.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Given <dg@cowlark.com>
Cc: linux-sparse@vger.kernel.org

On Fre, 2008-06-27 at 11:55 +0100, David Given wrote:
> Bernd Petrovitsch wrote:
> [...]
> > In C, there is no type "byte" (unless you typedef oder #define it).
> > "byte" is usually (but not necessarily) meant as "unsigned char".
> 
> The issue here is that sparse is helpful and converts pointer offsets 
> into byte offsets when generating code for pointer arithmetic. So:
> 
> const int* p = (const char*) 1234;
> p += 10;
> 
> -->
> 
> set.32 %p0 <- 1234
> add.32 %p1 <- %p0, 40
> (In fact, in this example it'd collapse these together and use 1274 
> instead.)
> 
> This appears to be done using hard-coded knowledge that a byte (one unit 
> of addressingness) is 8 bits wide.

It is done IMHO with the false knowledge that "sizeof(int) == 4 *
sizeof(char)".
IIUC your hardware (a DSP or what is it exactly) has "sizeof(int) ==
sizeof(char)" so the size of a char (or int) as such is irrelevant.

> Chris Li wrote:
> > Byte need to big enough to hold the char. Using bits_in_byte is better.
> > There might be other place in sparse assume byte is 8 bits.
> 
> IIRC C specifies that sizeof() returns values measured in chars, but I 

ACK. Therefore "sizeof(char) == 1" must always hold.

> don't believe it specifies any mapping between the size of chars and the 
> underlying addressing units --- it should be possible to use 16-bit 

Yes, that's what CHAR_BIT is for.

> chars, for example, on an 8-bit byte system. Using 32-bit ints, 
> sizeof(int) would then return 2; but you wouldn't be able to access 
> individual bytes from C.

ACK (apart from "shift and mask it" ans similar).

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services


