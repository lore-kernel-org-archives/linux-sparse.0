From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: [PATCH] let sparse warn on &inline_function
Date: Sun, 21 May 2006 23:37:42 +0100
Message-ID: <4470EBB6.6030404@knosof.co.uk>
References: <200605201621.48466.mb@bu3sch.de> <446F3149.4060606@knosof.co.uk> <200605201734.40756.mb@bu3sch.de> <446F3B91.6020709@knosof.co.uk> <20060521193709.GA22520@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:15272 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751475AbWEUWhq (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 21 May 2006 18:37:46 -0400
In-Reply-To: <20060521193709.GA22520@wohnheim.fh-wedel.de>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: Michael Buesch <mb@bu3sch.de>, linux-sparse@vger.kernel.org

J=F6rn,

>> It makes perfect sense for me to want 'direct' calls to be
>> inlined and be willing to accept that calls via pointers
>> will not be inlined.
>=20
> Does this still make sense with CONFIG_CC_OPTIMIZE_FOR_SIZE set?

Using the inline specifier may or may not make sense in this case.
I don't see what using the address-of operator has to do with things.

If CONFIG_CC_OPTIMIZE_FOR_SIZE is set I would assume that gcc might
be given slightly different options to control the permissible
inline code expansion factor.

See sentence 1519 of www.knosof.co.uk/cbook/cbook.html for
a more detailed discussion.

--=20
Derek M. Jones                              tel: +44 (0) 1252 520 667
Knowledge Software Ltd                      mailto:derek@knosof.co.uk
Applications Standards Conformance Testing    http://www.knosof.co.uk
