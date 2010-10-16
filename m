From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: including sparse headers in C++ code
Date: Sat, 16 Oct 2010 12:11:54 -0700
Message-ID: <20101016191153.GA19324@feather>
References: <AANLkTinGSRQYqR2h+V0nAB+vn4xWCGxgbmGHuMm-xHyB@mail.gmail.com>
 <20101009205930.GA4684@feather>
 <AANLkTinaDZZmyeaK+rAvLCdZ-90n17WhABRsZGUBBcSH@mail.gmail.com>
 <AANLkTi=8EkK+_9pOA8fbDgYGfz-bPGj6XhLUnfSkdGeV@mail.gmail.com>
 <20101011224656.GN19804@ZenIV.linux.org.uk>
 <AANLkTinWYFf0CqBt9FJ9QyeGCU6754GotQM06U4vMqRa@mail.gmail.com>
 <AANLkTimdy9TwwSJM=rwTjXdRsnove6A2b0=d4M_dOin0@mail.gmail.com>
 <AANLkTimhh3zj8kgvaSQq9_CS711mLw8skrWL4yUgvJzT@mail.gmail.com>
 <AANLkTimZb1PsnKcMQ_Ka6dkk7fNwXiJb6_U4GcckLsF4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-v.mail.gandi.net ([217.70.178.78]:57868 "EHLO
	relay4-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753894Ab0JPTMH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 16 Oct 2010 15:12:07 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimZb1PsnKcMQ_Ka6dkk7fNwXiJb6_U4GcckLsF4@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Tomas Klacko <tomas.klacko@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-sparse@vger.kernel.org

On Sat, Oct 16, 2010 at 06:03:53PM +0200, Tomas Klacko wrote:
> On Wed, Oct 13, 2010 at 2:37 AM, Christopher Li <sparse@chrisli.org> =
wrote:
> > On Tue, Oct 12, 2010 at 3:45 PM, Tomas Klacko <tomas.klacko@gmail.c=
om> wrote:
> >> diff --git a/parse.h b/parse.h
> >> index 6b21e23..f2193e7 100644
> >> --- a/parse.h
> >> +++ b/parse.h
> >> @@ -35,10 +35,12 @@ struct statement {
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct /* d=
eclaration */ {
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0struct symbol_list *declaration;
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};
> >> +#ifndef __cplusplus
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct /* l=
abel_arg */ {
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0struct symbol *label;
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0struct statement *label_statement;
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};
> >> +#endif
> >
> > What is this #ifndef =C2=A0for?
>=20
> I use it to avoid this error:
>=20
> [...]/sparse/parse.h:65: error: declaration of =E2=80=98statement*
> statement::<anonymous union>::<anonymous struct>::label_statement=E2=80=
=99
> [...]sparse/parse.h:41: error: conflicts with previous declaration
> =E2=80=98statement* statement::<anonymous union>::<anonymous
> struct>::label_statement=E2=80=99

Huh, interesting.  Turns out that giant union contains two different
structs of the form { struct symbol *, struct statement * }; one for
label_arg and one for labeled_struct.  They have different names for th=
e
symbol, but the same name for the statement.  We should fix that for C
as well, either by renaming one of the statements, or by just making
both variations use the same set of fields and dropping one of the
sub-structs.  Either way, that should happen as an independent patch,
separate from the C++ compatibility changes.

Chris, what do you think?

> >> =C2=A0/* Silly type-safety check ;) */
> >> =C2=A0#define DECLARE_PTR_LIST(listname,type) =C2=A0 =C2=A0 =C2=A0=
 =C2=A0struct listname { type *list[1]; }
> >> -#define CHECK_TYPE(head,ptr) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (=
void)(&(ptr) =3D=3D &(head)->list[0])
> >> =C2=A0#define TYPEOF(head) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 __typeof__(&(head)->list[0])
> >> =C2=A0#define VRFY_PTR_LIST(head) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0(void)(sizeof((head)->list[0]))
> >>
> >> +#ifndef __cplusplus
> >> +#define CHECK_TYPE(head,ptr) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (=
void)(&(ptr) =3D=3D &(head)->list[0])
> >> +#else
> >> +/* I don't know yet how to do this better in C++. */
> >> +#define CHECK_TYPE(head,ptr) (void)((void*)&(ptr) =3D=3D (void*)&=
(head)->list[0])
> >> +#endif
> >
> > If you can't get CHECK_TYPE work in C++, you might just make it an =
empty define
> > instead of doing useless point dancing. At least it is clear that i=
t does not
> > do any thing here.
>=20
> True. How about
> #define CHECK_TYPE (head,ptr)   (void)(1)
> ?

As far as I can tell, CHECK_TYPE works just fine in C++.  I could easil=
y
compile an invocation of CHECK_TYPE, as well as some simple examples
that called the macros which invoked CHECK_TYPE.  When I tried
=46OR_EACH_PTR, I encountered *other* warnings (related to assigning (v=
oid
*) to some other type without a cast), but those warnings didn't come
from CHECK_TYPE.

What warning do you encounter about CHECK_TYPE?

- Josh Triplett
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
