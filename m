From: Luc Van Oostenryck <luc.vanoostenryck@looxix.net>
Subject: Try to teach sparse about construct like 'struct __attribute__((foo)) bar'
Date: Wed, 18 Jan 2006 01:39:43 +0100
Message-ID: <20060118003942.GA1419@ralph05.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp3.mail.be.easynet.net ([212.100.160.66]:8942 "EHLO
	smtp3.mail.be.easynet.net") by vger.kernel.org with ESMTP
	id S932436AbWARAic (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 17 Jan 2006 19:38:32 -0500
Received: from [81.188.80.169] (helo=ralph05.pc.home)
	by smtp3.mail.be.easynet.net with esmtp (Exim 4.60)
	(envelope-from <luc.vanoostenryck@looxix.net>)
	id 1Ez1LL-00057d-7i
	for linux-sparse@vger.kernel.org; Wed, 18 Jan 2006 01:38:31 +0100
Received: from luc by ralph05.pc.home with local (Exim 4.10)
	id 1Ez1MV-0000Mw-00
	for linux-sparse@vger.kernel.org; Wed, 18 Jan 2006 01:39:43 +0100
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

On the current linux git tree, sparse spit a lot of errors:
	include/asm/lppaca.h:34:8: error: Trying to use reserved word '__attribute__' as identifier

which is caused by a declaration:
	struct __attribute__((__aligned__(0x400))) lppaca {

The following patch seems to solve the symptom but I'm not sure that the ctype
is not handled correctly.
Also, now sparse produce a lot of others errors, mainly about address space
mismatch like:
	init/do_mounts.c:69:16: warning: incorrect type in argument 1 (different address spaces)
	init/do_mounts.c:69:16:    expected char const [noderef] *filename<asn:1>
	init/do_mounts.c:69:16:    got char *<noident>

What is strange is that these warning seems to be about a real address space problem
but why sparse didn't warn before?
(IIRC, the warnings in init/do_mounts.c were reported by sparse some time ago).


Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@looxix.net>

---


diff --git a/parse.c b/parse.c
index d871afd..3c071d6 100644
--- a/parse.c
+++ b/parse.c
@@ -34,6 +34,7 @@ struct symbol_list *function_computed_ta
 struct statement_list *function_computed_goto_list;
 
 static struct token *statement(struct token *token, struct statement **tree);
+static struct token *handle_attributes(struct token *token, struct ctype *ctype);
 
 // Add a symbol to the list of function-local symbols
 static void fn_local_symbol(struct symbol *sym)
@@ -112,6 +113,7 @@ static struct token *struct_union_enum_s
 	struct position *repos;
 
 	ctype->modifiers = 0;
+	token = handle_attributes(token, ctype);
 	if (token_type(token) == TOKEN_IDENT) {
 		sym = lookup_symbol(token->ident, NS_STRUCT);
 		if (!sym ||

