From: Michael Stefaniuc <mstefani@redhat.com>
Subject: Re: L'\0' handling
Date: Thu, 08 Apr 2010 17:54:16 +0200
Message-ID: <4BBDFC28.4080304@redhat.com>
References: <1270738799.2167.7.camel@yura-tl>  <4BBDF4C0.8020305@redhat.com> <1270741172.2167.9.camel@yura-tl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41776 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753954Ab0DHPyT (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 8 Apr 2010 11:54:19 -0400
In-Reply-To: <1270741172.2167.9.camel@yura-tl>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Yura Pakhuchiy <pakhuchiy@gmail.com>
Cc: linux-sparse@vger.kernel.org

Yura Pakhuchiy wrote:
> =D0=A3 =D0=A7=D1=86=D0=B2, 08/04/2010 =D1=83 17:22 +0200, Michael Ste=
faniuc =D0=BF=D1=96=D1=88=D0=B0:
>> Yura Pakhuchiy wrote:
>>> It looks like sparse do not understand constructions like L'\0'.
>> yepp, it doesn't. I have run into that problem 2 years ago. But for =
Wine
>> that is actually a "feature" as wide char/string literals are forbid=
den
>> aka cannot be used. Thus my interest in adding support for that in
>> sparse died.
>=20
> Wine is not the only project which uses sparse. Sparse is broken for =
any
I'm a Wine developer and not a sparse developer. I was just saying that
I run into this problem in sparse, thought about fixing it but dumped
the idea and submitted instead patches to Wine to remove the wide
char/string literals.

> userspace program which includes wchar.h in Ubuntu with out supportin=
g
> this.
I didn't assert that the feature shouldn't be implemented, just that it
is a known missing feature that the normal sparse consumer didn't need
until now.

bye
	michael
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
