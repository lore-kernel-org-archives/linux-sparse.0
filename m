From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/6] storage should not be inherited by pointers
Date: Thu, 24 Nov 2016 18:09:42 +0100
Message-ID: <20161124170947.14379-2-luc.vanoostenryck@gmail.com>
References: <20161124170947.14379-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33118 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757246AbcKXRJ5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 24 Nov 2016 12:09:57 -0500
Received: by mail-wm0-f68.google.com with SMTP id u144so5488335wmu.0
        for <linux-sparse@vger.kernel.org>; Thu, 24 Nov 2016 09:09:56 -0800 (PST)
In-Reply-To: <20161124170947.14379-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Information about storage is needed for objects but once
you take the address of an object, its storage should be
irrelevant for the resulting pointer.

Trying to keep the storage into the pointer's modifiers
(while it will be available in the base type anyway) only
create corner cases later.
An example of the problem it can create is when the pointer
is dereferenced in an inlined function.

Better to simply not put have the storage informations
for the pointer, which is what this patch does.

To better illustrate the situation, suppose you have the
following variable declaration:
	static int var;

var's type should be:
	int static [toplevel] [addressable]

if you take its address the resulting pointer will be of type:
	int static [toplevel] *

while it should simply be:
	int *

Detected-by: Nicolai Stange <nicstange@gmail.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.h            | 2 +-
 validation/nocast.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/symbol.h b/symbol.h
index 9b3f1604..afc4e232 100644
--- a/symbol.h
+++ b/symbol.h
@@ -247,7 +247,7 @@ struct symbol {
 #define MOD_SIZE	(MOD_CHAR | MOD_SHORT | MOD_LONG_ALL)
 #define MOD_IGNORE (MOD_TOPLEVEL | MOD_STORAGE | MOD_ADDRESSABLE |	\
 	MOD_ASSIGNED | MOD_USERTYPE | MOD_ACCESSED | MOD_EXPLICITLY_SIGNED)
-#define MOD_PTRINHERIT (MOD_VOLATILE | MOD_CONST | MOD_NODEREF | MOD_STORAGE | MOD_NORETURN | MOD_NOCAST)
+#define MOD_PTRINHERIT (MOD_VOLATILE | MOD_CONST | MOD_NODEREF | MOD_NORETURN | MOD_NOCAST)
 
 
 /* Current parsing/evaluation function */
diff --git a/validation/nocast.c b/validation/nocast.c
index c28676a3..cc0ab6b7 100644
--- a/validation/nocast.c
+++ b/validation/nocast.c
@@ -160,7 +160,7 @@ nocast.c:34:33:    got unsigned long
 nocast.c:34:33: warning: implicit cast to nocast type
 nocast.c:35:39: warning: incorrect type in initializer (different modifiers)
 nocast.c:35:39:    expected unsigned long *static [toplevel] bad_ptr_from
-nocast.c:35:39:    got unsigned long static [nocast] [toplevel] *<noident>
+nocast.c:35:39:    got unsigned long [nocast] *<noident>
 nocast.c:35:39: warning: implicit cast from nocast type
 nocast.c:50:16: warning: implicit cast from nocast type
 nocast.c:54:16: warning: implicit cast from nocast type
-- 
2.10.2

