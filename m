Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07F2C433F5
	for <linux-sparse@archiver.kernel.org>; Tue,  2 Nov 2021 14:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC02560F58
	for <linux-sparse@archiver.kernel.org>; Tue,  2 Nov 2021 14:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhKBOMW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 2 Nov 2021 10:12:22 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:42767 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230257AbhKBOMW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 2 Nov 2021 10:12:22 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-8Hzs58R7O-GzEK3NfkDYTA-1; Tue, 02 Nov 2021 10:09:44 -0400
X-MC-Unique: 8Hzs58R7O-GzEK3NfkDYTA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7162E136435;
        Tue,  2 Nov 2021 14:07:51 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.36.110.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3586B67855;
        Tue,  2 Nov 2021 14:07:50 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-sparse@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Subject: [PATCH 2/3] dissect: Show macro definitions
Date:   Tue,  2 Nov 2021 15:06:44 +0100
Message-Id: <20211102140645.83081-3-gladkov.alexey@gmail.com>
In-Reply-To: <20211102140645.83081-1-gladkov.alexey@gmail.com>
References: <20211102140645.83081-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=gladkov.alexey@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Add the ability to dissect to see macro definitions. The patch does not
add full support for the usage of macros, but only their definitions.

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 dissect.c      | 13 ++++++++++++-
 test-dissect.c |  3 ++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/dissect.c b/dissect.c
index 0d6c3288..7d5d92c9 100644
--- a/dissect.c
+++ b/dissect.c
@@ -610,6 +610,11 @@ static struct symbol *do_initializer(struct symbol *type, struct expression *exp
 	return type;
 }
 
+static inline bool is_macro(struct symbol *sym)
+{
+	return (sym->namespace == NS_MACRO || sym->namespace == NS_UNDEF);
+}
+
 static inline struct symbol *do_symbol(struct symbol *sym)
 {
 	struct symbol *type = base_type(sym);
@@ -654,7 +659,7 @@ static void do_sym_list(struct symbol_list *list)
 
 static inline bool valid_namespace(enum namespace ns)
 {
-	return (ns == NS_STRUCT || ns == NS_SYMBOL);
+	return (ns == NS_MACRO || ns == NS_UNDEF || ns == NS_STRUCT || ns == NS_SYMBOL);
 }
 
 static void do_file(char *file)
@@ -668,6 +673,12 @@ static void do_file(char *file)
 
 	DO_LIST(file_scope->symbols, sym,
 		if (input_streams[sym->pos.stream].fd != -1 && valid_namespace(sym->namespace)) {
+			if (is_macro(sym)) {
+				sym->kind = 'd';
+				reporter->r_symdef(sym);
+				continue;
+			}
+
 			if (sym->type == SYM_STRUCT || sym->type == SYM_UNION) {
 				sym->ctype.base_type = sym;
 				examine_sym_node(sym, NULL);
diff --git a/test-dissect.c b/test-dissect.c
index 58b3e633..3d870a97 100644
--- a/test-dissect.c
+++ b/test-dissect.c
@@ -57,11 +57,12 @@ static void r_symbol(unsigned mode, struct position *pos, struct symbol *sym)
 		show_typename(sym->ctype.base_type));
 
 	switch (sym->kind) {
+	case 'd':
+		break;
 	case 's':
 		if (sym->type == SYM_STRUCT || sym->type == SYM_UNION)
 			break;
 		goto err;
-
 	case 'f':
 		if (sym->type != SYM_BAD && sym->ctype.base_type->type != SYM_FN)
 			goto err;
-- 
2.33.0

