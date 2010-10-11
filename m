From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: including sparse headers in C++ code
Date: Mon, 11 Oct 2010 12:12:20 -0700
Message-ID: <20101011191219.GD8537@feather>
References: <AANLkTinGSRQYqR2h+V0nAB+vn4xWCGxgbmGHuMm-xHyB@mail.gmail.com>
 <AANLkTinaDZZmyeaK+rAvLCdZ-90n17WhABRsZGUBBcSH@mail.gmail.com>
 <1286710919.24953.2.camel@thorin>
 <201010101352.10864.kdudka@redhat.com>
 <1286790249.24953.14.camel@thorin>
 <AANLkTin00gg79Zdg1JJgaaK+2wzgu9Xpr719MYOebQ+J@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:57535 "EHLO
	relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755113Ab0JKTMa (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 11 Oct 2010 15:12:30 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTin00gg79Zdg1JJgaaK+2wzgu9Xpr719MYOebQ+J@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Bernd Petrovitsch <bernd@sysprog.at>, Kamil Dudka <kdudka@redhat.com>, Tomas Klacko <tomas.klacko@gmail.com>, linux-sparse@vger.kernel.org

On Mon, Oct 11, 2010 at 09:04:18AM -0700, Christopher Li wrote:
> On Mon, Oct 11, 2010 at 2:44 AM, Bernd Petrovitsch <bernd@sysprog.at>=
 wrote:
> > ---- =C2=A0snip =C2=A0----
> > {102}egrep -wc 'false|true' *.[ch] | grep -v :0
> > compile-i386.c:19
> > evaluate.c:13
> > expand.c:10
> > flow.c:10
> > inline.c:13
> > linearize.c:6
> > pre-process.c:3
> > show-parse.c:3
> > simplify.c:9
> > symbol.c:1
> > tokenize.c:1
> > ---- =C2=A0snip =C2=A0----
> > There are perhaps false positives in there - but not all.
> >
> > Perhaps 'sparse' should warn if one names variables, functions, and
> > similar "true", "false" or with any other C99 keyword.
> > For C++ keywords, a different option is probably best.
>=20
> Those are not used in header files they should be fine. Sparse uses
> C99 extensively
> so it is likely it can't compile as C++ any way. I see no reason to
> compile sparse
> with C++.

Actually, Sparse seems to use "true" and "false" as variable names in
several cases; for instance:

static struct symbol *evaluate_conditional_expression(struct expression=
 *expr)
{
        struct expression **true;
[...]
        true =3D &expr->conditional;


I think this only works because evaluate.c doesn't include stdbool.h.
And sure enough, if I include stdbool.h from evaluate.c:

     CC       evaluate.o
evaluate.c: In function =E2=80=98evaluate_conditional_expression=E2=80=99=
:
evaluate.c:1081: error: expected identifier or =E2=80=98(=E2=80=99 befo=
re numeric constant
evaluate.c:1095: error: lvalue required as left operand of assignment
evaluate.c:1101: error: lvalue required as left operand of assignment
evaluate.c:1106: error: invalid type argument of =E2=80=98unary *=E2=80=
=99 (have =E2=80=98int=E2=80=99)
evaluate.c:1114: error: invalid type argument of =E2=80=98unary *=E2=80=
=99 (have =E2=80=98int=E2=80=99)
evaluate.c:1116: error: invalid type argument of =E2=80=98unary *=E2=80=
=99 (have =E2=80=98int=E2=80=99)
evaluate.c:1116: error: invalid type argument of =E2=80=98unary *=E2=80=
=99 (have =E2=80=98int=E2=80=99)
evaluate.c:1122: error: invalid type argument of =E2=80=98unary *=E2=80=
=99 (have =E2=80=98int=E2=80=99)
evaluate.c:1126: error: invalid type argument of =E2=80=98unary *=E2=80=
=99 (have =E2=80=98int=E2=80=99)
evaluate.c:1126: error: invalid type argument of =E2=80=98unary *=E2=80=
=99 (have =E2=80=98int=E2=80=99)
evaluate.c:1133: error: invalid type argument of =E2=80=98unary *=E2=80=
=99 (have =E2=80=98int=E2=80=99)
evaluate.c:1134: error: invalid type argument of =E2=80=98unary *=E2=80=
=99 (have =E2=80=98int=E2=80=99)
evaluate.c:1134: error: invalid type argument of =E2=80=98unary *=E2=80=
=99 (have =E2=80=98int=E2=80=99)
evaluate.c:1202: error: invalid type argument of =E2=80=98unary *=E2=80=
=99 (have =E2=80=98int=E2=80=99)
evaluate.c:1202: error: invalid type argument of =E2=80=98unary *=E2=80=
=99 (have =E2=80=98int=E2=80=99)


I agree with Bernd: I think Sparse should have a warning for using
"true", "false", or "bool" as an identifier of any kind.  That would
necessitate some way to avoid such warnings for the actual definitions
in stdbool.h.  Alternatively, Sparse could warn about using "true" or
"false" as anything other than values, and about using "bool" as
anything other than a type; that would allow for projects that define
their own bool in a compatible way.

- Josh Triplett
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
