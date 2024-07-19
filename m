Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E231C44C81;
	Fri, 19 Jul 2024 07:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721375437; cv=none; b=BKNn2r2qgpe9fD9n3i7Ih6cxXBDdK/pLiAe7uTbbfw0FHwJJgNC3vAt1Sz0oKBVO/WC9d+mfqhEtG5Fxh1BsaNojsz0qT4kdGCniX+retgrKIOS4vU35GdGZCYym0L/TQJJKjkbABlS7iB4DTBSngHWbdK/+inH9tH3Mtbehuso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721375437; c=relaxed/simple;
	bh=6U6NvOSkC8C59/JMyqKN4L4RgtHGHT7QgPMlgHn0nzM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EZu1PVC2AZjgt5mUBiF6b6F0UQsWAGtRS3pzp615oE55dKl8QCthVtWPnmE/TFh2APxsFbfxDCAtRZ8OdjB39kS+ZsaZ+Y+h0LgdQ53dKCyt9//uhPBY+FdIsdd8syLsu2Xutlij6itEKklo8vi3YSnxz0Kv2EHsqwDPgwACnqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICPgcfjS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICPgcfjS"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4266fd39527so9924495e9.1;
        Fri, 19 Jul 2024 00:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721375434; x=1721980234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xUt11Ucr8oA7ZjPMc4FTL3rN5QlM3txPngNirdWjMlg=;
        b=ICPgcfjSQqIua0nsICnWrgnT6H6QSaucJNgRpTM+lahiCnrZX8pkTkkr93yjv3w5CQ
         zIZo1dS5Ku9T0Vgszs1GShyT9i79fgEoUBM9JBIRJpFDCisObm3ioCw1wYT4bbSSPW7F
         yHMVacYMYhLW6LjvgZbXh1R+PiyT5Rj3f9Z1ddmaOI9V9lxaINBljweDYVd5yvh16QxE
         Zp/IPI8DPvsnqKqw7ovPti0sQwuPOz0ZTKyaWrcVsQCtJkrpO1LPtWG5xOvvxpnDIwxr
         RIBxEH7msmJgD6DcPmYEkkexnLo6rkeP4sg8b85CXuTTAcFQz/BuWZfdNBmCv52qI9Y4
         F+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721375434; x=1721980234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xUt11Ucr8oA7ZjPMc4FTL3rN5QlM3txPngNirdWjMlg=;
        b=TlJWNMH1daBU5qcKx9a/nVes88vwjYUOLsVUMVC6qwXDo/2VUZ4R8g3JYQ0yjrSMC5
         /SRWA8hc5XpaJVQClkslqgKVQCz1Rd/Ewoqp00k2khbXmYexFbt1yUfNpRQ0s2WgFvsL
         Kbq9exN20RwO37PJ78P6B0TMik2lBc2HMKb8c9jAI+K4bYUId/9Ks3BwrY+VkePuru1y
         L/UMnsRrKTOIRpMhMUf902+2PVbDHi+a5/a0ftFsRL/Wa44qoqKluH7sF9dmlUyR/yIp
         /NWNdjWbPYaS1goaDCdxe5CBl/Xtbki8/dy8CFlsoSDBLdPnelDxOp73VGO73Is8Rtlp
         rmVg==
X-Forwarded-Encrypted: i=1; AJvYcCVN7w6wu366qU/WAyBOcPlh9dvRnl6XzcuzhP/eir+Lcj/Xofxi0qTTn++nEKvCFEcWPQSwqiSlw9SXdJCl7eTqL4DsZmG/fqsCkcBZmHlOmXp6lMCILqHVZJasMtC+/Pkoe/zJAnyZ2aBr
X-Gm-Message-State: AOJu0YzOCUj+5C216Jk/hqQnIyFtma+4MZ932IgjhrVHoEAfJhWNaxXc
	ZmPdoohumSxQxDehMQi+V75tuVTdVls2vmXxOIVcM15jgpKAYLG/1TwxYQ/T
