From: Pavel Roskin <proski@gnu.org>
Subject: Re: Antwort: Re: Messing typedefs?
Date: Wed, 27 Jun 2007 01:01:22 -0400
Message-ID: <1182920482.6439.37.camel@dv>
References: <OF341CD9CB.28B48978-ONC1257306.002DC88B-C1257306.002E17BE@br-automation.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([140.186.70.10]:60171 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289AbXF0FBZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 27 Jun 2007 01:01:25 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1I3Pee-0004QK-94
	for linux-sparse@vger.kernel.org; Wed, 27 Jun 2007 01:01:24 -0400
In-Reply-To: <OF341CD9CB.28B48978-ONC1257306.002DC88B-C1257306.002E17BE@br-automation.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Thomas Schmid <Thomas.Schmid@br-automation.com>
Cc: linux-sparse@vger.kernel.org

On Tue, 2007-06-26 at 10:23 +0200, Thomas Schmid wrote:
> Pavel Roskin <proski@gnu.org> schrieb am 13.06.2007 07:22:02:

> > What happens is the base types like uchar_ctype, which are supposed to
> > be initialized once and never changed again, are actually initialized by
> > the first typedef, so they are sort of "imprinted" with the new name.
> 
> > And the code is:
> > 
> >         if (is_typedef) {
> >                 if (base_type && !base_type->ident)
> >                         base_type->ident = ident;
> >         } else if (base_type && base_type->type == SYM_FN) {
> > 
> 
> If I get it right, every typedef pointing to a base type should lead into 
> a new base type to get its right ident?

I don't understand your question.

My interpretation of the code is following.  Types may have idents,
which keep information where and how the type was defined.  Base types
don't have idents.

Suppose we have a typedef which uses a new type using a type without an
ident.  In this case, the quotes code snippet would set the ident for
the original type, as if it's also defined by the same typedef.

If other words,

typedef int handle_t;

would be considered as a definition for both "handle_t" and "int".
That's obviously wrong for base types.

The code can be traced back to the commit
d0d20047fb01047beff2beb39c1f4286791196f7 by Oleg Nesterov.  That's the
description:

    [PATCH] de-anonymize typedefs
    
    Code:
        atomic_t v;
        v.xxxx = 0;
    
    without patch:
        warning: no member 'xxxx' in struct <unnamed>
    
    with patch:
        warning: no member 'xxxx' in struct atomic_t
    
    Actually I want this patch because I started the simple libsparse
    client, and I don't see the simple way to resolve SYM_STRUCT's
    name in typedef case.

That's an example that doesn't rely on kernel headers:

typedef struct { int counter; } atomic_t;
int main (int args, char **argv)
{
        atomic_t v;
        v.xxxx = 0;
}

Commenting out the retroactive ident assignment makes this issue
reappear.

> > I don't know what base_type->ident needs to be updated at all.  At least
> > SYM_BASETYPE should be exempt from this retroactive update.
> 
> Any idea how to fix this?

I think a struct defined inside a typedef (and probably inside some
other constructs) should get its own ident.  Relying on typedef seems
wrong to me.  Every struct or union type should have an ident from the
beginning.

-- 
Regards,
Pavel Roskin
