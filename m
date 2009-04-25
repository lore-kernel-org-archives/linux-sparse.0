From: Martin Nagy <nagy.martin@gmail.com>
Subject: Re: [PATCH] Add missing checks for Waddress-space
Date: Sat, 25 Apr 2009 09:36:16 +0200
Message-ID: <20090425093616.3edbb9b5@notas>
References: <20090423222519.48191d61@notas>
	<70318cbf0904241553h58e18921q35c6001ad51cc662@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/inaJWFwBv/7NBpUe_.=_rZP"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:44792 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301AbZDYHg0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 25 Apr 2009 03:36:26 -0400
Received: by ewy24 with SMTP id 24so1344430ewy.37
        for <linux-sparse@vger.kernel.org>; Sat, 25 Apr 2009 00:36:25 -0700 (PDT)
In-Reply-To: <70318cbf0904241553h58e18921q35c6001ad51cc662@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

--MP_/inaJWFwBv/7NBpUe_.=_rZP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Christopher Li wrote:
> On Thu, Apr 23, 2009 at 1:25 PM, Martin Nagy <nagy.martin@gmail.com> wrote:
> >
> > Some of these are missing in evaluate.c. Maybe we should change the
> > option to not consider address space at all, if unset. It would be much
> > easier to make attribute_address_space() ignore it.
> 
> I think disable it at attribute_address_space() might be better.
> Otherwise is_same_type() will still return false for address space difference.
> There are too many places to track down the address space comparison.

OK, new patch attached.

Martin
--MP_/inaJWFwBv/7NBpUe_.=_rZP
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0001-Ignore-address-space-if-Waddress_space.patch

From f05ae87e33092ff9fab9f518887c9dfcb9e32a70 Mon Sep 17 00:00:00 2001
From: Martin Nagy <nagy.martin@gmail.com>
Date: Sat, 25 Apr 2009 06:44:49 +0200
Subject: [PATCH] Ignore address space if !Waddress_space

Remove all previous checks for Waddress_space and add one centralized to
the address_space attribute handler. If user passes the
-Wno-address-space option, we behave as if every pointer had no address
space.

Signed-off-by: Martin Nagy <nagy.martin@gmail.com>
---
 evaluate.c |    8 ++++----
 parse.c    |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 5c3812e..b63fa36 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -689,7 +689,7 @@ const char *type_difference(struct ctype *c1, struct ctype *c2,
 			/* XXX: we ought to compare sizes */
 			break;
 		case SYM_PTR:
-			if (Waddress_space && as1 != as2)
+			if (as1 != as2)
 				return "different address spaces";
 			/* MOD_SPECIFIER is due to idiocy in parse.c */
 			if ((mod1 ^ mod2) & ~MOD_IGNORE & ~MOD_SPECIFIER)
@@ -706,7 +706,7 @@ const char *type_difference(struct ctype *c1, struct ctype *c2,
 			struct symbol *arg1, *arg2;
 			int i;
 
-			if (Waddress_space && as1 != as2)
+			if (as1 != as2)
 				return "different address spaces";
 			if ((mod1 ^ mod2) & ~MOD_IGNORE & ~MOD_SIGNEDNESS)
 				return "different modifiers";
@@ -745,7 +745,7 @@ const char *type_difference(struct ctype *c1, struct ctype *c2,
 			break;
 		}
 		case SYM_BASETYPE:
-			if (Waddress_space && as1 != as2)
+			if (as1 != as2)
 				return "different address spaces";
 			if (base1 != base2)
 				return "different base types";
@@ -762,7 +762,7 @@ const char *type_difference(struct ctype *c1, struct ctype *c2,
 		t1 = base1;
 		t2 = base2;
 	}
-	if (Waddress_space && as1 != as2)
+	if (as1 != as2)
 		return "different address spaces";
 	if ((mod1 ^ mod2) & ~MOD_IGNORE & ~MOD_SIGNEDNESS)
 		return "different modifiers";
diff --git a/parse.c b/parse.c
index 14ae25d..9662122 100644
--- a/parse.c
+++ b/parse.c
@@ -987,7 +987,7 @@ static struct token *attribute_address_space(struct token *token, struct symbol
 	token = conditional_expression(token, &expr);
 	if (expr) {
 		as = const_expression_value(expr);
-		if (as)
+		if (Waddress_space && as)
 			ctx->ctype.as = as;
 	}
 	token = expect(token, ')', "after address_space attribute");
-- 
1.6.0.6


--MP_/inaJWFwBv/7NBpUe_.=_rZP--
