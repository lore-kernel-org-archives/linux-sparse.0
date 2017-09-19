From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] remove prototype extern int is_ptr_type()
Date: Tue, 19 Sep 2017 05:08:39 +0200
Message-ID: <20170919030840.12525-2-luc.vanoostenryck@gmail.com>
References: <20170919030840.12525-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35523 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750921AbdISDIq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 Sep 2017 23:08:46 -0400
Received: by mail-wr0-f193.google.com with SMTP id n64so1402924wrb.2
        for <linux-sparse@vger.kernel.org>; Mon, 18 Sep 2017 20:08:46 -0700 (PDT)
In-Reply-To: <20170919030840.12525-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

because the function was already defined as an inline function
in the same header file.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/symbol.h b/symbol.h
index 327449611..614763404 100644
--- a/symbol.h
+++ b/symbol.h
@@ -438,7 +438,6 @@ static inline struct symbol *lookup_keyword(struct ident *ident, enum namespace
 #define is_restricted_type(type) (get_sym_type(type) == SYM_RESTRICT)
 #define is_fouled_type(type) (get_sym_type(type) == SYM_FOULED)
 #define is_bitfield_type(type)   (get_sym_type(type) == SYM_BITFIELD)
-extern int is_ptr_type(struct symbol *);
 
 void create_fouled(struct symbol *type);
 struct symbol *befoul(struct symbol *type);
-- 
2.14.0

