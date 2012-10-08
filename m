From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 2/2] sparse, llvm: don't compile erroneous code
Date: Tue,  9 Oct 2012 01:17:58 +0200
Message-ID: <1349738279-13253-2-git-send-email-j.neuschaefer@gmx.net>
References: <1349738279-13253-1-git-send-email-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:59977 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751645Ab2JHXSl (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 8 Oct 2012 19:18:41 -0400
In-Reply-To: <1349738279-13253-1-git-send-email-j.neuschaefer@gmx.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

If sparse emits an error message while parsing a file, don't
generate LLVM code, and also don't parse further files. This
prevents a segfault when sparse-llvm is fed with certain junk.

Cc: Pekka Enberg <penberg@kernel.org>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
---
 sparse-llvm.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index e4929e9..0fc0dae 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -1268,7 +1268,10 @@ int main(int argc, char **argv)
 	compile(module, sparse_initialize(argc, argv, &filelist));
=20
 	FOR_EACH_PTR_NOTAG(filelist, file) {
-		compile(module, sparse(file));
+		struct symbol_list *symlist =3D sparse(file);
+		if (error_happened)
+			break;
+		compile(module, symlist);
 	} END_FOR_EACH_PTR_NOTAG(file);
=20
 	LLVMVerifyModule(module, LLVMPrintMessageAction, NULL);
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
