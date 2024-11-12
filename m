Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4941885A4;
	Tue, 12 Nov 2024 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731420310; cv=none; b=l7eZ+r2TxhQEIC20bE2RpZ8ACu4d+ax3cuXWiVDLUf2BFhi5waWNGFVjZQKpQDyeZrupxIq0j+in3LAx0cCedInZ5eH1jQQ+yy6s5/WxO72+AVFUwdTEKWtgJbSFXr0LXV1NADXzfDTtAZ2KeE1oMyagClyAI/PL7v2uSLeGNvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731420310; c=relaxed/simple;
	bh=ZpfuAYhFKoclFbDUPh8BHHiItTTKVdU+LMzqw74gvxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rizmasgouZD1jLBtuLkqP0cIg9ML6W83KJhL4ImYYn8hH0GZQHz0bZHaUtYjxfvEi0EG82hwzJM94a6j0jfcDTrNrL0AgOW8duvJZqnb/BJ87lPyCpy1raLuQITBBJyFqgfJx+k6j8jhADa85lufjrHv88DOWAVMq+XngusY6qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7242f559a9fso2856940b3a.1;
        Tue, 12 Nov 2024 06:05:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731420308; x=1732025108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dq3XLXJU/AnKNlxTOmeTq2X0+ChFWml7RLz6HCZUdOg=;
        b=Z2bH7wV9LXNu8fvD3GmrAGXR/tLdV7nOsTJs2bPrj+YxzLYboSFDOpxY7Zb9wzw1pb
         WVGd+QXt1Et/JmzFBdv7th97e+o9XZMf98JDeOERWvVbQQoMzM/mrr7x71pfLVvuYewv
         sC+IYnzLQ0E7RSuzEfqo+1SDxxwm3BJjZE7piy9eM1bzY+auULg70mMY0JWyPMONaI9F
         VewgJFDzu3wwvk6zTDi9h57k6xPe26Zhc9WIkGu0fqHGDemsR6asDEXkhAaUI8CbMuB+
         hKHmBpp9LOnTZLRGUtmaaB7zBDBdpnqVIJ4yBiuXF7yDv6JlA5w6i3Q+nm7XnLwojmqd
         3lAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGBC6emwvVGQUDOIyh/qPOw4FlzCWj23ojeDLXts2DhbOOC4aQv1K4y1kukl8Cuy0lw4SHhinPoCrZcf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8vKp8JG7YSb/Og1if4hrsgMN9EH6BWbyTNGIs0A3VbOhlTJ1r
	he4tEirvVqaY8Z6msZ2FOeQ9Q6DeKMYkFwjV/odUYqvdjQ4y3itR
X-Google-Smtp-Source: AGHT+IGPKRetxuYOODxLpn4mRetQBnacD2UxQzqmZqYxWavHJJtlwoB/44wnXSSWGNSjKx0WDj39yQ==
X-Received: by 2002:a05:6a20:1586:b0:1db:ef91:2e51 with SMTP id adf61e73a8af0-1dc22b579b3mr22725332637.28.1731420307713;
        Tue, 12 Nov 2024 06:05:07 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f644a23sm10480007a12.53.2024.11.12.06.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 06:05:07 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sparse@vger.kernel.org,
	Rikard Falkeborn <rikard.falkeborn@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v3 0/2] add _statically_true() to simplify GENMASK_INPUT_CHECK()
Date: Tue, 12 Nov 2024 22:59:22 +0900
Message-ID: <20241112140454.518823-4-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1490; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=ZpfuAYhFKoclFbDUPh8BHHiItTTKVdU+LMzqw74gvxo=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOnGCW0TLWftqFjmwRa8VE/UjNu9LFd8smmT6w6NZQa3T k5O4GXoKGVhEONikBVTZFlWzsmt0FHoHXboryXMHFYmkCEMXJwCMBHX9Qz/697sXS34pDw0LC1V ye4cX6/264IdPz9ZhdzSrljxtnT+e0aG+WITZK99TboYVOh++03ZjT2VPxgsOU0vfBPd2nvBMia fGQA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

The first patch introduces a new variant of statically_true() named
_statically_true() which rely on __is_constexpr() to produce a
constant expression result which can be used in BUILD_BUG_ON_ZERO()
and other macros which expect a constant expression as input.

The second patch applies this newly created _statically_true() to
GENMASK_INPUT_CHECK().


** Changelog **

v2 -> v3:

   - split the single patch into a series of two patches.

   - add explanation of why _statically_true() is needed in addition
     to the existing statically_true(). Explain the pros and cons of
     each.

   - use __builtin_choose_expr() in _statically_true(). The
     _statically_true() of the v2 works perfectly fine when used in
     conjunction with BUILD_BUG_ON_ZERO() but fails if used, for
     example, in arrays or in static_assert().

Link: https://lore.kernel.org/all/20241111164743.339117-2-mailhol.vincent@wanadoo.fr/

v1 -> v2:

   - introduce _statically_true(), taking inspiration from
     statically_true() as introduced in commit 22f546873149 ("minmax:
     improve macro expansion and type checking").

Link: https://lore.kernel.org/all/20240609073513.256179-1-mailhol.vincent@wanadoo.fr/

Vincent Mailhol (2):
  compiler.h: add _static_assert()
  linux/bits.h: simplify GENMASK_INPUT_CHECK()

 include/linux/bits.h     |  5 ++---
 include/linux/compiler.h | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

-- 
2.45.2

