From: Bernd Petrovitsch <bernd@firmix.at>
Subject: Re: Pointer arithmetic error
Date: Sun, 29 Jun 2008 14:19:47 +0200
Message-ID: <1214741987.4216.15.camel@gimli.at.home>
References: <486428D7.8080603@cowlark.com>
	 <70318cbf0806261651u7a163d54m4d100012bce5db49@mail.gmail.com>
	 <48643191.307@cowlark.com> <1214560196.20755.73.camel@tara.firmix.at>
	 <4864C710.8000208@cowlark.com> <1214565644.20755.80.camel@tara.firmix.at>
	 <4864F31C.3090606@cowlark.com> <1214577926.20755.98.camel@tara.firmix.at>
	 <48650B35.5040505@cowlark.com>
	 <70318cbf0806271101n2f9a65buc72764ee97f9ced9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ns.firmix.at ([62.141.48.66]:2165 "EHLO ns.firmix.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753917AbYF2MUH (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 29 Jun 2008 08:20:07 -0400
Received: from ns.firmix.at (localhost [127.0.0.1])
	by ns.firmix.at (8.14.1/8.14.1) with ESMTP id m5TCK2W8009420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Sun, 29 Jun 2008 14:20:02 +0200
Received: (from defang@localhost)
	by ns.firmix.at (8.14.1/8.14.1/Submit) id m5TCJxel009407
	for <linux-sparse@vger.kernel.org>; Sun, 29 Jun 2008 14:19:59 +0200
In-Reply-To: <70318cbf0806271101n2f9a65buc72764ee97f9ced9@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: David Given <dg@cowlark.com>, linux-sparse@vger.kernel.org

On Fre, 2008-06-27 at 11:01 -0700, Christopher Li wrote: 
> > In C, there is no type "byte" (unless you typedef oder #define it).
> > "byte" is usually (but not necessarily) meant as "unsigned char".
> 
> In C spec, there is a concept of "byte". The union return by sizeof()

I stand corrected. Hmm, I need the time to read C99 thoroughly.

> is byte. Char must fit in a byte. But char does not necessary have the
> same bits as byte. Char can have more.
> 
> C99: 3.6, 3.7.1
>
> Because char can always fit in byte, sizeof(char) == 1.

But how can a char have more bits than a byte?

> > IIRC C specifies that sizeof() returns values measured in chars, but
> > I don't believe it specifies any mapping between the size of chars
> > and the underlying addressing units --- it should be possible to use
> > 16-bit chars, for example, on an 8-bit byte system. > Using 32-bit
> > ints, sizeof(int) would then return 2; but you wouldn't be able to
> > access individual bytes from C.
> 
> sizeof() return value measure in _byte_.
> C99: 6.5.3.4

Yes. But "sizeof(char)" is always 1 (as stated in the same chapter). 
So I see no real difference between "byte" and "char" (at least with the
size of them).

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

