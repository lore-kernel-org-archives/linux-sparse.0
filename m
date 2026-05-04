Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470B834D4C9
	for <linux-sparse@vger.kernel.org>; Mon,  4 May 2026 11:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777895959; cv=none; b=iB0eylDWHNVav78L7/bpBrQblQCQmmh71uo8hmOWYbIfhC0MaN0hIzSxA3G62zfY6TZrEty24bbtjQOwVHmCQHvhZvE79qaCzJ6M3+p9JrUcIODbaBFflHzhFH50N+Fm+u8s7GZwbwcdnGCBw7fJsWXitgZxdoUuy7O0iFY01xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777895959; c=relaxed/simple;
	bh=dWwjaaxB4afPo2tssD4+jYMJnZAckMQUeZy1UW3u9/U=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fPy6Uc8tIuB6Ry1TzV96n40oYOozj92cl0JPhtLQIXTDX/96S+uobDJJmS93KyqFVSXN4R0Uav0MfJ1HuvXbBWIjRQRGFMZcOSzcmnOqXa25nBYRhCi5ZRB3WghJ+/xW30pSOPPKij157xJBT7Cjqw8ctEI5uB6gm6/6Dfd6nAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0qE5Vc8; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0qE5Vc8"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so59551485e9.0
        for <linux-sparse@vger.kernel.org>; Mon, 04 May 2026 04:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777895956; x=1778500756; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8QdZbDSqdf39to7MlsSv2ols1BqM5d/NA73YfTbyr6E=;
        b=l0qE5Vc83SvSkoiuKhzk6e/1tvkg1D4mluBIwqWgLFtWApG4uoMo9nI9wKLZrk4Dc/
         c1gLRzB+81D+q8FzO52jtqlA9jk8r4vFDxqEnyGd6NmR6ui2/bNMAbY/M6cIXGZNTuZ4
         CCUAKFXA+ask9EaP42QymvCCYTlLpwYeQn52QUr2/i3hsK4R0P4glOtS0TTaE9cDaXli
         /NBXJgVIa/ifTCMQD/Bln00F8AT7Hh84c7VAdQBBnd0fkTFmirjxHeTc2rWKTlAlV6V8
         hayZ2GzDmI1BFRUEqZFu8pWjxQ9bvGCm2Auz7Bz4MaBLZO0Ut9Xcj8PEUkXnzvUJVPdX
         TzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777895956; x=1778500756;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8QdZbDSqdf39to7MlsSv2ols1BqM5d/NA73YfTbyr6E=;
        b=YlOOrNVJv9pEVgmz6pC8El62iUFPSS2FAO3FxY/lQSsPtPjVJ2rsG4BPDj8CapWiBk
         hOhCjXnykrnze9HXMAhKEDV2ZxZlV2EIOhZfar3jaOkbbQih9zqHGzE1XYHJSiYVDtqs
         L5n3PDb72yVBYSbTqPBG1CFN+q8ZmKWUnBkQdTQ2BIFRQkL9IwwhLTLwIGPMfOPtamMR
         aL3HNr0m5pDtXByHWhLPgmWG1D+KYDPUqeo0FJblqSKU2PGV8pU4edp0f3SAhMb7cgdn
         7R/hpGq8qKOM2L5WCJfIu6s9rlfSVPdKmis+aJ1ypaCjwewh/YDzrEXRlH00gAJt34cU
         jlww==
X-Gm-Message-State: AOJu0Ywh8z4+iEB/uguzDmZMMGKqeFdcdkdjcA7yEPU78V3bx1cZWxUB
	PeQMEsv0USDcsZMhYvQwmseX4A1PK7zemW5S6b/mflBLEwkBaAubK9KQbbV6Lw==
X-Gm-Gg: AeBDievpTE4gMJDTm8CkSbFjAFvHFo/9NGYAwm+z5aWknUWRg7cqsBvckTreSfoku6H
	I4d4rnsAeKJjbvPLClAexFCCeqr1GBpOos1KooShO2i/5GBB9D/G2FMY4OCsRWCRAvTyMDrXu84
	+4ni6GBw4ml+t+8zDXDMQnBag0A5KcCm0/HEW530Ip5Dk5TvlUBn52/gMlLQSnCUFViQVtMOe0d
	htqZKWMyiwk9WJ9SMZA/J3DEGHpSpBdcZy+8za5vlGNUBlpPFFkKuLPagn8Lgryek0uUjTZLNRJ
	fLyGjNCgPwNxgzwteLa1WFFdOBAN2afJ80GEGOtBliNVZW01uT+SfvqirH++W5pH+I0lg2M68VG
	62tCbE0XeYVgesaRNPHFpGKQqwN9oDVK6wztfFVu+SQWj54e0J2eLqolrkvwxcWVHh7XH2UHMad
	NKmYZhkCfD3uRoryFzJamYGZCGNHwhig==
X-Received: by 2002:a05:600c:4f09:b0:48a:568f:ae6b with SMTP id 5b1f17b1804b1-48a98539197mr145452535e9.7.1777895956026;
        Mon, 04 May 2026 04:59:16 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48af0d5a613sm95037465e9.2.2026.05.04.04.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 04:59:15 -0700 (PDT)
Date: Mon, 4 May 2026 14:59:12 +0300
From: Dan Carpenter <error27@gmail.com>
To: linux-sparse@vger.kernel.org, chriscli@google.com
Subject: [PATCH] Makefile: Make the compiler selectable
Message-ID: <afiKEO8oHotKfVRk@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Allow people to specify the compiler.  For example, if you want to build
with gcc-13 you can use: `CC=gcc-13 make`.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e172758b8b09..651035ab0f77 100644
--- a/Makefile
+++ b/Makefile
@@ -5,7 +5,7 @@ VERSION=0.6.4
 OS = linux
 
 
-CC = gcc
+CC ?= gcc
 CXX = g++
 LD = $(CC)
 AR = ar
-- 
2.53.0


