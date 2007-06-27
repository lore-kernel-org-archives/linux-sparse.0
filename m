From: Thomas Schmid <Thomas.Schmid@br-automation.com>
Subject: Antwort: Re: Antwort: Re: Messing typedefs?
Date: Wed, 27 Jun 2007 08:51:44 +0200
Message-ID: <OFC8B6B106.51212EE6-ONC1257307.00233A24-C1257307.0025B204@br-automation.com>
References: <1182920482.6439.37.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.automotion.info ([213.33.116.60]:34067 "EHLO
	mail1.br-automation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135AbXF0GwJ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 27 Jun 2007 02:52:09 -0400
In-Reply-To: <1182920482.6439.37.camel@dv>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org

Pavel Roskin <proski@gnu.org> schrieb am 27.06.2007 07:01:22:

> On Tue, 2007-06-26 at 10:23 +0200, Thomas Schmid wrote:
> > Pavel Roskin <proski@gnu.org> schrieb am 13.06.2007 07:22:02:
> 
> > > What happens is the base types like uchar_ctype, which are supposed 
to
> > > be initialized once and never changed again, are actually 
initialized by
> > > the first typedef, so they are sort of "imprinted" with the new 
name.
> > 
> > > And the code is:
> > > 
> > >         if (is_typedef) {
> > >                 if (base_type && !base_type->ident)
> > >                         base_type->ident = ident;
> > >         } else if (base_type && base_type->type == SYM_FN) {
> > > 
> > 
> > If I get it right, every typedef pointing to a base type should lead 
into 
> > a new base type to get its right ident?
> 
> I don't understand your question.

I see, sorry, i only meant that every typedef (pointing to a base type) 
should get its own symbol->ctype->base_type with a new ident.

> My interpretation of the code is following.  Types may have idents,
> which keep information where and how the type was defined.  Base types
> don't have idents.

But unfortunately they get one. 

Best regards.
Thomas Schmid
