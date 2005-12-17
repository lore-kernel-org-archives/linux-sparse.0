From: Mika Kukkonen <mikukkon@iki.fi>
Subject: [PATCH] Sparse: fix the setting of __SIZE_TYPE__ in lib.c
Date: Sat, 17 Dec 2005 22:40:49 +0200
Message-ID: <4301cff60512171240v3436593ei44e662a82893cc0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_22916_7462055.1134852049048"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.205]:14779 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964917AbVLQUku (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 17 Dec 2005 15:40:50 -0500
Received: by xproxy.gmail.com with SMTP id i30so614848wxd
        for <linux-sparse@vger.kernel.org>; Sat, 17 Dec 2005 12:40:49 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: torvalds@osdl.org
Cc: linux-sparse@vger.kernel.org

------=_Part_22916_7462055.1134852049048
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I was doing some janitorial work on kernel lib/string.c (patch to
kernel mailing list coming later), and in particular removed the
"#undef memcmp" line. This caused sparse to barf:

mika@desktop:~/work/repos/git/linux-2.6$ make C=3D1 lib
  CHK     include/linux/version.h
  CHECK   lib/string.c
lib/string.c:519:5: error: symbol '__builtin_memcmp' redeclared with
different type (originally declared at builtin:37) - incompatible
argument 3 (different type sizes)
  CC      lib/string.o

Does the attached patch make sense?

--MiKu

------=_Part_22916_7462055.1134852049048
Content-Type: application/octet-stream; name=fix-size_type-setting.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="fix-size_type-setting.patch"

---

 lib.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib.c b/lib.c
index d765d75..d80bc28 100644
--- a/lib.c
+++ b/lib.c
@@ -479,10 +479,13 @@ void create_builtin_stream(void)
 
 	// gcc defines __SIZE_TYPE__ to be size_t.  For linux/i86 and
 	// solaris/sparc that is really "unsigned int" and for linux/x86_64
-	// it is "long unsigned int".  In either case we can probably
-	// get away with this.  We need the #ifndef as cgcc will define
+	// it is "long unsigned int". We need the #ifndef as cgcc will define
 	// the right __SIZE_TYPE__.
-	add_pre_buffer("#weak_define __SIZE_TYPE__ long unsigned int\n");
+	if (sizeof(size_t) == sizeof(unsigned int))
+		add_pre_buffer("#weak_define __SIZE_TYPE__ unsigned int\n");
+	else
+		add_pre_buffer("#weak_define __SIZE_TYPE__ long unsigned int\n");
+
 	add_pre_buffer("#weak_define __STDC__ 1\n");
 
 	add_pre_buffer("#define __builtin_stdarg_start(a,b) ((a) = (__builtin_va_list)(&(b)))\n");



------=_Part_22916_7462055.1134852049048--
