From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: Sparse crash when mixing int and enum in ternary operator
Date: Tue, 9 Mar 2010 14:46:49 +0100
Message-ID: <201003091446.50092.kdudka@redhat.com>
References: <1268097872.16227.10.camel@mj> <70318cbf1003082143n15e88111haee15d2aa027c0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_KFllL20hpPsK2yi"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:24076 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306Ab0CINsq (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 9 Mar 2010 08:48:46 -0500
In-Reply-To: <70318cbf1003082143n15e88111haee15d2aa027c0b@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

--Boundary-00=_KFllL20hpPsK2yi
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Tue March 9 2010 06:43:09 Christopher Li wrote:
> On Mon, Mar 8, 2010 at 5:24 PM, Pavel Roskin <proski@gnu.org> wrote:
> > Hello!
> > 
> > Sparse crashed when checking drivers/net/wireless/ath/ath9k/gpio.c in
> > Linux.  I could reduce the crash to the following simple program:
> > 
> > enum kind {
> >    GOOD
> > };
> > static void foo(enum kind k)
> > {
> > }
> > static void bar(int ok, int k)
> > {
> >    foo(ok ? GOOD : k);
> > }
> 
> Confirm. This is cause by the recent enum-warning patch. Without it the
> sparse runs fine.

Thank both of you for tacking down the bug!

> Let me see if this is some thing easy to fix.

It's easy to fix as soon as I understand how EXPR_CONDITIONAL/EXPR_SELECT
work in sparse.  A fix from scratch is attached, but I'll need more time
for testing it and to write some extra test-cases.

Kamil

--Boundary-00=_KFllL20hpPsK2yi
Content-Type: text/x-patch;
  charset="UTF-8";
  name="sparse-enum.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sparse-enum.patch"

diff --git a/evaluate.c b/evaluate.c
index d3d5e6f..214b2b7 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -327,13 +327,28 @@ warn_for_int_to_enum_conversion (struct expression *expr, struct symbol *typeb)
 }
 
 static void
-warn_for_enum_conversions(struct expression *expr, struct symbol *type)
+do_warn_for_enum_conversions(struct expression *expr, struct symbol *type)
 {
 	warn_for_different_enum_types (expr, type);
 	warn_for_enum_to_int_conversion (expr, type);
 	warn_for_int_to_enum_conversion (expr, type);
 }
 
+static void
+warn_for_enum_conversions(struct expression *expr, struct symbol *type)
+{
+	switch (expr->type) {
+		case EXPR_CONDITIONAL:
+		case EXPR_SELECT:
+			do_warn_for_enum_conversions(expr->cond_true, type);
+			do_warn_for_enum_conversions(expr->cond_false, type);
+			break;
+
+		default:
+			do_warn_for_enum_conversions(expr, type);
+	}
+}
+
 /*
  * This gets called for implicit casts in assignments and
  * integer promotion. We often want to try to move the

--Boundary-00=_KFllL20hpPsK2yi--
