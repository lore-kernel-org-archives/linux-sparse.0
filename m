From: Bernd Petrovitsch <bernd@sysprog.at>
Subject: [PATCH] removed an unused parameter for show_symbol_list()
Date: Thu, 26 Aug 2010 12:31:38 +0200
Message-ID: <1282818698.12802.23.camel@thorin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:5857 "EHLO
	esgaroth.petrovitsch.priv.at" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753511Ab0HZKbk (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 26 Aug 2010 06:31:40 -0400
Received: from [172.16.0.10] (chello062178036229.13.11.wu-wien.teleweb.at [62.178.36.229])
	(authenticated bits=0)
	by esgaroth.petrovitsch.priv.at (8.14.1/8.14.1) with ESMTP id o7QAVdmk029493
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Thu, 26 Aug 2010 12:31:39 +0200
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi all!

A trivial patch to remove an unused parameter.

Is there some interest in patches to to be able to add -Wextra to gcc's
flags?

The main parts are
- lots of (other) unused parameters which can't be deleted. So they
  should be marked __attribute__((unused)) - either explicitely or
  with a "__unused" (or similar) macro.
- And largest thing is "signed vs unsigned" AFAICS. So is the strategy
  to use/convert to "unsigned" if it makes sense (like bits_in_*
  variables) or use "signed" everywhere?

	Bernd
---

 show-parse.c   |    2 +-
 symbol.h       |    2 +-
 test-parsing.c |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/show-parse.c b/show-parse.c
index eab07c7..de3fea0 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -127,7 +127,7 @@ static void show_struct_member(const struct symbol
*sym)
 	printf("\n");
 }
 
-void show_symbol_list(const struct symbol_list *list, const char *sep)
+void show_symbol_list(const struct symbol_list *list)
 {
 	struct symbol *sym;
 	const char *prepend = "";
diff --git a/symbol.h b/symbol.h
index 720ad10..9a6af9d 100644
--- a/symbol.h
+++ b/symbol.h
@@ -277,7 +277,7 @@ extern const char *modifier_string(unsigned long
mod);
 extern void show_symbol(const struct symbol *);
 extern int show_symbol_expr_init(const struct symbol *sym);
 extern void show_type_list(struct symbol *);
-extern void show_symbol_list(const struct symbol_list *, const char *);
+extern void show_symbol_list(const struct symbol_list *);
 extern void add_symbol(struct symbol_list **, struct symbol *);
 extern void bind_symbol(struct symbol *, struct ident *, enum
namespace);
 
diff --git a/test-parsing.c b/test-parsing.c
index 0a0b1d4..dc1b083 100644
--- a/test-parsing.c
+++ b/test-parsing.c
@@ -44,7 +44,7 @@ int main(int argc, char **argv)
 	clean_up_symbols(list);
 
 #if 1
-	show_symbol_list(list, "\n\n");
+	show_symbol_list(list);
 	printf("\n\n");
 #endif
 
@@ -56,7 +56,7 @@ int main(int argc, char **argv)
 
 #if 1
 		// Show the end result.
-		show_symbol_list(list, "\n\n");
+		show_symbol_list(list);
 		printf("\n\n");
 #endif
 	} END_FOR_EACH_PTR_NOTAG(file);
-- 
1.7.2.1


-- 
mobile: +43 664 4416156              http://www.sysprog.at/
    Linux Software Development, Consulting and Services

