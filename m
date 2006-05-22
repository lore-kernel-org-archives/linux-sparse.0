From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: [PATCH] let sparse warn on &inline_function
Date: Mon, 22 May 2006 11:06:49 +0100
Message-ID: <44718D39.4020000@knosof.co.uk>
References: <200605201621.48466.mb@bu3sch.de> <446F3149.4060606@knosof.co.uk> <200605201734.40756.mb@bu3sch.de> <446F3B91.6020709@knosof.co.uk> <20060521193709.GA22520@wohnheim.fh-wedel.de> <4470EBB6.6030404@knosof.co.uk> <20060522083650.GA19072@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:26876 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1750702AbWEVKGy (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 May 2006 06:06:54 -0400
In-Reply-To: <20060522083650.GA19072@wohnheim.fh-wedel.de>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: Michael Buesch <mb@bu3sch.de>, linux-sparse@vger.kernel.org

J=F6rn,

>>>> It makes perfect sense for me to want 'direct' calls to be
>>>> inlined and be willing to accept that calls via pointers
>>>> will not be inlined.
>>> Does this still make sense with CONFIG_CC_OPTIMIZE_FOR_SIZE set?
>> Using the inline specifier may or may not make sense in this case.
>=20
> And this is exactly what warnings are all about.  If the code in
> question may make sense, but there is a certain likelyhood that it
> does not, print a warning.

In which case the message needs to be changed to flag the function
definition that contains the inline function specifier, not the point
at which it is the operand of an address-of operator.

--=20
Derek M. Jones                              tel: +44 (0) 1252 520 667
Knowledge Software Ltd                      mailto:derek@knosof.co.uk
Applications Standards Conformance Testing    http://www.knosof.co.uk
