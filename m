From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH v2 09/10] bug.h: Add BUILD_BUG_ON_MSG &
 BUILD_BUG_INTERNAL{,2}
Date: Fri, 5 Oct 2012 14:02:59 -0700
Message-ID: <20121005210258.GB7362@jtriplet-mobl1>
References: <1349465759-20524-1-git-send-email-daniel.santos@pobox.com>
 <1349466169-20637-9-git-send-email-daniel.santos@pobox.com>
 <20121005205858.GB28452@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:38872 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754118Ab2JEVDI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 5 Oct 2012 17:03:08 -0400
Content-Disposition: inline
In-Reply-To: <20121005205858.GB28452@liondog.tnic>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, danielfsantos@att.net, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, David Rientjes <rientjes@google.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, Daniel Santos <daniel.santos@pobox.com>

On Fri, Oct 05, 2012 at 10:58:58PM +0200, Borislav Petkov wrote:
> On Fri, Oct 05, 2012 at 02:42:48PM -0500, danielfsantos@att.net wrote=
:
> > Add BUILD_BUG_ON_MSG which behaves like BUILD_BUG_ON (with optimiza=
tions
> > turned enabled), except that it allows you to specify the error mes=
sage
> > you want emitted as the third parameter.  Under the hood, this reli=
es on
> > BUILD_BUG_INTERNAL{,2}, which does the actual work and is pretty-mu=
ch
> > identical to BUILD_BUG_ON.
> >=20
> > Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
> > ---
> >  include/linux/bug.h |   26 ++++++++++++++++++++++++++
> >  1 files changed, 26 insertions(+), 0 deletions(-)
> >=20
> > diff --git a/include/linux/bug.h b/include/linux/bug.h
> > index 1b43ea2..91bd9d5 100644
> > --- a/include/linux/bug.h
> > +++ b/include/linux/bug.h
> > @@ -16,6 +16,7 @@ struct pt_regs;
> >  #define BUILD_BUG_ON_NOT_POWER_OF_2(n)
> >  #define BUILD_BUG_ON_ZERO(e) (0)
> >  #define BUILD_BUG_ON_NULL(e) ((void*)0)
> > +#define BUILD_BUG_ON_MSG(cond, msg) (0)
> >  #define BUILD_BUG_ON(condition) (0)
> >  #define BUILD_BUG() (0)
> >  #else /* __CHECKER__ */
> > @@ -38,6 +39,31 @@ struct pt_regs;
> >   */
> >  #define BUILD_BUG_ON_INVALID(e) ((void)(sizeof((__force long)(e)))=
)
> > =20
> > +#define _CONCAT1(a, b) a##b
> > +#define CONCAT(a, b) _CONCAT1(a, b)
>=20
> Let's call the indirection _CONCAT without the "1".
>=20
> > +#define UNIQUIFY(prefix) CONCAT(prefix, __LINE__)
> > +
> > +#define BUILD_BUG_INTERNAL2(condition, msg, fn)			\
> > +	do {							\
> > +		extern void fn (void) __compiletime_error(msg);	\
> > +		__compiletime_error_fallback(condition);	\
> > +		if (condition)					\
> > +			fn();					\
> > +	} while (0)
> > +
> > +#define BUILD_BUG_INTERNAL(condition, msg, fn) \
> > +	BUILD_BUG_INTERNAL2(condition, msg, fn)
>=20
> Ditto. BUILD_BUG_INTERNAL2 should be __BUILD_BUG_INTERNAL and the one
> calling it _BUILD_BUG_INTERNAL (with one underscore).

Also, you don't need both the BUILD_BUG_INTERNAL and CONCAT/UNIQUIFY
macros.  My original implementation just used the BUILD_BUG_INTERNAL
family of macros; if you'd rather rename them, by all means do so, but =
I
don't think you need two separate families of multiply-indirect macros.

> > +
> > +/**
> > + * BUILD_BUG_ON_MSG - break compile if a condition is true & emit =
supplied
> > + * 		      error message.
> > + * @condition: the condition which the compiler should know is fal=
se.
> > + *
> > + * See BUILD_BUG_ON for description.
> > + */
> > +#define BUILD_BUG_ON_MSG(cond, msg) \
> > +	BUILD_BUG_INTERNAL(cond, msg, UNIQUIFY(__build_bug_on_failed_))
>=20
> Btw, why are we adding the line at all? It is issued by gcc anyway:
>=20
> cc -Wall    macros.c   -o macros
> macros.c: In function =E2=80=98main=E2=80=99:
> macros.c:22:1: error: =E2=80=98__build_bug_on_failed_22=E2=80=99 unde=
clared (first use in this function)

Because without that, you end up writing multiple prototypes for the
same function (__build_bug_on_failed) with different error attributes,
and GCC will ignore all but the last error attribute it sees, even with
a scoped prototype.

- Josh Triplett
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
