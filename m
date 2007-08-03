From: Rob Taylor <rob.taylor@codethink.co.uk>
Subject: Re: Antwort: Re: Finding all typedefs
Date: Fri, 03 Aug 2007 01:49:19 +0100
Message-ID: <46B27B8F.2040008@codethink.co.uk>
References: <OF8B0579A2.47A003A7-ONC125732B.00280B65-C125732B.00295803@br-automation.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010001070006030601080307"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from 208-78-103-131.slicehost.net ([208.78.103.131]:46771 "EHLO
	mail.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110AbXHCAqz (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 2 Aug 2007 20:46:55 -0400
In-Reply-To: <OF8B0579A2.47A003A7-ONC125732B.00280B65-C125732B.00295803@br-automation.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Thomas Schmid <Thomas.Schmid@br-automation.com>
Cc: linux-sparse@vger.kernel.org, Pavel Roskin <proski@gnu.org>, Josh Triplett <josht@linux.vnet.ibm.com>

This is a multi-part message in MIME format.
--------------010001070006030601080307
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Thomas Schmid wrote:
> linux-sparse-owner@vger.kernel.org schrieb am 02.08.2007 02:15:34:
> 
>> Another annoying thing is that the types are always resolved for
>> typedefs. i.e. for
>>
>> typedef int foo;
>> foo bar;
>>
>> the symbol for bar has a base type of int.
> 
> ...and a base_type->ident named "foo". But if you add another typedef on 
> "int", i.e.
> 
>         typedef int DINT; 
> 
> base_type->ident changes to "DINT", now there's no way to get out, that 
> symbol "bar" was declared with "foo".
> Tell me if I'm wrong, but a solution for this would also help me on that:
> http://marc.info/?l=linux-sparse&m=118171213001092&w=2
> 
>> Any suggestions for how to solve this would be greatly appreciated :)
> I agree! ;-)


Ok, I've hacked up a little patch that does a small bit of the job
(attached), but this breaks comparisons to abstract types (and probably
a whole load more besides). I'll carry on hacking this some more and see
if I can sort those issues, but I'd greatly appreciate some input from
anyone with deeper knowledge!

Thanks,
Rob Taylor

--------------010001070006030601080307
Content-Type: text/x-patch;
 name="0001-cracked-ideas-to-track-user-types.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-cracked-ideas-to-track-user-types.patch"

From 06cae878ce87d71bb5c827c4e8df7f3e5a1df40f Mon Sep 17 00:00:00 2001
From: Rob Taylor <rob.taylor@codethink.co.uk>
Date: Fri, 3 Aug 2007 01:37:58 +0100
Subject: [PATCH] cracked ideas to track user types.

---
 c2xml.c |    6 ++++--
 parse.c |    7 +++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/c2xml.c b/c2xml.c
index 37f29cf..42f059e 100644
--- a/c2xml.c
+++ b/c2xml.c
@@ -166,8 +166,6 @@ static void examine_symbol(struct symbol *sym, xmlNodePtr node)
 		return;
 
 	child = new_sym_node(sym, get_type_name(sym->type), node);
-	examine_modifiers(sym, child);
-	examine_layout(sym, child);
 
 	if (sym->ctype.base_type) {
 		if ((base = builtin_typename(sym->ctype.base_type)) == NULL) {
@@ -199,6 +197,10 @@ static void examine_symbol(struct symbol *sym, xmlNodePtr node)
 		newProp(child, "base-type-builtin", builtin_typename(sym));
 		break;
 	}
+
+	examine_modifiers(sym, child);
+	examine_layout(sym, child);
+
 	return;
 }
 
diff --git a/parse.c b/parse.c
index f452042..1ac7586 100644
--- a/parse.c
+++ b/parse.c
@@ -1101,12 +1101,15 @@ static struct token *declaration_specifiers(struct token *next, struct ctype *ct
 				break;
 			if (ctype->base_type)
 				break;
-			/* User types only mix with qualifiers */
 			if (mod & MOD_USERTYPE) {
+				/* User types only mix with qualifiers */
 				if (ctype->modifiers & MOD_SPECIFIER)
 					break;
+				/* Point to the user type */
+				ctype->base_type = s;
 			}
-			ctype->base_type = type;
+			else
+				ctype->base_type = type;
 		}
 
 		check_modifiers(&token->pos, s, ctype->modifiers);
-- 
1.5.3.GIT


--------------010001070006030601080307--
