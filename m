From: Pavel Roskin <proski@gnu.org>
Subject: Re: Bogus error for constant array sizes
Date: Thu, 29 May 2008 18:10:09 -0400
Message-ID: <1212099009.4265.41.camel@dv>
References: <1212091282.4265.10.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:35485 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751863AbYE2WKL (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 29 May 2008 18:10:11 -0400
Received: from [192.168.1.21] (static-72-92-88-10.phlapa.fios.verizon.net [72.92.88.10])
	by relay.cesmail.net (Postfix) with ESMTP id 29970619058
	for <linux-sparse@vger.kernel.org>; Thu, 29 May 2008 18:10:10 -0400 (EDT)
In-Reply-To: <1212091282.4265.10.camel@dv>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

On Thu, 2008-05-29 at 16:01 -0400, Pavel Roskin wrote:
> Hello!
>=20
> I'm running sparse (the current git version) on this file:
>=20
> static const int len =3D 64;
> void foo(void);
> void foo(void)
> {
>         int buf[len];
> }
>=20
> sparse test.c=20
> test.c:5:10: error: bad constant expression
>=20
> But if I remove "const", the error message goes away.

It turns out the initializer with "const" is an "implied cast"!

value->type after constant_symbol_value() call in expand_dereference()
is EXPR_VALUE if const is not used and EXPR_IMPLIED_CAST is const is
used.  It is EXPR_CAST for this input:

static int len =3D (int)64;
void foo(void);
void foo(void)
{
        int buf[len];
}=20

That file would trigger the warning too.  I believe "value" should be
expanded, at least in some cases.  What matters is whether the value
evaluates to a constant at the compile time.

Even if we expand the value, problematic casts are still reported:

static int len =3D 0x100000000LL;
void foo(void);
void foo(void)
{
        int buf[len];
}

warning: cast truncates bits from constant value (100000000 becomes 0)

This patch fixes the bogus errors.  =EF=BB=BFThe testsuite passes.  I r=
an sparse
on MadWifi where it was detecting those errors, and now it's showing
usable warnings instead.

Please review the patch.  Sparse is still almost voodoo science to me.
Once I understand more, I'll write the patch description :-)

diff --git a/expand.c b/expand.c
index 032f0c5..5aa0a1d 100644
--- a/expand.c
+++ b/expand.c
@@ -565,6 +565,7 @@ static struct expression *constant_symbol_value(str=
uct symbol *sym, int offset)
 	value =3D sym->initializer;
 	if (!value)
 		return NULL;
+	expand_expression(value);
 	if (value->type =3D=3D EXPR_INITIALIZER) {
 		struct expression *entry;
 		FOR_EACH_PTR(value->expr_list, entry) {


Another question is why assigning a numeric constant to a constant
variable is an "implied cast".  It should be possible to use numeric
constants (or anything that can be calculated at the compile time) to
initialize both constant and non-constant variables without any implied
casts as long as the value fits the destination type.  Or perhaps the
assignments to non-constant variables should be implied casts.

--=20
Regards,
Pavel Roskin
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
