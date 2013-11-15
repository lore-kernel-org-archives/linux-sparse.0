From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [BUG] sparse warning EXPORT_SYMBOL()'d symbol non-static
Date: Fri, 15 Nov 2013 14:46:19 +0800
Message-ID: <CAPgLHd9hwKRQMr1dnzJon-nVkkgKxcL5M2jEY8AF6Sv8OZ+aOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:56761 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755269Ab3KOGqV (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 15 Nov 2013 01:46:21 -0500
Received: by mail-bk0-f52.google.com with SMTP id u14so1320392bkz.25
        for <linux-sparse@vger.kernel.org>; Thu, 14 Nov 2013 22:46:19 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

After the following kernel commit, sparse warning lot of
EXPORT_SYMBOL()'d symbol non-static like this:

  CHECK   net/sctp/socket.c
net/sctp/socket.c:4292:1: warning:
 symbol '__ksymtab_sctp_do_peeloff' was not declared. Should it be static?


commit e0f244c63fc9d192dfd399cc2677bbdca61994b1
Author: Andi Kleen <ak@linux.intel.com>
Date:   Wed Oct 23 10:57:58 2013 +1030

    asmlinkage, module: Make ksymtab and kcrctab symbols and __this_module __visible
    
    Make the ksymtab symbols for EXPORT_SYMBOL visible.
    This prevents the LTO compiler from adding a .NUMBER prefix,
    which avoids various problems in later export processing.
    
    Cc: rusty@rustcorp.com.au
    Signed-off-by: Andi Kleen <ak@linux.intel.com>
    Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

    Cc: rusty@rustcorp.com.au
    Signed-off-by: Andi Kleen <ak@linux.intel.com>
    Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff --git a/include/linux/export.h b/include/linux/export.h
index 412cd50..3f2793d 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -43,7 +43,7 @@ extern struct module __this_module;
 /* Mark the CRC weak since genksyms apparently decides not to
  * generate a checksums for some symbols */
 #define __CRC_SYMBOL(sym, sec)                                 \
-       extern void *__crc_##sym __attribute__((weak));         \
+       extern __visible void *__crc_##sym __attribute__((weak));               \
        static const unsigned long __kcrctab_##sym              \
        __used                                                  \
        __attribute__((section("___kcrctab" sec "+" #sym), unused))     \
@@ -59,7 +59,7 @@ extern struct module __this_module;
        static const char __kstrtab_##sym[]                     \
        __attribute__((section("__ksymtab_strings"), aligned(1))) \
        = VMLINUX_SYMBOL_STR(sym);                              \
-       static const struct kernel_symbol __ksymtab_##sym       \
+       __visible const struct kernel_symbol __ksymtab_##sym    \
        __used                                                  \
        __attribute__((section("___ksymtab" sec "+" #sym), unused))     \
        = { (unsigned long)&sym, __kstrtab_##sym }


Any idea?

Regards,
Yongjun Wei


