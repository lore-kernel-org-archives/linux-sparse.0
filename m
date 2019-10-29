From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: detecting misuse of of_get_property
Date: Tue, 29 Oct 2019 13:50:58 +0300
Message-ID: <20191029104917.GI1944@kadam>
References: <ec277c12-c608-6326-7723-be8cab4f524a@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ec277c12-c608-6326-7723-be8cab4f524a@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dan Carpenter <dan.carpenter@oracle.co>, linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

This should probably work?

regards,
dan carpenter

diff --git a/check_list.h b/check_list.h
index 564bd1c2..5fa9a269 100644
--- a/check_list.h
+++ b/check_list.h
@@ -191,6 +191,7 @@ CK(check_nospec_barrier)
 CK(check_spectre)
 CK(check_spectre_second_half)
 CK(check_implicit_dependencies)
+CK(check_of_get_property)
 
 /* wine specific stuff */
 CK(check_wine_filehandles)
diff --git a/check_of_get_property.c b/check_of_get_property.c
new file mode 100644
index 00000000..b7aa8824
--- /dev/null
+++ b/check_of_get_property.c
@@ -0,0 +1,47 @@
+/*
+ * Copyright (C) 2019 Oracle.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see http://www.gnu.org/copyleft/gpl.txt
+ */
+
+#include "smatch.h"
+#include "smatch_slist.h"
+
+static int my_id;
+
+static void match_of_get_property(const char *fn, struct expression *expr, void *unused)
+{
+	struct expression *left = expr->left;
+	struct symbol *type;
+
+	type = get_type(left);
+	if (!type || type->type != SYM_PTR)
+		return;
+	type = get_base_type(type);
+	if (type_bits(type) == 8)
+		return;
+	if (type->type == SYM_RESTRICT)
+		return;
+	sm_warning("'%s' returns big endian data", fn);
+}
+
+void check_of_get_property(int id)
+{
+	my_id = id;
+
+	if (option_project != PROJ_KERNEL)
+		return;
+
+	add_function_assign_hook("of_get_property", &match_of_get_property, NULL);
+}
