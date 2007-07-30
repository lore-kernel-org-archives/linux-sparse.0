From: Michael Stefaniuc <mstefani@redhat.com>
Subject: Re: Warnings while compiling sparse
Date: Tue, 31 Jul 2007 00:06:11 +0200
Message-ID: <46AE60D3.1050602@redhat.com>
References: <20070730203027.GA21099@redhat.com> <1185830665.3334.27.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:33747 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S969036AbXG3WGP (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 30 Jul 2007 18:06:15 -0400
In-Reply-To: <1185830665.3334.27.camel@josh-work.beaverton.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josht@linux.vnet.ibm.com>
Cc: linux-sparse@vger.kernel.org

Josh Triplett wrote:
> On Mon, 2007-07-30 at 22:30 +0200, Michael Stefaniuc wrote:
>> Hell Josh,
>=20
> Hello to you too. :)
Duh ... I'm really sorry about that.
/me blames it on the cut'n'paste from thunderbird to mutt

bye
	michael

>> commit 06bcf19cb8eb3cc3154ba6131477d742a9f0b4b6
>> Author: Josh Triplett <josh@freedesktop.org>
>> Date:   Sun Jul 29 20:20:38 2007 -0700
>>
>>     Makefile: Use -O2 -finline-functions, not just -O
>>
>>     introduces warnings while compiling sparse on my machine (FC6, x=
86,
>>     gcc version 4.1.2 20070626 (Red Hat 4.1.2-13)):
>=20
> Yes, it does here too.  All of this comes from the ptrlist code, whic=
h
> does indeed break the C99 strict-aliasing rules in its pointer casts.
> Either we need -fno-strict-aliasing or we need to type-pun through a
> union; we most likely want the latter, though it'll uglify the ptrlis=
t
> code.


--=20
Michael Stefaniuc               Tel.: +49-711-96437-199
Sr. Network Engineer            Fax.: +49-711-96437-111
--------------------------------------------------------------------
Reg. Adresse: Red Hat GmbH, Hauptst=C3=A4tter Strasse 58, 70178 Stuttga=
rt
Handelsregister: Amtsgericht Stuttgart HRB 153243
Gesch=C3=A4ftsf=C3=BChrer: Brendan Lane, Charlie Peters, Michael Cunnin=
gham,
                 Werner Knoblich
