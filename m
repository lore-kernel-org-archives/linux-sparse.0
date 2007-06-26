From: Thomas Schmid <Thomas.Schmid@br-automation.com>
Subject: Antwort: Re: Messing typedefs?
Date: Tue, 26 Jun 2007 10:23:26 +0200
Message-ID: <OF341CD9CB.28B48978-ONC1257306.002DC88B-C1257306.002E17BE@br-automation.com>
References: <1181712122.22924.15.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.automotion.info ([213.33.116.60]:52727 "EHLO
	mail1.br-automation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbXFZIXs (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 26 Jun 2007 04:23:48 -0400
In-Reply-To: <1181712122.22924.15.camel@dv>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org

Hi,

Pavel Roskin <proski@gnu.org> schrieb am 13.06.2007 07:22:02:

> Hello Thomas,
> 
> On Mon, 2007-06-11 at 13:59 +0200, Thomas Schmid wrote:
> > Following code
> > 
> >         typedef unsigned char  plcbit;
> >         typedef unsigned char  USINT;
> > 
> >         USINT usVar1;
> > 
> > leads to a symbol "usVar1" with base_type->ident named "plcbit".
> > Is this behaviour expected?
> 
> What happens is the base types like uchar_ctype, which are supposed to
> be initialized once and never changed again, are actually initialized by
> the first typedef, so they are sort of "imprinted" with the new name.

> And the code is:
> 
>         if (is_typedef) {
>                 if (base_type && !base_type->ident)
>                         base_type->ident = ident;
>         } else if (base_type && base_type->type == SYM_FN) {
> 

If I get it right, every typedef pointing to a base type should lead into 
a new base type to get its right ident?

> I don't know what base_type->ident needs to be updated at all.  At least
> SYM_BASETYPE should be exempt from this retroactive update.

Any idea how to fix this?

Best regards,
Thomas Schmid
