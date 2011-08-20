From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 2/2] fix common misspellings with codespell
Date: Sat, 20 Aug 2011 17:02:59 +0200
Message-ID: <1313852579-14468-2-git-send-email-j.neuschaefer@gmx.net>
References: <1313852579-14468-1-git-send-email-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:46033 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752456Ab1HTPDJ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 20 Aug 2011 11:03:09 -0400
In-Reply-To: <1313852579-14468-1-git-send-email-j.neuschaefer@gmx.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>

See http://git.profusion.mobi/cgit.cgi/lucas/codespell/ for more
information on codespell.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
---
 LICENSE                                  |    2 +-
 README                                   |    2 +-
 ast-model.c                              |    2 +-
 validation/preprocessor/preprocessor19.c |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/LICENSE b/LICENSE
index 06440ff..be0fd01 100644
--- a/LICENSE
+++ b/LICENSE
@@ -26,7 +26,7 @@ requirements of this license.
=20
 	 http://www.opensource.org/licenses/osl.php
=20
-  please refer to there for the authorative and slightly more
+  please refer to there for the authoritative and slightly more
   pretty-printed version ]
=20
 ------
diff --git a/README b/README
index 033ae15..63f752b 100644
--- a/README
+++ b/README
@@ -62,7 +62,7 @@ more requirements.  The user is free to do whatever h=
e wants with the
 parse tree that got built up, and needs not worry about the library ev=
er
 again.  There is no extra state, there are no parser callbacks, there =
is
 only the parse tree that is described by the header files. The action
-funtion takes a pointer to a symbol_list and does whatever it likes wi=
th it.
+function takes a pointer to a symbol_list and does whatever it likes w=
ith it.
=20
 The library also contains (as an example user) a few clients that do t=
he
 preprocessing, parsing and type evaluation and just print out the
diff --git a/ast-model.c b/ast-model.c
index f516340..704c487 100644
--- a/ast-model.c
+++ b/ast-model.c
@@ -167,7 +167,7 @@ ast_tree_model_init (GtkTreeModelIface *iface)
=20
 /*********************************************************************=
********
  *
- *  ast_init: this is called everytime a new ast node object
+ *  ast_init: this is called every time a new ast node object
  *            instance is created (we do that in ast_new).
  *            Initialise the list structure's fields here.
  *
diff --git a/validation/preprocessor/preprocessor19.c b/validation/prep=
rocessor/preprocessor19.c
index 7dd3820..e70dad1 100644
--- a/validation/preprocessor/preprocessor19.c
+++ b/validation/preprocessor/preprocessor19.c
@@ -1,4 +1,4 @@
-/* got burned by that - freed the new defintion in the case when we ha=
d
+/* got burned by that - freed the new definition in the case when we h=
ad
    warned and replaced the old one */
 #define A x
 #define A y
--=20
1.7.5.4

--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
