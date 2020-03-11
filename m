From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] Add symantic index utility
Date: Wed, 11 Mar 2020 13:04:27 +0100
Message-ID: <20200311120427.GB19327@redhat.com>
References: <20200309152509.6707-1-gladkov.alexey@gmail.com>
 <20200309223701.dbnej7esb4qp56bm@ltop.local>
 <20200310150713.GB19012@redhat.com>
 <20200310171202.y5rhsydmmbewoarm@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41411 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729084AbgCKMEf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 11 Mar 2020 08:04:35 -0400
In-Reply-To: <20200310171202.y5rhsydmmbewoarm@ltop.local>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

On 03/10, Luc Van Oostenryck wrote:
>
> Anyway, only a warning should be issued (I'll send a patch for this).
> I also wouldn't mind to add a new warning flag to suppress it,
> something like -Wno-directive-within-macro.

OK, agreed. something like below?

Oleg.

diff --git a/lib.c b/lib.c
index f15e4d99..264a890e 100644
--- a/lib.c
+++ b/lib.c
@@ -264,6 +264,7 @@ int Wdecl = 1;
 int Wdeclarationafterstatement = -1;
 int Wdefault_bitfield_sign = 0;
 int Wdesignated_init = 1;
+int Wdirective_within_macro = 1;
 int Wdo_while = 0;
 int Wimplicit_int = 1;
 int Winit_cstring = 0;
@@ -740,6 +741,7 @@ static const struct flag warnings[] = {
 	{ "declaration-after-statement", &Wdeclarationafterstatement },
 	{ "default-bitfield-sign", &Wdefault_bitfield_sign },
 	{ "designated-init", &Wdesignated_init },
+	{ "directive-within-macro", &Wdirective_within_macro },
 	{ "do-while", &Wdo_while },
 	{ "enum-mismatch", &Wenum_mismatch },
 	{ "external-function-has-definition", &Wexternal_function_has_definition },
diff --git a/lib.h b/lib.h
index 72651cef..49db0117 100644
--- a/lib.h
+++ b/lib.h
@@ -153,6 +153,7 @@ extern int Wdecl;
 extern int Wdeclarationafterstatement;
 extern int Wdefault_bitfield_sign;
 extern int Wdesignated_init;
+extern int Wdirective_within_macro;
 extern int Wdo_while;
 extern int Wenum_mismatch;
 extern int Wexternal_function_has_definition;
diff --git a/pre-process.c b/pre-process.c
index 433d1bf8..e79a447a 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -271,8 +271,9 @@ static struct token *collect_arg(struct token *prev, int vararg, struct position
 	while (!eof_token(next = scan_next(p))) {
 		if (next->pos.newline && match_op(next, '#')) {
 			if (!next->pos.noexpand) {
-				sparse_error(next->pos,
-					     "directive in macro's argument list");
+				if (Wdirective_within_macro)
+					warning(next->pos,
+						"directive in macro's argument list");
 				preprocessor_line(stream, p);
 				__free_token(next);	/* Free the '#' token */
 				continue;
