Received: from out.smtpout.orange.fr (out-13.smtpout.orange.fr [193.252.22.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DD314885D;
	Fri, 28 Mar 2025 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743181154; cv=none; b=IZJAJpoaEDDy0M7Ct6YUwJtdvbHJBfIHfKYRaWlUXS6bHxcv1SSsKceiGlIsjx9DV4C9MnAJWS/RyTDRfd3lh45zyausZ+8OigCFEqrRDU+2Us/d/GQk1cL/RTCSwao7mbB0x/Uew/u6yjel3yEGoGGzrgSKVkfBJAu4TG9cVlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743181154; c=relaxed/simple;
	bh=i2jYS1teINNlzn7NXzgamSmK5FWeVs6wk/ovAgnH6Xw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=f09YgpvZvxrPPZI3acXrGiWVjaaDdBLhDncZ4FkohvZKRlIh2iMRuHoy0fpIrm3N5hAe+MsLNAv7ZPHf4cV4fPW7TSi85XAJGcKPhOyzgNqGu7U0D/Fcb1Z/T0OmQXDrAxz1j5eDGCkf3GwiYGRHxl+xRhF12xe3dnbC3JTjBag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=V9Mb1LZU; arc=none smtp.client-ip=193.252.22.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="V9Mb1LZU"
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id yCtctJSN2i4etyCtst6TfZ; Fri, 28 Mar 2025 17:49:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1743180588;
	bh=ZiksZKVVWflnDT9ALuNHdnOgAkwCPQpuwnw3KXr58JU=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=V9Mb1LZUOHw+N5OHpGKoVCy6B2BMNOg/Yrj4Zlvck/N1NmFUmIbNTvD1ZHrFq1MKE
	 rho2j41tY4FOAHrtKWRJ0FUc4NdBcUE1GWE5wU5Dr6Rp+mH8E6BJQoMKXedJdNqjmL
	 VFSozcbKNo6D6ly8JxCEmFNZFTzfEBKWe6xxHHwNAXa42HRNT8eZ9iQhOJYhrfDBGI
	 DfN+LQOlYmudptXtikZFz3DwNdbaMMzDfZNnMIf3wm2VSNrG1nlFZmKFnxtwe7kguv
	 P1HaX63N9VzeiH0VBU7hr3LXgOF2V5uaS+fjoNRVvWvVgpGxJV2s6+EJOYw8BcAvz3
	 GNS1gRvc/2JRA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 28 Mar 2025 17:49:48 +0100
X-ME-IP: 124.33.176.97
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Sat, 29 Mar 2025 01:48:50 +0900
Subject: [PATCH v2] build_bug.h: more user friendly error messages in
 BUILD_BUG_ON_ZERO()
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250329-build_bug-v2-1-1c831e5ddf89@wanadoo.fr>
X-B4-Tracking: v=1; b=H4sIAPHS5mcC/zXOQQqDMBCF4atI1h1rommLq96jSIlx1AGT2BitI
 N69obar4Yfh421sQk84sTLZmMeFJnI2hjglTPfKdgjUxGYiEzLLxRXqmYbmWc8dKCk1v3GhUXI
 W/0ePLa1f61HFbr0zEHqP6i8UXGSSS57zS8qLWyQlCDCKht4N6UJWow33t7KqcS5t/U/1+Jrjs
 HDQrFYTgnbGUCiTmoJR4/k40DoPFtfAqn3/AErb7BDbAAAA
X-Change-ID: 20250327-build_bug-a55c1812ce51
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org, 
 Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4495;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=i2jYS1teINNlzn7NXzgamSmK5FWeVs6wk/ovAgnH6Xw=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDOnPLitbzVDjWN+8MdFiF9PnggyGy077C+99dnpVmdyVu
 r1s8gL/jlIWBjEuBlkxRZZl5ZzcCh2F3mGH/lrCzGFlAhnCwMUpABMRDGb4n2vReHPt20+B10pq
 y5Z3JWReyPn96FrL0YT9n0/dUj8YcYThf7V0owzz/gbTna9+3JQrYZkb/b6gwi19i2C9TlVz9gp
 WbgA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

__BUILD_BUG_ON_ZERO_MSG(), as introduced in [1], makes it possible to
do a static assertions in expressions. The direct benefit is to
provide a meaningful error message instead of the cryptic negative
bitfield size error message currently returned by BUILD_BUG_ON_ZERO():

  ./include/linux/build_bug.h:16:51: error: negative width in bit-field '<anonymous>'
     16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
        |                                                   ^

Get rid of BUILD_BUG_ON_ZERO()'s bitfield size hack. Instead rely on
__BUILD_BUG_ON_ZERO_MSG() which in turn relies on C11's
_Static_assert().

Use some macro magic, similarly to static_assert(), to either use an
optional error message provided by the user or, when omitted, to
produce a default error message by stringifying the tested
expression. With this, for example:

  BUILD_BUG_ON_ZERO(1 > 0)

would now throw:

  ./include/linux/compiler.h:197:62: error: static assertion failed: "1 > 0 is true"
    197 | define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
        |                                                             ^~~~~~~~~~~~~~

Finally, __BUILD_BUG_ON_ZERO_MSG() is already guarded by an:

  #ifdef __CHECKER__

So no need any more for that guard clause for BUILD_BUG_ON_ZERO().
Remove it.

[1] commit d7a516c6eeae ("compiler.h: Fix undefined BUILD_BUG_ON_ZERO()")
Link: https://git.kernel.org/torvalds/c/d7a516c6eeae

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
** Prerequisite **

This patch depends on:

  commit b88937277df ("drm/i915: Convert REG_GENMASK*() to fixed-width GENMASK_U*()")
  Link: https://git.kernel.org/next/linux-next/c/b88937277df

Changelog:

  v1 -> v2:

    - The patch caused an issue because of a conflict in drm/i915:

      Link: https://lore.kernel.org/all/202412080849.sPp82jSi-lkp@intel.com/

      Above conflict is indirectly resolved by commit b88937277df
      (c.f. above prerequisite).

      Now that the conflict is resolved, resend the patch.

    - Remove the intermediary __BUILD_BUG_ON_ZERO() macro, instead,
      make __BUILD_BUG_ON_ZERO_MSG() variadic.

  Link to v1: https://lore.kernel.org/all/20241205151316.1480255-2-mailhol.vincent@wanadoo.fr/
---
 include/linux/build_bug.h | 10 +++++-----
 include/linux/compiler.h  |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/build_bug.h b/include/linux/build_bug.h
index 3aa3640f8c181f6a54bacffbc43260b57481e67f..2cfbb4c65c784ad82edd1e45c1b4f4c23e78b009 100644
--- a/include/linux/build_bug.h
+++ b/include/linux/build_bug.h
@@ -4,17 +4,17 @@
 
 #include <linux/compiler.h>
 
-#ifdef __CHECKER__
-#define BUILD_BUG_ON_ZERO(e) (0)
-#else /* __CHECKER__ */
 /*
  * Force a compilation error if condition is true, but also produce a
  * result (of value 0 and type int), so the expression can be used
  * e.g. in a structure initializer (or where-ever else comma expressions
  * aren't permitted).
+ *
+ * Take an error message as an optional second argument. If omitted,
+ * default to the stringification of the tested expression.
  */
-#define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
-#endif /* __CHECKER__ */
+#define BUILD_BUG_ON_ZERO(e, ...) \
+	__BUILD_BUG_ON_ZERO_MSG(e, ##__VA_ARGS__, #e " is true")
 
 /* Force a compilation error if a constant expression is not a power of 2 */
 #define __BUILD_BUG_ON_NOT_POWER_OF_2(n)	\
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 9fc30b6b80c9ef8e53a89f53c16ebbe84e40eedb..48793a7822daad99b27324848d585e3cd9893e71 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -192,9 +192,9 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 })
 
 #ifdef __CHECKER__
-#define __BUILD_BUG_ON_ZERO_MSG(e, msg) (0)
+#define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) (0)
 #else /* __CHECKER__ */
-#define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
+#define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
 #endif /* __CHECKER__ */
 
 /* &a[0] degrades to a pointer: a different type from an array */

---
base-commit: de305063001d5624138a452bdb2d56e68dc2301c
change-id: 20250327-build_bug-a55c1812ce51

Best regards,
-- 
Vincent Mailhol <mailhol.vincent@wanadoo.fr>

