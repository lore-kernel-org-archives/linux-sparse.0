From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] parse: support c99 [static ...] in abstract array declarators
Date: Wed, 16 Apr 2014 23:50:15 -0700
Message-ID: <CANeU7Q=qfD=fpP1k1gHpUxek4ZUuau3drCDncYr5eE18Xiq4Zw@mail.gmail.com>
References: <1397603337-28016-1-git-send-email-cody@linux.vnet.ibm.com>
	<20140417001234.GA18426@leaf>
	<534F4F7F.5020506@linux.vnet.ibm.com>
	<20140417050914.GA21150@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:49713 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbaDQGuQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 17 Apr 2014 02:50:16 -0400
Received: by mail-qa0-f43.google.com with SMTP id j15so29615qaq.30
        for <linux-sparse@vger.kernel.org>; Wed, 16 Apr 2014 23:50:15 -0700 (PDT)
In-Reply-To: <20140417050914.GA21150@leaf>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Cody P Schafer <cody@linux.vnet.ibm.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Apr 16, 2014 at 10:09 PM, Josh Triplett <josh@joshtriplett.org> wrote:
>> I could have sparse be just as strict as the standard, it just was just
>> (much) simpler to make it liberal in what it accepts. If you're fine with
>> some more verbose code, I'll put together something that is stricter.
>
> I'd suggest trying to match the standard in this case, or failing that
> match what GCC does.

I second that. It does not seem too complicate to make sparse accept
"static" in two possible position.

Here is a purpose patch with limited test. I expand the test to cover
more static test case.

Cody, does this patch work for you?

Chris

diff --git a/parse.c b/parse.c
index 70553f2..76aba40 100644
--- a/parse.c
+++ b/parse.c
@@ -1533,12 +1533,28 @@ static struct token
*declaration_specifiers(struct token *tok
        return token;
 }

+static struct token *abstract_array_static_declarator(struct token
*token, int *has_
+{
+       while (token->ident == &static_ident) {
+               if (*has_static)
+                       warning(token->pos, "duplicate array static
declarator");
+
+               *has_static = 1;
+               token = token->next;
+       }
+       return token;
+
+}
+
 static struct token *abstract_array_declarator(struct token *token,
struct symbol *s
 {
        struct expression *expr = NULL;
+       int has_static = 0;

-       while (match_idents(token, &restrict_ident, &__restrict_ident,
&static_ident,
-               token = token->next;
+       token = abstract_array_static_declarator(token, &has_static);
+
+       if (match_idents(token, &restrict_ident, &__restrict_ident, NULL))
+               token = abstract_array_static_declarator(token->next,
&has_static);
        token = parse_expression(token, &expr);
        sym->array_size = expr;
        return token;
diff --git a/validation/abstract-array-declarator-static.c
b/validation/abstract-arra
index 23cbae0..b0af17b 100644
--- a/validation/abstract-array-declarator-static.c
+++ b/validation/abstract-array-declarator-static.c
@@ -1,6 +1,14 @@

-extern void f(int g[static 1]);
+extern void f1(int g[static 1]);
+extern void f2(int g[static restrict 1]);
+extern void f3(int g[restrict static 1]);
+extern void f4(int g[static restrict static 1]);       /* duplicate
static error */
+extern void f5(int g[restrict static static 1]);       /* duplicate
static error */

 /*
  * check-name: abstract array declarator static
+ * check-error-start
+abstract-array-declarator-static.c:5:38: warning: duplicate array
static declarator
+abstract-array-declarator-static.c:6:38: warning: duplicate array
static declarator
+ * check-error-end
  */
