Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403D2C433EF
	for <linux-sparse@archiver.kernel.org>; Tue,  2 Nov 2021 14:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24D2060F90
	for <linux-sparse@archiver.kernel.org>; Tue,  2 Nov 2021 14:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhKBOMI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 2 Nov 2021 10:12:08 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:60748 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231661AbhKBOME (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 2 Nov 2021 10:12:04 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-llzvscCSNAadcKkhENCGlQ-1; Tue, 02 Nov 2021 10:09:22 -0400
X-MC-Unique: llzvscCSNAadcKkhENCGlQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA2778C365F;
        Tue,  2 Nov 2021 14:07:49 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.36.110.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9CCEC6785A;
        Tue,  2 Nov 2021 14:07:48 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-sparse@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Subject: [PATCH 1/3] dissect: Allow to show all symbols
Date:   Tue,  2 Nov 2021 15:06:43 +0100
Message-Id: <20211102140645.83081-2-gladkov.alexey@gmail.com>
In-Reply-To: <20211102140645.83081-1-gladkov.alexey@gmail.com>
References: <20211102140645.83081-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Currently dissect sees only used symbols. For indexing purposes, it is
useful to see all declared symbols.

$ nl -s\  -w2 ./z.c
 1 struct foo {
 2         int member;
 3 };
 4 #ifdef OPT
 5 static void func1(void) {
 6         struct foo *x;
 7         return 0;
 8 }
 9 #endif
10 static inline void func2(void) { return; }
11 void func(void) { return; }

$ ./test-dissect ./z.c

FILE: ./z.c

  11:6                    def   f func                             void ( ... )

$ ./test-dissect --param=dissect-show-all-symbols ./z.c

FILE: ./z.c

   1:8                    def   s foo                              struct foo
   2:13                   def   m foo.member                       int
  10:20                   def   f func2                            void ( ... )
  11:6                    def   f func                             void ( ... )

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 dissect.c | 39 ++++++++++++++++++++++++++++++++++++++-
 options.c |  5 +++++
 options.h |  2 ++
 semind.c  |  1 +
 4 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/dissect.c b/dissect.c
index 582e8fc3..0d6c3288 100644
--- a/dissect.c
+++ b/dissect.c
@@ -652,9 +652,46 @@ static void do_sym_list(struct symbol_list *list)
 	DO_LIST(list, sym, do_symbol(sym));
 }
 
+static inline bool valid_namespace(enum namespace ns)
+{
+	return (ns == NS_STRUCT || ns == NS_SYMBOL);
+}
+
+static void do_file(char *file)
+{
+	struct symbol_list *res = sparse_keep_tokens(file);
+
+	if (!dissect_show_all_symbols) {
+		do_sym_list(res);
+		goto end;
+	}
+
+	DO_LIST(file_scope->symbols, sym,
+		if (input_streams[sym->pos.stream].fd != -1 && valid_namespace(sym->namespace)) {
+			if (sym->type == SYM_STRUCT || sym->type == SYM_UNION) {
+				sym->ctype.base_type = sym;
+				examine_sym_node(sym, NULL);
+				continue;
+			}
+
+			do_symbol(sym);
+		}
+	);
+
+	DO_LIST(global_scope->symbols, sym,
+		if (input_streams[sym->pos.stream].fd != -1 && valid_namespace(sym->namespace)) {
+			do_symbol(sym);
+		}
+	);
+
+end:
+	/* Drop the tokens for this file after parsing */
+	clear_token_alloc();
+}
+
 void dissect(struct reporter *rep, struct string_list *filelist)
 {
 	reporter = rep;
 
-	DO_LIST(filelist, file, do_sym_list(__sparse(file)));
+	DO_LIST(filelist, file, do_file(file));
 }
diff --git a/options.c b/options.c
index 6704fc8d..b4684357 100644
--- a/options.c
+++ b/options.c
@@ -70,6 +70,8 @@ int dbg_postorder = 0;
 int dump_macro_defs = 0;
 int dump_macros_only = 0;
 
+int dissect_show_all_symbols = 0;
+
 unsigned long fdump_ir;
 int fhosted = 1;
 unsigned int fmax_errors = 100;
@@ -958,6 +960,9 @@ static char **handle_param(char *arg, char **next)
 	if (!value)
 		die("missing argument for --param option");
 
+	if (!strcmp(value, "dissect-show-all-symbols"))
+		dissect_show_all_symbols = 1;
+
 	return next;
 }
 
diff --git a/options.h b/options.h
index 0aec8764..c2a9551a 100644
--- a/options.h
+++ b/options.h
@@ -70,6 +70,8 @@ extern int dbg_postorder;
 extern int dump_macro_defs;
 extern int dump_macros_only;
 
+extern int dissect_show_all_symbols;
+
 extern unsigned long fdump_ir;
 extern int fhosted;
 extern unsigned int fmax_errors;
diff --git a/semind.c b/semind.c
index 911fc747..ad8003ba 100644
--- a/semind.c
+++ b/semind.c
@@ -329,6 +329,7 @@ done:
 	optind--;
 
 	sparse_initialize(argc - optind, argv + optind, &semind_filelist);
+	dissect_show_all_symbols = 1;
 }
 
 static void parse_cmdline_rm(int argc, char **argv)
-- 
2.33.0

