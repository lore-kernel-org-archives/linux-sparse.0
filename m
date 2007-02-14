From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH] Re: __attribute__ annotations and struct types
Date: Wed, 14 Feb 2007 12:15:49 -0800
Message-ID: <20070214201549.GB18753@chrisli.org>
References: <1171483314.14504.9.camel@systems03.mmm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rwcrmhc14.comcast.net ([204.127.192.84]:49123 "EHLO
	rwcrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbXBNUpp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 14 Feb 2007 15:45:45 -0500
Content-Disposition: inline
In-Reply-To: <1171483314.14504.9.camel@systems03.mmm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Daniel Drake <ddrake@brontes3d.com>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josh@freedesktop.org>

On Wed, Feb 14, 2007 at 03:01:54PM -0500, Daniel Drake wrote:
> sparse doesn't like it:
> 
> 	test.c:7:8: error: Trying to use reserved word '__attribute__' 
> 	as identifier

Can you please try this:

Chris

Handle structure attribute.

struct __attribute__((__aligned__(16))) foo {
    int a;
};

Signed-Off-By: Christopher Li <sparse@chrisli.org>

Index: sparse/parse.c
===================================================================
--- sparse.orig/parse.c	2007-02-14 12:37:17.000000000 -0800
+++ sparse/parse.c	2007-02-14 12:40:48.000000000 -0800
@@ -34,6 +34,7 @@ struct symbol_list *function_computed_ta
 struct statement_list *function_computed_goto_list;
 
 static struct token *statement(struct token *token, struct statement **tree);
+static struct token *handle_attributes(struct token *token, struct ctype *ctype);
 
 // Add a symbol to the list of function-local symbols
 static void fn_local_symbol(struct symbol *sym)
@@ -156,6 +157,7 @@ static struct token *struct_union_enum_s
 	struct position *repos;
 
 	ctype->modifiers = 0;
+	token = handle_attributes(token, ctype);
 	if (token_type(token) == TOKEN_IDENT) {
 		sym = lookup_symbol(token->ident, NS_STRUCT);
 		if (!sym ||
