From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/3] Add a new warning flag: '-Wunknown-attribute'
Date: Wed,  2 Nov 2016 22:59:38 +0100
Message-ID: <20161102215939.36765-3-luc.vanoostenryck@gmail.com>
References: <20161102215939.36765-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36097 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757170AbcKBWBz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 2 Nov 2016 18:01:55 -0400
Received: by mail-wm0-f66.google.com with SMTP id c17so5043138wmc.3
        for <linux-sparse@vger.kernel.org>; Wed, 02 Nov 2016 15:01:54 -0700 (PDT)
In-Reply-To: <20161102215939.36765-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

So, we can choose if we're interested by those warnings or not.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c                               |  2 ++
 lib.h                               |  1 +
 validation/Wunknown-attribute-def.c |  9 +++++++++
 validation/Wunknown-attribute-no.c  |  9 +++++++++
 validation/Wunknown-attribute-yes.c | 10 ++++++++++
 5 files changed, 31 insertions(+)
 create mode 100644 validation/Wunknown-attribute-def.c
 create mode 100644 validation/Wunknown-attribute-no.c
 create mode 100644 validation/Wunknown-attribute-yes.c

diff --git a/lib.c b/lib.c
index d5b56b01..138736e7 100644
--- a/lib.c
+++ b/lib.c
@@ -240,6 +240,7 @@ int Wtransparent_union = 0;
 int Wtypesign = 0;
 int Wundef = 0;
 int Wuninitialized = 1;
+int Wunknown_attribute = 1;
 int Wvla = 1;
 
 int dbg_entry = 0;
@@ -463,6 +464,7 @@ static const struct warning {
 	{ "typesign", &Wtypesign },
 	{ "undef", &Wundef },
 	{ "uninitialized", &Wuninitialized },
+	{ "unknown-attribute", &Wunknown_attribute },
 	{ "vla", &Wvla },
 };
 
diff --git a/lib.h b/lib.h
index 15b69fa2..b778bdcd 100644
--- a/lib.h
+++ b/lib.h
@@ -126,6 +126,7 @@ extern int Wtransparent_union;
 extern int Wtypesign;
 extern int Wundef;
 extern int Wuninitialized;
+extern int Wunknown_attribute;
 extern int Wvla;
 
 extern int dbg_entry;
diff --git a/validation/Wunknown-attribute-def.c b/validation/Wunknown-attribute-def.c
new file mode 100644
index 00000000..0c0868d6
--- /dev/null
+++ b/validation/Wunknown-attribute-def.c
@@ -0,0 +1,9 @@
+static int foo(void) __attribute__((unknown_attribute));
+
+/*
+ * check-name: warn-unknown-attribute
+ *
+ * check-error-start
+Wunknown-attribute-def.c:1:37: warning: attribute 'unknown_attribute': unknown attribute
+ * check-error-end
+ */
diff --git a/validation/Wunknown-attribute-no.c b/validation/Wunknown-attribute-no.c
new file mode 100644
index 00000000..87951699
--- /dev/null
+++ b/validation/Wunknown-attribute-no.c
@@ -0,0 +1,9 @@
+static int foo(void) __attribute__((unknown_attribute));
+
+/*
+ * check-name: warn-unknown-attribute-no
+ * check-command: sparse -Wno-unknown-attribute $file
+ *
+ * check-error-start
+ * check-error-end
+ */
diff --git a/validation/Wunknown-attribute-yes.c b/validation/Wunknown-attribute-yes.c
new file mode 100644
index 00000000..72538cf5
--- /dev/null
+++ b/validation/Wunknown-attribute-yes.c
@@ -0,0 +1,10 @@
+static int foo(void) __attribute__((unknown_attribute));
+
+/*
+ * check-name: warn-unknown-attribute-yes
+ * check-command: sparse -Wunknown-attribute $file
+ *
+ * check-error-start
+Wunknown-attribute-yes.c:1:37: warning: attribute 'unknown_attribute': unknown attribute
+ * check-error-end
+ */
-- 
2.10.1

