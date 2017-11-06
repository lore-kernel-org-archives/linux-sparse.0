From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] builtin: add ctype for const {void,char} *
Date: Mon,  6 Nov 2017 21:16:27 +0100
Message-ID: <20171106201628.98470-2-luc.vanoostenryck@gmail.com>
References: <20171106201628.98470-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54400 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932463AbdKFUSl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Nov 2017 15:18:41 -0500
Received: by mail-wm0-f67.google.com with SMTP id r68so16776869wmr.3
        for <linux-sparse@vger.kernel.org>; Mon, 06 Nov 2017 12:18:41 -0800 (PST)
In-Reply-To: <20171106201628.98470-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

These types are needed to declare builtin functions without
passing by the add_pre_buffer()-tokenization-parsing phases.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.c | 4 ++++
 symbol.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/symbol.c b/symbol.c
index 26906ec41..4aa7f08a9 100644
--- a/symbol.c
+++ b/symbol.c
@@ -677,6 +677,7 @@ struct symbol	bool_ctype, void_ctype, type_ctype,
 		string_ctype, ptr_ctype, lazy_ptr_ctype,
 		incomplete_ctype, label_ctype, bad_ctype,
 		null_ctype;
+struct symbol	const_ptr_ctype, const_string_ctype;
 
 struct symbol	zero_int;
 
@@ -743,6 +744,9 @@ static const struct ctype_declare {
 	{ &null_ctype,	    SYM_PTR,	  0,			    &bits_in_pointer,        &pointer_alignment, &void_ctype },
 	{ &label_ctype,	    SYM_PTR,	  0,			    &bits_in_pointer,        &pointer_alignment, &void_ctype },
 	{ &lazy_ptr_ctype,  SYM_PTR,	  0,			    &bits_in_pointer,        &pointer_alignment, &void_ctype },
+
+	{ &const_ptr_ctype, SYM_NODE,	  MOD_CONST,		    &bits_in_pointer,        &pointer_alignment, &ptr_ctype },
+	{ &const_string_ctype,SYM_NODE,	  MOD_CONST,		    &bits_in_pointer,        &pointer_alignment, &string_ctype },
 	{ NULL, }
 };
 #undef MOD_LLL
diff --git a/symbol.h b/symbol.h
index 327449611..c1ef447ac 100644
--- a/symbol.h
+++ b/symbol.h
@@ -269,6 +269,7 @@ extern struct symbol	bool_ctype, void_ctype, type_ctype,
 			string_ctype, ptr_ctype, lazy_ptr_ctype,
 			incomplete_ctype, label_ctype, bad_ctype,
 			null_ctype;
+extern struct symbol	const_ptr_ctype, const_string_ctype;
 
 /* Special internal symbols */
 extern struct symbol	zero_int;
-- 
2.14.0

