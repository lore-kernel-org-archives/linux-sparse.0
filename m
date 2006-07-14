From: Pavel Roskin <proski@gnu.org>
Subject: [RFC PATCH] Fix -Wtypesign
Date: Thu, 13 Jul 2006 21:56:18 -0400
Message-ID: <1152842178.480.26.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:16877 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1161167AbWGNB40
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 13 Jul 2006 21:56:26 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1G1Cun-0001z7-ER
	for linux-sparse@vger.kernel.org; Thu, 13 Jul 2006 21:56:25 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1G1Cug-0007W4-LM
	for linux-sparse@vger.kernel.org; Thu, 13 Jul 2006 21:56:18 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hello!

The current sparse has problems with the -Wtypesign flag.  If causes
bogus warnings.  Take for example following test.c:

static unsigned char foobar(void);
static unsigned char foobar(void)
{
	return 0;
}

$ sparse -Wtypesign test.c
test.c:2:22: error: symbol 'foobar' redeclared with different type
(originally declared at test.c:1) - different signedness

Debugging shows that the function definition doesn't have the
signed/unsigned modifiers, unlike the function declaration:

2412                    typediff = type_difference(sym, next, 0, 0);
(gdb) p/ sym->ctype.modifiers
$1 = 0x800004
(gdb) p/ next->ctype.modifiers
$2 = 0x800084

0x80 is MOD_UNSIGNED.

The signedness modifiers are set in evaluate_symbol(), which hasn't been
called for sym yet.  I have devised following patch, that appears to fix
the problem:

---
Fix -Wtypesign

Run evaluate_symbol() before check_duplicates() so that the signedness
of the token is known by the time the token is compared with other
tokens.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 evaluate.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 42005eb..2561f38 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2473,8 +2473,8 @@ void evaluate_symbol_list(struct symbol_
 	struct symbol *sym;
 
 	FOR_EACH_PTR(list, sym) {
-		check_duplicates(sym);
 		evaluate_symbol(sym);
+		check_duplicates(sym);
 	} END_FOR_EACH_PTR(sym);
 }

I tested -Wtypesign on some Linux drivers.  It found some real sign
mismatches and no bogus warnings.

Still, I haven't seen sparse code until today, so the patch should be
evaluated carefully.

-- 
Regards,
Pavel Roskin
