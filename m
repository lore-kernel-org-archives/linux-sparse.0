From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH] sparse: add __builtin_va_arg_pack() and __builtin_va_arg_pack_len()
Date: Thu, 18 Jul 2013 11:36:39 -0400
Message-ID: <1374161799-2929-1-git-send-email-jlayton@redhat.com>
References: <20130718084743.727666bc@tlielax.poochiereds.net>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ye0-f171.google.com ([209.85.213.171]:56305 "EHLO
	mail-ye0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754515Ab3GRPgq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 18 Jul 2013 11:36:46 -0400
Received: by mail-ye0-f171.google.com with SMTP id q14so988247yen.30
        for <linux-sparse@vger.kernel.org>; Thu, 18 Jul 2013 08:36:45 -0700 (PDT)
In-Reply-To: <20130718084743.727666bc@tlielax.poochiereds.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Pekka Enberg <penberg@kernel.org>

this patch stops sparse from complaining about them not being defined:

    /usr/include/bits/stdio2.h:98:25: error: undefined identifier '__builtin_va_arg_pack'
    /usr/include/bits/stdio2.h:98:25: error: not a function <noident>

Probably, there is some better way to do this that actually validates
this function, but I'm not clear on how to do it.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 lib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib.c b/lib.c
index 7e822eb..3f687ae 100644
--- a/lib.c
+++ b/lib.c
@@ -777,6 +777,7 @@ void declare_builtin_functions(void)
 	add_pre_buffer("extern long __builtin_alpha_cmpbge(long, long);\n");
 	add_pre_buffer("extern long __builtin_labs(long);\n");
 	add_pre_buffer("extern double __builtin_fabs(double);\n");
+	add_pre_buffer("extern __SIZE_TYPE__ __builtin_va_arg_pack_len(void);\n");
 	add_pre_buffer("extern void __sync_synchronize();\n");
 	add_pre_buffer("extern int __sync_bool_compare_and_swap(void *, ...);\n");
 
@@ -876,6 +877,7 @@ void create_builtin_stream(void)
 	add_pre_buffer("#define __builtin_va_copy(dest, src) ({ dest = src; (void)0; })\n");
 	add_pre_buffer("#define __builtin_va_end(arg)\n");
 	add_pre_buffer("#define __builtin_ms_va_end(arg)\n");
+	add_pre_buffer("#define __builtin_va_arg_pack()\n");
 
 	/* FIXME! We need to do these as special magic macros at expansion time! */
 	add_pre_buffer("#define __BASE_FILE__ \"base_file.c\"\n");
-- 
1.8.3.1