X-Google-Smtp-Source: AGHT+IEh69/KRVJkX3qYNlaIzON/M9t/vn4EwJjqds+o6503mst40YvKVkM58M163szWYTei5KZYwg==
X-Received: by 2002:a05:600c:1f82:b0:426:66a2:b200 with SMTP id 5b1f17b1804b1-427c2c0fa9dmr55593315e9.0.1721375433923;
        Fri, 19 Jul 2024 00:50:33 -0700 (PDT)
Received: from hometw-NUC11PAHi5.locataire.student-village.local ([185.25.192.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d69071c5sm14771145e9.27.2024.07.19.00.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 00:50:33 -0700 (PDT)
From: Chun-Hung Tseng <henrybear327@gmail.com>
To: luc.vanoostenryck@gmail.com,
	arnd@arndb.de,
	keescook@chromium.org,
	rostedt@goodmis.org,
	linux-sparse@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Chun-Hung Tseng <henrybear327@gmail.com>,
	Jim Huang <jserv@ccns.ncku.edu.tw>
Subject: [PATCH] compiler.h: Improve __branch_check__ by using __UNIQUE_ID()
Date: Fri, 19 Jul 2024 09:50:13 +0200
Message-Id: <20240719075013.6600-1-henrybear327@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit replaced two hard-to-distinguish variables ______r and
______f to improve code readability and reduce variable name shadowing
issue.

______r is renamed by leveraging __UNIQUE_ID(branch_check) in
___branch_check__, and callers of the affected macros are adjusted.

__UNIQUE_ID(branch_check) will generate unique variable names during
compilation, which eliminates the need for ______r. This avoids the
variable name shadowing issue, or at least makes those wishing to cause
shadowing problems work much harder to do so.

______f in ftrace_likely_data struct is renamed using
__UNIQUE_ID(branch_check_data), following the same rationale above.

The same idea is used for the commit 589a9785ee3a ("min/max: remove sparse
warnings when they're nested"), and commit 24ba53017e18 ("rcu: Replace
________p1 and _________p1 with __UNIQUE_ID(rcu)").

Signed-off-by: Chun-Hung Tseng <henrybear327@gmail.com>
Signed-off-by: Jim Huang <jserv@ccns.ncku.edu.tw>
---
 include/linux/compiler.h | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 8c252e073bd8..b95e0990d52f 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -19,20 +19,20 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #define likely_notrace(x)	__builtin_expect(!!(x), 1)
 #define unlikely_notrace(x)	__builtin_expect(!!(x), 0)
 
-#define __branch_check__(x, expect, is_constant) ({			\
-			long ______r;					\
+#define __branch_check__(x, local, local_data, expect, is_constant) ({	\
+			long local;					\
 			static struct ftrace_likely_data		\
 				__aligned(4)				\
 				__section("_ftrace_annotated_branch")	\
-				______f = {				\
+				local_data = {				\
 				.data.func = __func__,			\
 				.data.file = __FILE__,			\
 				.data.line = __LINE__,			\
 			};						\
-			______r = __builtin_expect(!!(x), expect);	\
-			ftrace_likely_update(&______f, ______r,		\
+			local = __builtin_expect(!!(x), expect);	\
+			ftrace_likely_update(&local_data, local,	\
 					     expect, is_constant);	\
-			______r;					\
+			local;						\
 		})
 
 /*
@@ -41,10 +41,14 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  * written by Daniel Walker.
  */
 # ifndef likely
-#  define likely(x)	(__branch_check__(x, 1, __builtin_constant_p(x)))
+#  define likely(x)	(__branch_check__(x, __UNIQUE_ID(branch_check), \
+			__UNIQUE_ID(branch_check_data), 1,		\
+			__builtin_constant_p(x)))
 # endif
 # ifndef unlikely
-#  define unlikely(x)	(__branch_check__(x, 0, __builtin_constant_p(x)))
+#  define unlikely(x)	(__branch_check__(x, __UNIQUE_ID(branch_check), \
+			__UNIQUE_ID(branch_check_data), 0,		\
+			__builtin_constant_p(x)))
 # endif
 
 #ifdef CONFIG_PROFILE_ALL_BRANCHES
-- 
2.34.1

