Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51636C433FE
	for <linux-sparse@archiver.kernel.org>; Tue,  2 Nov 2021 14:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CF3960E90
	for <linux-sparse@archiver.kernel.org>; Tue,  2 Nov 2021 14:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhKBOLl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 2 Nov 2021 10:11:41 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:58926 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231495AbhKBOLb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 2 Nov 2021 10:11:31 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-RxwX79zlM6-WkD0MS9tUBQ-1; Tue, 02 Nov 2021 10:08:54 -0400
X-MC-Unique: RxwX79zlM6-WkD0MS9tUBQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47882104337F;
        Tue,  2 Nov 2021 14:07:53 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.36.110.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B2CC6A242;
        Tue,  2 Nov 2021 14:07:51 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-sparse@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Subject: [PATCH 3/3] dissect: Show typedefs
Date:   Tue,  2 Nov 2021 15:06:45 +0100
Message-Id: <20211102140645.83081-4-gladkov.alexey@gmail.com>
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

For indexing purposes, it is useful to see type definitions.

$ semind search __kernel_ulong_t
(def) include/uapi/asm-generic/posix_types.h 16 23 typedef unsigned long   __kernel_ulong_t;

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 dissect.c      | 13 ++++++++++++-
 test-dissect.c |  2 ++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/dissect.c b/dissect.c
index 7d5d92c9..300d5ca9 100644
--- a/dissect.c
+++ b/dissect.c
@@ -615,6 +615,11 @@ static inline bool is_macro(struct symbol *sym)
 	return (sym->namespace == NS_MACRO || sym->namespace == NS_UNDEF);
 }
 
+static inline bool is_typedef(struct symbol *sym)
+{
+	return (sym->namespace == NS_TYPEDEF);
+}
+
 static inline struct symbol *do_symbol(struct symbol *sym)
 {
 	struct symbol *type = base_type(sym);
@@ -659,7 +664,7 @@ static void do_sym_list(struct symbol_list *list)
 
 static inline bool valid_namespace(enum namespace ns)
 {
-	return (ns == NS_MACRO || ns == NS_UNDEF || ns == NS_STRUCT || ns == NS_SYMBOL);
+	return (ns == NS_TYPEDEF || ns == NS_MACRO || ns == NS_UNDEF || ns == NS_STRUCT || ns == NS_SYMBOL);
 }
 
 static void do_file(char *file)
@@ -673,6 +678,12 @@ static void do_file(char *file)
 
 	DO_LIST(file_scope->symbols, sym,
 		if (input_streams[sym->pos.stream].fd != -1 && valid_namespace(sym->namespace)) {
+			if (is_typedef(sym)) {
+				sym->kind = 't';
+				reporter->r_symdef(sym);
+				continue;
+			}
+
 			if (is_macro(sym)) {
 				sym->kind = 'd';
 				reporter->r_symdef(sym);
diff --git a/test-dissect.c b/test-dissect.c
index 3d870a97..65b205f8 100644
--- a/test-dissect.c
+++ b/test-dissect.c
@@ -63,6 +63,8 @@ static void r_symbol(unsigned mode, struct position *pos, struct symbol *sym)
 		if (sym->type == SYM_STRUCT || sym->type == SYM_UNION)
 			break;
 		goto err;
+	case 't':
+		break;
 	case 'f':
 		if (sym->type != SYM_BAD && sym->ctype.base_type->type != SYM_FN)
 			goto err;
-- 
2.33.0

