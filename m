From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/3] fix definition of __SCHAR_MAX__ & friends
Date: Fri, 19 May 2017 13:20:53 +0200
Message-ID: <20170519112053.24632-4-luc.vanoostenryck@gmail.com>
References: <20170519112053.24632-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:32775 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754418AbdESLVH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 19 May 2017 07:21:07 -0400
Received: by mail-wr0-f194.google.com with SMTP id w50so2620177wrc.0
        for <linux-sparse@vger.kernel.org>; Fri, 19 May 2017 04:21:06 -0700 (PDT)
In-Reply-To: <20170519112053.24632-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The predefined macros __SCHAR_MAX__, __SHRT_MAX__, __WCHAR_MAX__ &
__CHAR_BIT__ are defined based on the size of these types on
the machine where sparse was compiled.

But since sparse has flags like -m32/-m64 and it's not unlikely
to have one day a flag like -march=<some arch>, better to use
the used by sparse for these types as stored in 'bits_in_char',
'bits_in_short', ...

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/lib.c b/lib.c
index 20eb72e95..99ecdcc4a 100644
--- a/lib.c
+++ b/lib.c
@@ -832,11 +832,16 @@ static void predefined_sizeof(const char *name, unsigned bits)
 	add_pre_buffer("#weak_define __SIZEOF_%s__ %d\n", name, bits/8);
 }
 
-static void predefined_type_size(const char *name, const char *suffix, unsigned bits)
+static void predefined_max(const char *name, const char *suffix, unsigned bits)
 {
 	unsigned long long max = (1ULL << (bits - 1 )) - 1;
 
 	add_pre_buffer("#weak_define __%s_MAX__ %#llx%s\n", name, max, suffix);
+}
+
+static void predefined_type_size(const char *name, const char *suffix, unsigned bits)
+{
+	predefined_max(name, suffix, bits);
 	predefined_sizeof(name, bits);
 }
 
@@ -845,6 +850,10 @@ static void predefined_macros(void)
 	add_pre_buffer("#define __CHECKER__ 1\n");
 
 	predefined_sizeof("SHORT", bits_in_short);
+	predefined_max("SHRT", "", bits_in_short);
+	predefined_max("SCHAR", "", bits_in_char);
+	predefined_max("WCHAR", "", bits_in_wchar);
+	add_pre_buffer("#weak_define __CHAR_BIT__ %d\n", bits_in_char);
 
 	predefined_type_size("INT", "", bits_in_int);
 	predefined_type_size("LONG", "L", bits_in_long);
@@ -1068,12 +1077,6 @@ void create_builtin_stream(void)
 		add_pre_buffer("#define __OPTIMIZE__ 1\n");
 	if (optimize_size)
 		add_pre_buffer("#define __OPTIMIZE_SIZE__ 1\n");
