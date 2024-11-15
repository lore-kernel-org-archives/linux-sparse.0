Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB971D63E0
	for <linux-sparse@vger.kernel.org>; Fri, 15 Nov 2024 20:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731703570; cv=none; b=YXStTCdznq33JWaJmvli46K6LxqG/LloczsO7kRbhfep5ZQw9Rq7rkdRK2MzrwduY96QroK5EaNCp8fgoYc7jLUg7rZEov2Suw72GImdLR8fpInyRTZMR6P+FcqYMORnamNwcv+OCsgFtoIeMoUf0ust5RZp+9I3DAATs9+D4sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731703570; c=relaxed/simple;
	bh=XyNHVlWArvdX146gZuzHeGdpDCkh87/BT8U5Fy7c6Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FyHDXPo3f7nZifOrSd/ufplgeBVYITtNJFmRk6iHETNPqRzfS9wmhLTUGxVuj38zhIawfRjpkbnGTM8owN/wF8bh29fz7WF6bR9OJjtO1+AK46SmCS9LZbm8Plgm5a7USJb2epi+cLokf6jDs0SYNYHt8UwpqOzniJJPu53veZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=zKHB0oIi; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="zKHB0oIi"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9ec267b879so195487166b.2
        for <linux-sparse@vger.kernel.org>; Fri, 15 Nov 2024 12:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1731703564; x=1732308364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIsOzL1TL5S0a6NvpEb/SIB7nJlBKvKr3uCVh+cqpFI=;
        b=zKHB0oIisQSwyXlpKE10/xtcgnGUDd3v3NFV/BLHmzwcyyY2uIQwFeWU+3xZv7Zefu
         llcDAtjxbVVq368Co5EAOhqzLiXlaBjARbY+Zsiq7DaKFBXnCbZrkomyzuVzkwSndI+S
         r/h8v+xjU0XrrB9vHa/t0ZjMkL3j0ZnFUjnNcPl9o1rd8J7cHqhhWtEbvRl0R67t+GCi
         pG+2sRv773KcbOg/177gYMci2mATUKXiXpokpK7Cv9DndvG9Rq+4xt34fni8TuOnfgIU
         tSoqIawRQ4/ODDiobI2v2woiLMVEqBWjf+pzOe9kqA8yTsz+Qvh25WJVu0zHk8c2LHvB
         q2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731703564; x=1732308364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIsOzL1TL5S0a6NvpEb/SIB7nJlBKvKr3uCVh+cqpFI=;
        b=nYILzUzO+H9zj8Rfh3bnSHo3rSF87AHOCmEGrOFoOz9ym2TGEmoURiQehv8+BJHLQQ
         if9IcE3DpxOPZ1Bp04/sKkbmKhKaDOX/r2m11OipUPi2JSkrwynHAbm2HWQReaDxUBy2
         ntUDvLz1sPV7WURHnQRqLFkKcGM8E/dKUK23Eo7KcGrn0ppAE4NeN3qBJ5LrsDnIDMZR
         aH0G49WfJube9D6Abf2mwvkEHIzsgUYaJ7yFhy7hH1MnVvY1G1h80Gjo2Z37RuWLNmUc
         jW0rBY02k7uWprdPoTj8A0dyfhjYt4OdjE5s0WiHGXblWbUGI45r8jg/QiMSztxh69Vt
         Bk8w==
X-Forwarded-Encrypted: i=1; AJvYcCXz2Ygj02FI6NSC3/+0tTGV3T8PGEI78W8y4WdrGqodrpQrSWLRjNnSkXtLMwuug9gORmGNU7Uw+B14ycs=@vger.kernel.org
X-Gm-Message-State: AOJu0YymN8kp83McSvayMOb8/93GRhb2Bcws0XBNpaAT4v8oaoKs2Um6
	6APIo8LBM38cnp9K+yb6mlpzhZJQL/hZJ4AEwcvJTNEwFVAfGvISdjBoCTXDpNiHcy1uN/RVcEh
	AKaU=
X-Google-Smtp-Source: AGHT+IHrJIgFHzNI33P22/GuDZL5K7P5kle4zcvSF+rw03HRsCdnoxcq89YtrUp3Vdg+5KHxoucflg==
X-Received: by 2002:a17:907:70b:b0:a99:499f:4cb7 with SMTP id a640c23a62f3a-aa48341481dmr376258966b.23.1731703564587;
        Fri, 15 Nov 2024 12:46:04 -0800 (PST)
Received: from ryzen9.home (193-154-230-113.hdsl.highway.telekom.at. [193.154.230.113])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e046ea8sm214059366b.169.2024.11.15.12.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 12:46:04 -0800 (PST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	linux-sparse@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] compiler.h: Fix undefined BUILD_BUG_ON_ZERO()
Date: Fri, 15 Nov 2024 21:46:02 +0100
Message-ID: <20241115204602.249590-1-philipp.reisner@linbit.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <CAHk-=wiPZmd1hrsUoP+9vPg2=E0Jj6Li77_BZcV9GocbJg8fag@mail.gmail.com>
References: <CAHk-=wiPZmd1hrsUoP+9vPg2=E0Jj6Li77_BZcV9GocbJg8fag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

<linux/compiler.h> defines __must_be_array() and __must_be_cstr() and
both expand to BUILD_BUG_ON_ZERO(), but <linux/build_bug.h> defines
BUILD_BUG_ON_ZERO(). Including <linux/build_bug.h> in
<linux/compiler.h> would create a cyclic dependency as
<linux/build_bug.h> already includes <linux/compiler.h>.

Fix that by defining __BUILD_BUG_ON_ZERO_MSG() in <linux/compiler.h>
and using that for __must_be_array() and __must_be_cstr().

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
---
 include/linux/compiler.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 4d4e23b6e3e7..469a64dd6495 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -239,11 +239,18 @@ static inline void *offset_to_ptr(const int *off)
 
 #endif /* __ASSEMBLY__ */
 
+#ifdef __CHECKER__
+#define __BUILD_BUG_ON_ZERO_MSG(e, msg) (0)
+#else /* __CHECKER__ */
+#define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
+#endif /* __CHECKER__ */
+
 /* &a[0] degrades to a pointer: a different type from an array */
-#define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
+#define __must_be_array(a)	__BUILD_BUG_ON_ZERO_MSG(__same_type((a), &(a)[0]), "must be array")
 
 /* Require C Strings (i.e. NUL-terminated) lack the "nonstring" attribute. */
-#define __must_be_cstr(p)	BUILD_BUG_ON_ZERO(__annotated(p, nonstring))
+#define __must_be_cstr(p) \
+	__BUILD_BUG_ON_ZERO_MSG(__annotated(p, nonstring), "must be cstr (NUL-terminated)")
 
 /*
  * This returns a constant expression while determining if an argument is
-- 
2.47.0

