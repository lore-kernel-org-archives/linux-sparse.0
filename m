From: Bernd Petrovitsch <bernd@firmix.at>
Subject: Re: Pointer arithmetic error
Date: Fri, 27 Jun 2008 11:49:56 +0200
Message-ID: <1214560196.20755.73.camel@tara.firmix.at>
References: <486428D7.8080603@cowlark.com>
	 <70318cbf0806261651u7a163d54m4d100012bce5db49@mail.gmail.com>
	 <48643191.307@cowlark.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ns.firmix.at ([62.141.48.66]:1336 "EHLO ns.firmix.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750882AbYF0KT7 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 27 Jun 2008 06:19:59 -0400
Received: from ns.firmix.at (localhost [127.0.0.1])
	by ns.firmix.at (8.14.1/8.14.1) with ESMTP id m5R9nxlx023488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Fri, 27 Jun 2008 11:49:59 +0200
Received: (from defang@localhost)
	by ns.firmix.at (8.14.1/8.14.1/Submit) id m5R9nwE5023486
	for <linux-sparse@vger.kernel.org>; Fri, 27 Jun 2008 11:49:58 +0200
In-Reply-To: <48643191.307@cowlark.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Given <dg@cowlark.com>
Cc: linux-sparse@vger.kernel.org

On Fre, 2008-06-27 at 01:17 +0100, David Given wrote:
> Chris Li wrote:
> [...]
> > I don't think so. The offset part of the ptr_add op is mean to be the
> > absolute offset, not how many element of the pointer index. In other
> > words, it is how many address number it need to add.
> 
> Hmm. True. But even so, it's still not right on my system, which doesn't
> use 8-bit bytes. (It's word addressable where each word can contain any
> value, so sizeof(int) == sizeof(double) == sizeof(char) == 1.)

/usr/include/limits.h should have a correct #define CHAR_BIT.

> Should there, then, be another symbol to define the number of bits in a
> byte, distinct from the number of bits in a char?

In C, there is no type "byte" (unless you typedef oder #define it).
"byte" is usually (but not necessarily) meant as "unsigned char".

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services


