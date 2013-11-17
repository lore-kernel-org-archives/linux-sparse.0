From: Erico Nunes <nunes.erico@gmail.com>
Subject: [PATCH] jffs2: fix sparse errors: directive in argument list
Date: Sun, 17 Nov 2013 20:43:21 -0200
Message-ID: <1384728201-13509-1-git-send-email-nunes.erico@gmail.com>
References: <CAK4VdL2nKEE+xb=HtMGNsMGNR_ivUn_WnLi7X-rrXT0fpGbSTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK4VdL2nKEE+xb=HtMGNsMGNR_ivUn_WnLi7X-rrXT0fpGbSTw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joe@perches.com
Cc: linux-sparse@vger.kernel.org, dwmw2@infradead.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, Erico Nunes <nunes.erico@gmail.com>
List-Id: linux-sparse@vger.kernel.org

This patch fixes the following errors reported when running sparse:
fs/jffs2/super.c:378:1: error: directive in argument list
fs/jffs2/super.c:380:1: error: directive in argument list
fs/jffs2/super.c:381:1: error: directive in argument list
fs/jffs2/super.c:383:1: error: directive in argument list

Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
---
 fs/jffs2/super.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index 0defb1c..ec9e16f 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -361,6 +361,14 @@ MODULE_ALIAS_FS("jffs2");
 static int __init init_jffs2_fs(void)
 {
 	int ret;
+	const char desc[] =3D "version 2.2."
+#ifdef CONFIG_JFFS2_FS_WRITEBUFFER
+		" (NAND)"
+#endif
+#ifdef CONFIG_JFFS2_SUMMARY
+		" (SUMMARY) "
+#endif
+		" =C2=A9 2001-2006 Red Hat, Inc.";
=20
 	/* Paranoia checks for on-medium structures. If we ask GCC
 	   to pack them with __attribute__((packed)) then it _also_
@@ -374,14 +382,7 @@ static int __init init_jffs2_fs(void)
 	BUILD_BUG_ON(sizeof(struct jffs2_raw_inode) !=3D 68);
 	BUILD_BUG_ON(sizeof(struct jffs2_raw_summary) !=3D 32);
=20
-	pr_info("version 2.2."
-#ifdef CONFIG_JFFS2_FS_WRITEBUFFER
-	       " (NAND)"
-#endif
-#ifdef CONFIG_JFFS2_SUMMARY
-	       " (SUMMARY) "
-#endif
-	       " =C2=A9 2001-2006 Red Hat, Inc.\n");
+	pr_info("%s\n", desc);
=20
 	jffs2_inode_cachep =3D kmem_cache_create("jffs2_i",
 					     sizeof(struct jffs2_inode_info),
--=20
1.8.4.2
