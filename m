Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C7025D540
	for <linux-sparse@vger.kernel.org>; Sat, 25 Oct 2025 21:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761426933; cv=none; b=nnn07KuCVS8nWf0MYHLtozq4h1GAUjiXkAS8QvR5MRQd+AIwsjUOuzre4Vi3FzclqjuvaTMROh70CAgeVpFZZLv+Bqz/ZjaqU84kw4055UakGUQxtBxzddfGURy6XLULbnjLcOLZYOcCn6CxAvn4GJ+2oVpZp1A7BHLuIjefO+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761426933; c=relaxed/simple;
	bh=YIt5W8cIb0X1EX7D3mZzrt6mSsJVraQkyhoeystXHgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ow1t6ZwTznFaLl/vpgkcNlzVW52z8JXJA0MBdTf0aLXlqTwy1T8DyQaQgChp6n3Py534ii/Coi+jObbjKupBTYJVS7J5GjZRHKu21b3GEQ1KwxNTg2w/y0Si6G5FgHdrQuAU4lj2v32rB42I6rEJuCitiLq47iRXI0C883Qx2H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHf41iPr; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHf41iPr"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-430d06546d3so29993425ab.3
        for <linux-sparse@vger.kernel.org>; Sat, 25 Oct 2025 14:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761426931; x=1762031731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CpxIzQxCEUpK6n9kIBd2SvULfRdnkrX6Efe1lyf+a18=;
        b=FHf41iPrg5LKnyMiwuj5mIa5bdgnHvLosSlI74TcMXBRBBWQyiD0Yp5YgpNGIyKgFV
         7+GEyFUgn9g994s1tn9eWUyjvVLox9dIbKsNlQmVbGq/kD3r0jLY1aFLeXtG4GYpepHt
         NIKESvOFIUGvD1DgFi91D+Y+SWkyDdDxdpZt1U/Zb4N6hI1Up0kUPresSnlf5bA3+cD4
         pkG2UTMjD9TY10vrR/zqtM39CLDkxCjD5XUqA6r++4+OkP5WDvyeXXYPpUVACqRcWV59
         KsfNxnQ8MGN/HEunNArofB3KhlYuMwyYt8G1emz4Gbn+/8NkGtOEF9kZFy6DTejI+Dkl
         Pqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761426931; x=1762031731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CpxIzQxCEUpK6n9kIBd2SvULfRdnkrX6Efe1lyf+a18=;
        b=QuCv4Ka/7tLmJ0vBRRyp3x6UDkMWK5vRPODwyeIF07USnZpuKaCiwQsXBBXCC8ypmO
         To4ZAWRn4nnwYArcRNqioH+8Z8e8DQsMI+jRtc27GPuwP2vc7EtTB7fT4flAJjVZ6xIm
         KQrwU1acJomef6uDUB6lN5mR5R/Bg0GuSRZapszrq4z7xEsWXSM2W10djkkCob4i1bu2
         /CSsE+P2iJN8kuY+mm8xdPqT5peGW0G5ni+eCWLMn5BuHs74qDZsOOU+15kN1uxyunNv
         FeUE2jfrSbTyUhV/vUrmxql+ihB9ZSqHH8sUpNSnvp+LZsgDUJKjSu+zT/0zj/5lo1qq
         hlVg==
X-Forwarded-Encrypted: i=1; AJvYcCUugjfPLCC+VQ0uBv9mtjjiOlhQwhJqdThiMPHIKLUhHXB52k6IfsAGDzh1EWcVSWlWZzVKiFkQ4Fp2aus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx/f/T9PCqDWTY27/1uTchRlbCXLmQpoxo/0Z2RJMoYR/I5OI7
	c4sgKwP04Z9YewVEBICCZ0sQzzBHUs8uKB+UzNliVNj71/JjAC+R1Etj
X-Gm-Gg: ASbGncvFEUhUswi+cjb/469bvjgURKD24zATZXDei4KcBlnuM7uEdaqNLCiGSkHhe11
	4t5KSnTnR3ZkoiIaArdvxuSBYK5dLamCXSTZ2zd2FbKYJyIP9GAHaS6pWRz88eWk0bbeMzjI9D3
	3vWmPY0+PNYhORxGvzj8xfAqLX43uwDqr5ElfZBhDTvzX0N5zuno8j7Ly44E6GOktDjarJ1sqXf
	rCR5EMWPAy19HCk6/Az9FHPjjZfBXaLJ7L9ukZ2BgwE6xAkX+SNNiLa7vQhelN7JJbl8IHJoHye
	ZDwKeZTeqiJHcNHxgmcBkcwhb5bbWWnbTknrrgotFpEper6w5u6ZvxGD53XP0YXydt3nh1mASfD
	hcGNn/QXJy5RmTqFg3z6X0kkdLrnzcBbq669FVjdLX6jN+V6c1bJmtsHfT4kAKO1wg3m/L7kiWi
	Fie/oWQqhiu4yxQApnAZSG3KUgPbKSNo3maPxrfdV1jdA/hQW/+91bP16CNF+hRrF5ynM=
X-Google-Smtp-Source: AGHT+IGIgS/o8KzcDeeeXUvLcXQ6ivS8Iy0YVOQt9yZ4YnWY3OYklfF/++t7JjAGGT94Zdx/3hrF2w==
X-Received: by 2002:a92:c263:0:b0:42e:2c30:285b with SMTP id e9e14a558f8ab-431dc1e2690mr114635585ab.20.1761426930905;
        Sat, 25 Oct 2025 14:15:30 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-5aea7ce584bsm1212138173.27.2025.10.25.14.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 14:15:30 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linuxfoundation.org,
	Jim Cromie <jim.cromie@gmail.com>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	linux-sparse@vger.kernel.org (open list:SPARSE CHECKER)
Subject: [PATCH 3/3] compiler.h: add __chkp_no_side_effects() empty hint/assertion macro
Date: Sat, 25 Oct 2025 15:15:18 -0600
Message-ID: <20251025211519.1616439-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025211519.1616439-1-jim.cromie@gmail.com>
References: <20251025211519.1616439-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpp has no intrinsic protection against macro arg side-effects, so to
compensate, checkpatch is paranoid:

  CHECK: Macro argument reuse '_var' - possible side-effects?

Allow an author to suppress these warnings on _var by adding
'__chkp_no_side_effects(_var)' to the body of macros which trigger
that warning.  This may reduce blowouts in CI pipelines.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/compiler.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 64ff73c533e5..96f6bfbd4088 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -379,6 +379,18 @@ static inline void *offset_to_ptr(const int *off)
  */
 #define prevent_tail_call_optimization()	mb()
 
+/*
+ * tell checkpatch --strict that you know the named args (a subset of
+ * the containing macro's args) are safe for multiple expansions.
+ *
+ * Prefer ({ typeof ..}) or do{}while(0) when they work.  They would
+ * not work on module_param_named(name, value, type, perm), or on a
+ * locally useful "for_simplicity()" macro.
+ *
+ * NB: use at top of macro body, omit trailing semicolon.
+ */
+#define __chkp_no_side_effects(...)  /* checkpatch "annotation" helper */
+
 #include <asm/rwonce.h>
 
 #endif /* __LINUX_COMPILER_H */
-- 
2.51.0

