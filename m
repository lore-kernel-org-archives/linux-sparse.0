From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 6/6] keyword: no pre-declaration needed for attribute names
Date: Fri,  5 May 2017 03:50:34 +0200
Message-ID: <20170505015034.65164-7-luc.vanoostenryck@gmail.com>
References: <20170505015034.65164-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35480 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752330AbdEEBwH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 4 May 2017 21:52:07 -0400
Received: by mail-wm0-f68.google.com with SMTP id d79so6909778wmi.2
        for <linux-sparse@vger.kernel.org>; Thu, 04 May 2017 18:52:06 -0700 (PDT)
In-Reply-To: <20170505015034.65164-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, we have a whole bunch of attribute names whose
identifier is declared with IDENT() in "ident-list.h".

However, these names doesn't need to be so declared as their
identifier is never directly used and are otherwise dynamically
created via parse.c:keyword_table[] and init_parser().

So remove all of them from the "ident-list.h" file.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ident-list.h | 56 --------------------------------------------------------
 1 file changed, 56 deletions(-)

diff --git a/ident-list.h b/ident-list.h
index 709ffce01..130875741 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -54,62 +54,6 @@ IDENT_RESERVED(__builtin_types_compatible_p);
 IDENT_RESERVED(__builtin_offsetof);
 IDENT_RESERVED(__label__);
 
-/* Attribute names */
-IDENT(packed); IDENT(__packed__);
-IDENT(aligned); IDENT(__aligned__);
-IDENT(nocast);
-IDENT(noderef);
-IDENT(safe);
-IDENT(force);
-IDENT(address_space);
-IDENT(context);
-IDENT(mode); IDENT(__mode__);
-IDENT(QI); IDENT(__QI__);
-IDENT(HI); IDENT(__HI__);
-IDENT(SI); IDENT(__SI__);
-IDENT(DI); IDENT(__DI__);
-IDENT(word); IDENT(__word__);
-IDENT(format); IDENT(__format__);
-IDENT(section); IDENT(__section__);
-IDENT(unused); IDENT(__unused__);
-IDENT(const); IDENT(__const); IDENT(__const__);
-IDENT(used); IDENT(__used__);
-IDENT(warn_unused_result); IDENT(__warn_unused_result__);
-IDENT(noinline); IDENT(__noinline__);
-IDENT(deprecated); IDENT(__deprecated__);
-IDENT(noreturn); IDENT(__noreturn__);
-IDENT(regparm); IDENT(__regparm__);
-IDENT(weak); IDENT(__weak__);
-IDENT(no_instrument_function); IDENT(__no_instrument_function__);
-IDENT(sentinel); IDENT(__sentinel__);
-IDENT(alias); IDENT(__alias__);
-IDENT(pure); IDENT(__pure__);
-IDENT(always_inline); IDENT(__always_inline__);
-IDENT(syscall_linkage); IDENT(__syscall_linkage__);
-IDENT(visibility); IDENT(__visibility__);
-IDENT(bitwise); IDENT(__bitwise__);
-IDENT(model); IDENT(__model__);
-IDENT(format_arg); IDENT(__format_arg__);
-IDENT(nothrow); IDENT(__nothrow); IDENT(__nothrow__);
-IDENT(__transparent_union__);
-IDENT(malloc);
-IDENT(__malloc__);
-IDENT(nonnull); IDENT(__nonnull); IDENT(__nonnull__);
-IDENT(constructor); IDENT(__constructor__);
-IDENT(destructor); IDENT(__destructor__);
-IDENT(cold); IDENT(__cold__);
-IDENT(hot); IDENT(__hot__);
-IDENT(cdecl); IDENT(__cdecl__);
-IDENT(stdcall); IDENT(__stdcall__);
-IDENT(fastcall); IDENT(__fastcall__);
-IDENT(dllimport); IDENT(__dllimport__);
-IDENT(dllexport); IDENT(__dllexport__);
-IDENT(artificial); IDENT(__artificial__);
-IDENT(leaf); IDENT(__leaf__);
-IDENT(vector_size); IDENT(__vector_size__);
-IDENT(error); IDENT(__error__);
-
