From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH] Re: Fun with Linux 2.6.21-rc1
Date: Fri, 23 Feb 2007 14:30:27 -0800
Message-ID: <20070223223027.GA5671@chrisli.org>
References: <1172251518.6229.6.camel@dv> <1172260766.14431.3.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rwcrmhc14.comcast.net ([204.127.192.84]:51817 "EHLO
	rwcrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932686AbXBWXCV (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 23 Feb 2007 18:02:21 -0500
Content-Disposition: inline
In-Reply-To: <1172260766.14431.3.camel@dv>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josh@freedesktop.org>

On Fri, Feb 23, 2007 at 02:59:26PM -0500, Pavel Roskin wrote:
> P.S. The breakage has nothing to do to Linux changes.  It was caused by
> the patch called "Make the ptrlist using the sparse allocator".  Undoing
> the patch fixes the problem.
>

No, that was not it. The bug does not trigger if I remove "-O" or remove
the recent struct attribute patch.

You make me guilt for 5 mins. But the real bugs is match_idents did not
end with NULL.

This patch should fix it:

Chris

Fix a bug that match_idents forget to end with NULL

Pavel Roskin manage to hit this bug with

struct st {
       char c;
} __attribute__ ((aligned(2)));
struct st s1;
struct st s2;

Signed-Off-By: Christopher Li <sparse@chrisli.org>

Index: sparse/parse.c
===================================================================
--- sparse.orig/parse.c	2007-02-23 14:33:28.000000000 -0800
+++ sparse/parse.c	2007-02-23 14:36:16.000000000 -0800
@@ -861,7 +861,7 @@ static struct token *handle_attributes(s
 			apply_ctype(token->pos, &thistype, ctype);
 			continue;
 		}
-		if (match_idents(token, &asm_ident, &__asm_ident, &__asm___ident)) {
+		if (match_idents(token, &asm_ident, &__asm_ident, &__asm___ident, NULL)) {
 			struct expression *expr;
 			token = expect(token->next, '(', "after asm");
 			token = parse_expression(token->next, &expr);
