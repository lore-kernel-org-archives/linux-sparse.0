Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1E414B07C;
	Mon,  5 Aug 2024 21:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722894227; cv=none; b=QWdFHEdI0euAPZv8OdhbEUM2ax/Dzk+a7a+v3tdVshFu1+M3FVKlkkbrvEBTK7kmFS5KA+5b3zRvz9qS+e6qcg05EuqtY8wMRnrtUwsFQlhQidnKHXqVmuS7BbPhvABVDXzU2I1ZlDHwMWizPYm78G+jzuLkxDOu5JAQIyuefNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722894227; c=relaxed/simple;
	bh=w1rNgVpubpxu7t9ez1M4o93NDC4Vb5FXEZkY9AcCwr4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VxyIn9Vpu/uoSLJjDjN3hAZEgeyLseVtv3JcmWxB1TobnFNk4lMhVmFY1T6ZqIUVXVH9fyBvzuUJMFXZSVKoz5q1cOLc+3soPAV/3xPYjhLxqUbRH7ZXJpk0rfGzP/MgQUwlBzjd9Eok0wLvM3JPey5VEzf8ks7kIQNIrvcKHqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgKRMl0A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgKRMl0A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430E2C32782;
	Mon,  5 Aug 2024 21:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722894227;
	bh=w1rNgVpubpxu7t9ez1M4o93NDC4Vb5FXEZkY9AcCwr4=;
	h=From:To:Cc:Subject:Date:From;
	b=bgKRMl0A7EBdqXh9+cwyQX19aes9QeRTUqvB9IQaj8IvvqQAXqDIQG1NpAkoYDNh0
	 5+5istaOAUfremykm+EC67/aSJajUMdHsZl5qpGV9nXpKkZLmmxYZk2tzRvUyrHSWX
	 6upX2xKrrac1GpaYhe4179fRcOSxUFWfBzJiyhr5pM3cSWWiG+RzLBlMzovr1Ywx8A
	 YtzfE1jlAuM2Ez54ibQ/JKFxdgnezr0/Lgvuq3WNtLGy4oEhpsLtZIvWYJJVm4ovZ+
	 OZFljMwKpCy203uqooHoYT+MRWAb+TCK7ebpOnEvqEspS+Ha09aXUP78rrM07sVUXO
	 gvPeV7YL3xeZQ==
From: Kees Cook <kees@kernel.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Marco Elver <elver@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-sparse@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Bill Wendling <morbo@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] string: Check for "nonstring" attribute on strscpy() arguments
Date: Mon,  5 Aug 2024 14:43:44 -0700
Message-Id: <20240805214340.work.339-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3626; i=kees@kernel.org; h=from:subject:message-id; bh=w1rNgVpubpxu7t9ez1M4o93NDC4Vb5FXEZkY9AcCwr4=; b=owGbwMvMwCVmps19z/KJym7G02pJDGkb3SeUnlr5f67g7V+5X8wEpZ59nnT3rK//1rayiGsck zRynhXzdZSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAExkIwvD/6gvKxMLfwhM/Le3 T92bj9OYRcVhSo5h84KtCuus6mUnP2Zk+LJgzupi1qLrN4rPucVHzG7kK1MT5ZNIvfNimtqDe8v PsgAA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

GCC already checks for arguments that are marked with the "nonstring"[1]
attribute when used on standard C String API functions (e.g. strcpy). Gain
this compile-time checking also for the kernel's primary string copying
function, strscpy().

Note that Clang has neither "nonstring" nor __builtin_has_attribute().

Link: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-nonstring-variable-attribute [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Marco Elver <elver@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Hao Luo <haoluo@google.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: linux-sparse@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
---
 include/linux/compiler.h       |  3 +++
 include/linux/compiler_types.h |  7 +++++++
 include/linux/string.h         | 12 ++++++++----
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 2df665fa2964..ec55bcce4146 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -242,6 +242,9 @@ static inline void *offset_to_ptr(const int *off)
 /* &a[0] degrades to a pointer: a different type from an array */
 #define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
 
+/* Require C Strings (i.e. NUL-terminated) lack the "nonstring" attribute. */
+#define __must_be_cstr(p)	BUILD_BUG_ON_ZERO(__annotated(p, nonstring))
+
 /*
  * This returns a constant expression while determining if an argument is
  * a constant expression, most importantly without evaluating the argument.
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index f14c275950b5..1a957ea2f4fe 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -421,6 +421,13 @@ struct ftrace_likely_data {
 #define __member_size(p)	__builtin_object_size(p, 1)
 #endif
 
+/* Determine if an attribute has been applied to a variable. */
+#if __has_builtin(__builtin_has_attribute)
+#define __annotated(var, attr)	__builtin_has_attribute(var, attr)
+#else
+#define __annotated(var, attr)	(false)
+#endif
+
 /*
  * Some versions of gcc do not mark 'asm goto' volatile:
  *
diff --git a/include/linux/string.h b/include/linux/string.h
index 9edace076ddb..95b3fc308f4f 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -76,12 +76,16 @@ ssize_t sized_strscpy(char *, const char *, size_t);
  * known size.
  */
 #define __strscpy0(dst, src, ...)	\
-	sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst))
-#define __strscpy1(dst, src, size)	sized_strscpy(dst, src, size)
+	sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst) +	\
+				__must_be_cstr(dst) + __must_be_cstr(src))
+#define __strscpy1(dst, src, size)	\
+	sized_strscpy(dst, src, size + __must_be_cstr(dst) + __must_be_cstr(src))
 
 #define __strscpy_pad0(dst, src, ...)	\
-	sized_strscpy_pad(dst, src, sizeof(dst) + __must_be_array(dst))
-#define __strscpy_pad1(dst, src, size)	sized_strscpy_pad(dst, src, size)
+	sized_strscpy_pad(dst, src, sizeof(dst) + __must_be_array(dst) +	\
+				    __must_be_cstr(dst) + __must_be_cstr(src))
+#define __strscpy_pad1(dst, src, size)	\
+	sized_strscpy_pad(dst, src, size + __must_be_cstr(dst) + __must_be_cstr(src))
 
 /**
  * strscpy - Copy a C-string into a sized buffer
-- 
2.34.1

