From: "Mathias Hasselmann" <Mathias.Hasselmann@gmx.de>
Subject: Re: GObject introspection patches
Date: Fri, 07 Sep 2007 22:48:37 +0200
Message-ID: <20070907204837.273350@gmx.net>
References: <1188940117.10888.17.camel@localhost>	
 <46DF01CF.1090600@codethink.co.uk>	
 <1189024611.16411.11.camel@josh-work.beaverton.ibm.com>
 <1189032124.6389.20.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:33210 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751610AbXIGUsj (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 7 Sep 2007 16:48:39 -0400
In-Reply-To: <1189032124.6389.20.camel@localhost>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Mathias Hasselmann <mathias.hasselmann@gmx.de>, josht@linux.vnet.ibm.com
Cc: linux-sparse@vger.kernel.org, rob.taylor@codethink.co.uk


> > > > Subject: [PATCH] Introduce attribute structure for storing cust=
om
> attributes in symbol nodes.
> >
> > Looks reasonable to me too; I wonder if this generalization could c=
over
> > some other things like contexts, particularly with appropriate
> > factored-out functions to combine attributes from symbols.
>=20
> Seems that I do not know Sparse well enough yet to understand
> which chance for refactoring you see.

After some grepping (and googling) I see that sparse supports some cont=
ext attribute for spin-lock tracking, and that the contexts list of str=
uct ctype is for storing this attributes. So I agree, definitly a field=
 for refactoring and unification. Started to work on that.
--=20
Mathias Hasselmann
http://taschenorakel.de/mathias/

Psssst! Schon vom neuen GMX MultiMessenger geh=F6rt?
Der kanns mit allen: http://www.gmx.net/de/go/multimessenger
