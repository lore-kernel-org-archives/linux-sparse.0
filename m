From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: Sparse crash when mixing int and enum in ternary operator
Date: Mon, 29 Mar 2010 14:26:27 -0700
Message-ID: <20100329212627.GA23497@feather>
References: <1268097872.16227.10.camel@mj>
 <201003211627.14164.kdudka@redhat.com>
 <70318cbf1003240307m6be38384l3524923484e493ce@mail.gmail.com>
 <201003271016.39291.kdudka@redhat.com>
 <20100327092949.GB9548@feather>
 <70318cbf1003291105v44334f0et82575f62a8c187f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay1-v.mail.gandi.net ([217.70.178.75]:43237 "EHLO
	relay1-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872Ab0C2V0i (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 29 Mar 2010 17:26:38 -0400
Content-Disposition: inline
In-Reply-To: <70318cbf1003291105v44334f0et82575f62a8c187f8@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Kamil Dudka <kdudka@redhat.com>, Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

On Mon, Mar 29, 2010 at 11:05:08AM -0700, Christopher Li wrote:
> On Sat, Mar 27, 2010 at 2:29 AM, Josh Triplett <josh@joshtriplett.org=
> wrote:
> >> =A0 =A0 .type =3D (enum keyword) (KW_SPECIFIER | KW_SHORT),
> >> =A0 =A0 lookup_keyword(token->ident, (enum namespace) (NS_KEYWORD =
| NS_TYPEDEF));
> >
> > That looks wrong. =A0.type doesn't contain a value of type "enum ke=
yword",
> > it contains the bitwise or of such values, which won't represent a =
valid
> > enum value. =A0Thus, .type should have an integral type, not an enu=
m type.
> > The same goes for the second parameter of lookup_keyword.
>=20
> According to the new "strict enum" rules which don't allow enum type =
to accept
> value other than the enum list above, that is right.
>=20
> But I argue that this strict enum rules does not make sense, after th=
is change,
> the code don't not gain any thing. In fact, it looks worse.
>=20
> Sparse use a loosely define enum namespace for member "namespace". It=
 means
> it has all this basic enum value, from NS_MACRO to NS_KEYWORD. In my =
mind,
> all combination of this value consider enum namespace as well. It is
> just that I can't
> list all of them in the enum list.
>=20
> Using enum namespace for member "namespace" has benefit here. It is c=
lear that
> which set of value it belongs to. E.g. if you assign SYM_NODE into "n=
amespace"
> member it *looks* is obvious wrong.

No language that I know of with an enumerated type has such a behavior,
including C.

However, we could easily produce a type that *does* have the behavior
you want, with __attribute__((bitwise)).  That would produce a type tha=
t
doesn't mix with int, but allows bitwise operations like | and &.  That
seems like a much better fit than enums.

> It also helps people understand which set of value belongs to
> "namespace" member.
> Make "namespace" a plain int, that message is lost. It become very
> confusing for new comer
> what value was allowed in this int type.

I agree that we should have *some* better documentation than just "int"=
,
but C alone doesn't do that.  Because C has historically just treated
"enum" as "int", people abuse the enum types in many different ways
because compilers didn't complain.  In particular, the use of enum to
define a set of related constants rather than #define or const works in
some cases (when the constants get used as standalone values) and not i=
n
others (bitwise flags).

If you *really* want to allow "bitwise enums", what about allowing
__attribute__((bitwise)) on the enum definition?  That would help
clarify what the enum really means.  It seems like a mistake to me to
allow 0x3 in an enum whose values only allow 0x1 and 0x2, but at least
tagging it with bitwise would document that usage and distinguish it
from enums that really do list all the permissible values.

> So back to my point. It seems making the enum more strict is just mak=
e up rules
> and gain nothing in real life. It makes code looks worse just to make
> strict enum type
> happy.

On the contrary, making enum more strict helps improve static typing,
preventing many abuses of enums.  This only seems like a problem in cod=
e
that abused enums, like Sparse did. :)

- Josh Triplett
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
