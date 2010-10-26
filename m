From: Christopher Li <sparse@chrisli.org>
Subject: Re: bad asm goto ?
Date: Mon, 25 Oct 2010 20:10:02 -0700
Message-ID: <AANLkTik3OLbW=sM1PFi8uazBHiJbPD06d0ns2z0DQzzN@mail.gmail.com>
References: <20101025213145.GA1822@redhat.com>
	<AANLkTikVt5BJ+2W3P+wYUR3DLzhTatXhAW45wdc0eoOe@mail.gmail.com>
	<20101025223957.GA5561@redhat.com>
	<AANLkTi=r6U3CVS5Br5ZTVVyNEfKzhqTcKkEk5+itwNe1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35037 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753989Ab0JZDKD (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Oct 2010 23:10:03 -0400
Received: by iwn10 with SMTP id 10so1568911iwn.19
        for <linux-sparse@vger.kernel.org>; Mon, 25 Oct 2010 20:10:02 -0700 (PDT)
In-Reply-To: <AANLkTi=r6U3CVS5Br5ZTVVyNEfKzhqTcKkEk5+itwNe1@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: linux-sparse@vger.kernel.org

It seems that the error is not from the goto. It is from the malformed
asm_clobber.
For empty asm_clobber list, sparse currently add nil expr into the
list. Evaluate will
complain about the nil pointer thinking it has a bad type.

Any way, this patch should fix it.

Please let me know that help you or not. I am going to apply it after
the 0.4.3 release.

Chris

diff --git a/evaluate.c b/evaluate.c
index f8343c2..1fb03ed 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3221,7 +3221,7 @@ static void evaluate_asm_statement(struct statement *stmt)

 	FOR_EACH_PTR(stmt->asm_clobbers, expr) {
 		if (!expr) {
-			sparse_error(stmt->pos, "bad asm output");
+			sparse_error(stmt->pos, "bad asm clobbers");
 			return;
 		}
 		if (expr->type == EXPR_STRING)
diff --git a/parse.c b/parse.c
index 537055f..6b7d656 100644
--- a/parse.c
+++ b/parse.c
@@ -1894,7 +1894,8 @@ static struct token *parse_asm_clobbers(struct
token *token, struct statement *s

 	do {
 		token = primary_expression(token->next, &expr);
-		add_expression(clobbers, expr);
+		if (expr)
+			add_expression(clobbers, expr);
 	} while (match_op(token, ','));
 	return token;
 }
