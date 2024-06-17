Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BF08836;
	Mon, 17 Jun 2024 12:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718627501; cv=none; b=mauFb5h8NoNbct9amxbLU+e1430lfRJo45BPuYtbvoY0313pnQZCHoYUukGCIL4yixxf0ygf8XOVh96rSMmB6/wgJP7lM5MDoBV9Qe4HD1ak79DM1GqnZyYrq6vFG/FItaZSzuOcL4cTwgA9lScHHdm0KNgEPnBQrXssnUAzsc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718627501; c=relaxed/simple;
	bh=6U6NvOSkC8C59/JMyqKN4L4RgtHGHT7QgPMlgHn0nzM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GdHU5mPJ39BoLQOyR+GsHtEzBzudF+gJj7GaFzm+eT+mkyJbkpW2gQNHMzWVnj1Pad2MDS2mbHBWmf39INrDLEFiaEmQu1oV2IvsvwfcwjryEFAwkWUVsG9ewABOOj/5o98/LY8+RVnyFlwxf8uTU4iW/+n1guwADf4DdfL2d4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iu7xjcs7; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iu7xjcs7"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-35f275c7286so3860441f8f.2;
        Mon, 17 Jun 2024 05:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718627497; x=1719232297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xUt11Ucr8oA7ZjPMc4FTL3rN5QlM3txPngNirdWjMlg=;
        b=iu7xjcs74jcc1fKgv42n+MwNlaw9k/vQ0oaHwNudHVzDdCjUeWoMymG6CWl9rtJyXX
         EtpnQdkYn6jTyv6JA2AYzr4nQ1OcYOBNDTTsTBrl3FV2KIpo6vuLaA6RxqCpoBQtd+lU
         w5Gvw9rrRPY4+Cz7H1vnjUkiATc0uQ2aNmvugqVFjg2E5umOtFoY3LBmrFeh2oZUcIIs
         FGNIdPM1/sDWsvH4u3FqLl5QBXgNtuMrB4at1vqLQSE35MJbAGU1jJTn4pq68QA7ImU/
         mPID1CPgRhjYMVoNIe8zeMOoG/Z3Xz8QoLVuKRjFHs3N9Orsmw6WKJiNEBxoL9WxTXBG
         vULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718627497; x=1719232297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xUt11Ucr8oA7ZjPMc4FTL3rN5QlM3txPngNirdWjMlg=;
        b=keAOZVafczaOHiQbPxuPJ2z9uPUO3R+RqOltOvWrQkzLrZFGQ/GnjYVzhW3/mczrBQ
         EQccHCMakMhdWpy2emPyXcHl3GY6EL6P39QaJZpu3WhSGcBDnresjHoT8Cbs3RlEP6wX
         G1nTywxBEot2DvaWlhEtu9ilrjDnHDwJ3pMYeBIUC7vJ10I27sHyZfVO+Rq98l2VNK+o
         PciscOeoCe0CAXpCei1+0v2jOObaCCAMiziWveDX0fnxllYhBB2pgsNeDnnvLEvkz6No
         HO2WgnW+SuaVnkkKp6ANKl5QHqnkAxCTVtjUoKc/OJzf/5KSVWwHDA1HNG7xzwpGPB5r
         RTKw==
X-Forwarded-Encrypted: i=1; AJvYcCUMMTLhAM5Fu7NPzoJtB9YStToYE9fZ9wpLpTlThq44KVszjsH7fzjOcB6yqTjGbcWu6dTJRlW1thDO2qtuMpQWMWm/xp/Kkqd7b5XJ7d8evRtl/IRnBPOyXb6eAgJy569dEhqY5bVd/QHj
X-Gm-Message-State: AOJu0YxmfgmW5u3MuTwtGZccA9nKTGOfSPCuAymNoJZvkHWPsPFhWi/D
	lMjObYYsvpJalIf5jRqBS8TgseAA0PmlrTZZ19OnyW8AE/eSW9QY6jgLyQ==
X-Google-Smtp-Source: AGHT+IG+Gyzd9jk0zBnxIbSHolF/P9F4z8vzRrnNDQaRBjpYSl+ZQ3C0xZVPvwGVSO4q+LGvLtF3Hg==
X-Received: by 2002:adf:fc82:0:b0:360:79d4:b098 with SMTP id ffacd0b85a97d-3607a76609emr5759650f8f.29.1718627496944;
        Mon, 17 Jun 2024 05:31:36 -0700 (PDT)
Received: from hometw-NUC11PAHi5.locataire.student-village.local ([185.25.192.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075093531sm11753879f8f.15.2024.06.17.05.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 05:31:36 -0700 (PDT)
From: Chun-Hung Tseng <henrybear327@gmail.com>
To: luc.vanoostenryck@gmail.com,
	linux-sparse@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Chun-Hung Tseng <henrybear327@gmail.com>,
	Jim Huang <jserv@ccns.ncku.edu.tw>
Subject: [PATCH] compiler.h: Improve __branch_check__ by using __UNIQUE_ID()
Date: Mon, 17 Jun 2024 14:29:35 +0200
Message-Id: <20240617122934.2650453-1-henrybear327@gmail.com>
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

