From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix implicit size of unsized arrays
Date: Thu, 28 Dec 2017 16:07:47 +0100
Message-ID: <20171228150747.77209-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32773 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753293AbdL1PIF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 28 Dec 2017 10:08:05 -0500
Received: by mail-wm0-f68.google.com with SMTP id g130so2226402wme.0
        for <linux-sparse@vger.kernel.org>; Thu, 28 Dec 2017 07:08:04 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

When an array is declared without an explicit size. In this case,
an implicit size is given by the number of elements in its initializer
if one is present.

Currently, in sparse, this implicit size is only associated with
the node corresponding to the initializer while the base type is
left unsized. This is a problem because the node is only used for
the modifiers & address-space and the bitsize of nodes are expected
to match the size of the basetype. So this implicit size can be used
for when directly using the bit_size of the node but the array is
still left, essentially unsized.

It's not enough to simply copy the bitsize of the node to the base
type because:
1) sym->array_size need to be set in the node & the base type.
2) the base type can be shared between several declarators.
It's thus needed to copy the the base type to unshare it before
setting the sym->array_size.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---

This patch is available in the Git repository at:
  git://github.com/lucvoo/sparse-dev.git size-unsized-arrays

 symbol.c                         | 19 ++++++++++++++++++-
 validation/array-implicit-size.c | 26 ++++++++++++++++++++++++++
 validation/constexpr-preop.c     |  2 ++
 3 files changed, 46 insertions(+), 1 deletion(-)
 create mode 100644 validation/array-implicit-size.c

diff --git a/symbol.c b/symbol.c
index 2f4afd515..61d1acbea 100644
--- a/symbol.c
+++ b/symbol.c
@@ -364,6 +364,23 @@ static struct expression *get_symbol_initializer(struct symbol *sym)
 	return NULL;
 }
 
+static unsigned int implicit_array_size(struct symbol *node, unsigned int count)
+{
+	struct symbol *arr_ori = node->ctype.base_type;
+	struct symbol *arr_new = alloc_symbol(node->pos, SYM_ARRAY);
+	struct symbol *elem_type = arr_ori->ctype.base_type;
+	struct expression *size = alloc_const_expression(node->pos, count);
+	unsigned int bit_size = array_element_offset(elem_type->bit_size, count);
+
+	*arr_new = *arr_ori;
+	arr_new->bit_size = bit_size;
+	arr_new->array_size = size;
+	node->array_size = size;
+	node->ctype.base_type = arr_new;
+
+	return bit_size;
+}
+
 static struct symbol * examine_node_type(struct symbol *sym)
 {
 	struct symbol *base_type = examine_base_type(sym);
@@ -393,7 +410,7 @@ static struct symbol * examine_node_type(struct symbol *sym)
 			int count = count_array_initializer(node_type, initializer);
 
 			if (node_type && node_type->bit_size >= 0)
-				bit_size = array_element_offset(node_type->bit_size, count);
+				bit_size = implicit_array_size(sym, count);
 		}
 	}
 	
diff --git a/validation/array-implicit-size.c b/validation/array-implicit-size.c
new file mode 100644
index 000000000..7011008b6
--- /dev/null
+++ b/validation/array-implicit-size.c
@@ -0,0 +1,26 @@
+static int array[] = { 0, 1, 2, 3, };
+_Static_assert(sizeof(array) == 4 * sizeof(int), "size of array");
+
+
+typedef int table_t[];
+static table_t tbl2 = {
+	0,
+	1,
+};
+_Static_assert(sizeof(tbl2) == 2 * sizeof(int), "size of tbl2");
+
+static table_t tbl1 = {
+	0,
+};
+_Static_assert(sizeof(tbl1) == 1 * sizeof(int), "size of tbl1");
+
+static table_t tbl3 = {
+	0,
+	1,
+	2,
+};
+_Static_assert(sizeof(tbl3) == 3 * sizeof(int), "size of tbl3");
+
+/*
+ * check-name: array-implicit-size
+ */
diff --git a/validation/constexpr-preop.c b/validation/constexpr-preop.c
index 4b54defd9..3fd577459 100644
--- a/validation/constexpr-preop.c
+++ b/validation/constexpr-preop.c
@@ -25,5 +25,7 @@ constexpr-preop.c:8:4: error: bad constant expression
 constexpr-preop.c:9:4: error: bad constant expression
 constexpr-preop.c:14:4: error: bad integer constant expression
 constexpr-preop.c:15:4: error: bad integer constant expression
+constexpr-preop.c:10:4: error: index out of bounds in initializer
+constexpr-preop.c:11:4: error: index out of bounds in initializer
  * check-error-end
  */
-- 
2.15.0

