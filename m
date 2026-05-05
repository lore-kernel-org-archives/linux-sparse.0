Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0499847DFB9
	for <linux-sparse@vger.kernel.org>; Tue,  5 May 2026 13:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987569; cv=none; b=sC/b8y95Uczl+U/UAFGalCrC8Tjv6rwzhVgwUI+87dZ1sSyvlwJBi3/44u7eEIGWPNvpBMZF/xCkIQpfZiq+PHKwDqrQo0G5KtxPGAwUfTW1NDd1ehpCfrr7rg67VqUI/21DegWkuGBjupHLbNJw9mjV9DPPbma3Op6bObsVhKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987569; c=relaxed/simple;
	bh=iwYMjGAdzVvXks/y94YlfpfeIc8FHSwp0GNFgHSsup0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VJdSLXVAf7ZVzojMyUTNBaMkl/usojjf4wkLu13PygJb1E3A9zjK1twePArUqPOWzxstjhOWFw4iRXFGR1BHNHIgZTYdSzFu95qEvSOxX7kHf8nPtQJx/lgxp3WkYVWkcd3l5P8TYYECgfPzUv/jRUkCcvn/Qd/JY7zIl16KRhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caFGxJ6X; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caFGxJ6X"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso57826805e9.1
        for <linux-sparse@vger.kernel.org>; Tue, 05 May 2026 06:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777987565; x=1778592365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+brwT9qrE6A/MGAefgGFAS6zw9PaJPYwlbEMME3z0I=;
        b=caFGxJ6Xui4yCD13T4n+zJOT9NO+WSF/Sbl7lFAudusjVkLJYkOyew3yNzkHsZg7Mv
         7006N34phPTvK/jMkj0+4zKmLTqnAHyMB8hwQv5fTlisEOUe7QHTydHodPh9RoKRW64F
         1CkXIH+o3xHUQ3iA856fB2qRNG56R04i2JNCglwAEQBdTk2WWlqk3Svv3Spn5LcOrSTh
         fGF8yDsAhFk7YRy8WHOm56TEpywwYmKmJwDltEgZBjCp2wBZsZ7SeqiQ0iKvzN7CYJTG
         Tx7Zd+h73zxmPDhV8hz+1Z6PCR5YZY+JbrCXTsvI/HkBWpdcomH6tC1/iK9nE/r7M+KE
         WA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777987565; x=1778592365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+brwT9qrE6A/MGAefgGFAS6zw9PaJPYwlbEMME3z0I=;
        b=AyLMzd2A2dfEg0+FRlEeBGb3o2hu/aaqHL5Z8cWcyT/hdV1LgnOw+1nzJx89Jmu+6Z
         uX2QIoPfUY9fsJQkEKfvlPIzS48gruBsK6KBSoklVNyxvMHgA36uaeQermKDMEY7xmEe
         f/88GTOxLy30k/qjKrWAHQAACvLoHJ36+aykJfkDJovFXB/4tXKlrpuRlw2WXbpQ50EZ
         M9k+bUKoGqre8MBppmfwJ0VEr3a/i4U8YHNqhHbNb8wRQSkLytQnTya0YL6/SDlGwaUp
         fopP0dXvthQftg6AgxU1l84suZrpI05MdzQXowN/tKHhYwqzf4pCjJcTIqNj+ZfS4QTH
         Gqww==
X-Gm-Message-State: AOJu0Yzn/NC+EJdaz731QotHA41UdXew2tqUwEVA1MpYWwMU3px73y46
	1EUYaHgZwmYGFlAocKAsKkQGAhaQl5inAZhl8j5pPEbatntd7RwMPsE5JS0u6EtUDa0=
X-Gm-Gg: AeBDietT+IZfKIEzyrRr5KX6MzA0iZp3dKn4zSARHbEwul6zZA39XpQEEz4zlwskRGI
	q3cvr1cofjhCbsp6lNi0G14u2I+L/s8Ca1Q0M5f8BHT+GX+n4dwAjBWf6eBU7x2Q/cuDiSgjg6m
	m51p+qTYvn75258Pq2VFD3u8/OzX7YhXg5ppElCYu8yLlNm1zFMdh4k5ZDZrCK3f9x8ZUKk7YSz
	YtknUhRNl2y802yruVUPzBcXK9tr4EldoUAss1eHsC3ZNl8GcldEncfdraV/KePvL+fvlQzGPFc
	RZu1uoqqhgGqEs1bcjXMJA6oELjn+tAnWJwGoP95Hcej2nTGZ10ytwMEpcdhnFtk1cKCmvUeReU
	fCGtjiMXzpm9nfx56hI/iePTnaX18TuUh0WUvo/M5jPt9oT8/mLeB3Er4C1cjuA7a4EGAdKubIY
	+FccmCycZV/X7Oj11Vjg8h13jWE541bwfWfL4Queqn5Y28kR+Szs4sp71zrwH220KA4OCS4g==
X-Received: by 2002:a05:600c:3f06:b0:48a:761:5816 with SMTP id 5b1f17b1804b1-48d1424a351mr63444905e9.8.1777987565039;
        Tue, 05 May 2026 06:26:05 -0700 (PDT)
Received: from localhost.localdomain ([105.39.209.175])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eba865fsm315658165e9.10.2026.05.05.06.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 06:26:04 -0700 (PDT)
From: Khaled Saleh <khaled.saleh.req@gmail.com>
To: Chris Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	khaled.saleh.req@gmail.com
Subject: [PATCH] tracing: make ftrace_branch_data counters atomic
Date: Tue,  5 May 2026 15:25:40 +0200
Message-Id: <20260505132540.414617-1-khaled.saleh.req@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace unsigned long counters with local_t and update all
increments and reads to use local_inc() and local_read().

This fixes potential race conditions in branch statistics
updates across CPUs.

Signed-off-by: Khaled Saleh <khaled.saleh.req@gmail.com>
---
 include/linux/compiler.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 1a506c54c060..39b89544adc7 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -66,8 +66,8 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 			.line = __LINE__,		\
 		};					\
 	(cond) ?					\
-		(local_inc(&__if_trace.miss_hit[1]),1) :\
-		(local_inc(&__if_trace.miss_hit[0]),0);	\
+		(local_inc(&__if_trace.miss_hit[1]), 1) :\
+		(local_inc(&__if_trace.miss_hit[0]), 0);	\
 })
 
 #endif /* CONFIG_PROFILE_ALL_BRANCHES */
-- 
2.34.1

