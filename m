Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486943016E0
	for <linux-sparse@vger.kernel.org>; Wed, 25 Feb 2026 08:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772007275; cv=none; b=gn9BmNunF6Ycj/XEUa9T/+YpHIFKn0MXjt3EEebqO3SOOlPrvLXyBmCvMxHmPZ1LdMT8Ms2j5zWxdwZOstenzmC2nY3BeEzpeGbm6/8FbnlGeQnAUSC5+nUQWPsrDULdAHggdlCKVxqTvINDRzILTrVgY1dx5DWOthPQ5D3CSfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772007275; c=relaxed/simple;
	bh=LfEN/UDtBI3vH6PuZ7QjhKjfksF4kBijIhnwrR+f/Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RROQTiSOkSARs4qVdxU0sF8B08YpfLmR6Q+ZOIUMIT0MsSXI+P/x352ou3y/2R0ub9SnGeSQEFUrA80bhSca3MlkE9Y5rVdQrLYybRzjX/4Si7Bef1hBuAlwufHH7AGpmP51f78ajepggyIDb8hCbqWHdqbrWHvGsClXhvEKhV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xh-zhang.com; spf=none smtp.mailfrom=xh-zhang.com; dkim=pass (2048-bit key) header.d=xh-zhang-com.20230601.gappssmtp.com header.i=@xh-zhang-com.20230601.gappssmtp.com header.b=dG45FaoT; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xh-zhang.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xh-zhang.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xh-zhang-com.20230601.gappssmtp.com header.i=@xh-zhang-com.20230601.gappssmtp.com header.b="dG45FaoT"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12776bebe9fso2269217c88.1
        for <linux-sparse@vger.kernel.org>; Wed, 25 Feb 2026 00:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xh-zhang-com.20230601.gappssmtp.com; s=20230601; t=1772007273; x=1772612073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oe65nbWliCeoNLKFI+BnSIo3Svt+mNtJlur2wZ7B8dE=;
        b=dG45FaoTUhC7uHkMCsM0KNq9WgXW6LFAUB4XzyOK+ZY/g8Iz7YodzlrRgz3OUAcPBF
         BZmBuyBMlsZ6j1zWSJwV1KP1WyiMSrlkcHIokmcdntuPNSah5K68BtAXUgXmYyaHUwzZ
         G8Yc6561T0HNO74wEDvzCmEqrboHIwsH34uwx50sa1tHcDuizwSvPGxszy4zpe23vZRR
         zj/RqMimGRIemVS5+V+MPM3xRe0TyaiFlJFxGtbP46AJHYBy1zVSNR+IYTaYPcOnUNUp
         0OY9bp+2xSr3n5O+dmQ6Ik4Z2Jc31hTHp2r7doGGHfk3nNfEMa2+De0dY0so8fskD0uU
         c0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772007273; x=1772612073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oe65nbWliCeoNLKFI+BnSIo3Svt+mNtJlur2wZ7B8dE=;
        b=m3z+cMpKdZFuHwvH74sswP82pzx0yr5Fu6t0IbXR2bPNPegJfubJq2VBGXtqWymEx2
         fTSnBz0/Gtv56ZdqlKywmfw3+lyA39yPm3YVS5foS1wm5gnmoSfY11GXyCzumy1bq8sh
         QkZqqotLTxnG3Kfs5rTo1fUwqZcnW6ESBkQJhCT9pEPWDfCwJdeW8BGFgYOgc1orcyXv
         0Y10yEqmpu/X85Ky/ED8N7GohNCEcv/JflPfAfZSHvSYwfrXVSkf/Z6P+rD3YZhUBZIU
         4YSvn5dVQLOj53rxSMw824p1kGQ9ElcbPMbGyj8/y404ReHzUpLwo3G5MFUioLRXeszF
         bJTw==
X-Gm-Message-State: AOJu0YyQBQo9OXQUjMG6XMIcs2ZwVJV0V5RsOyG4N4BgjJKWLOPDPmEH
	utn1D2mP84kCrTmG2ffLDTyxfzzh877sZCVoOBHdvcaisXy4jNQyIDhzeqf8k/h9DYTy483nxFv
	0NGLV
X-Gm-Gg: ATEYQzwvVhd2QIyx+61PxxOTDgsQtOSmFZRmQXKHYbAyehYuK0EPY/d4O31Rl0ubZYK
	zA/5UHtewe8I/sms7BPUA1TsAkh0J0MKO6pTrCdhINzEnb5EUPjyC6q3iuHkGivwCw2oBtWZcvE
	G+fotR5cwA4oGyuM7u7YS7boyNT2sTeOThzuPlBpkIRyh5RL8NNTT2nIC3m1tU4gANIWT8WE4oR
	9XKu0Vbjx15n6jUiDWuhcI2MiSWmr3Dsym5VBFdr9oznB+HH/+H1pFpcEiJNmQrn86PGEZPpUFJ
	DMS0W9kkZNbsM9nVQXS3kV9hbelGmOHvK3TkBrS4QUdtKsMSiaO2XH81zlvcC3xQTK9dcslqOVt
	7oRvnSyZA1e+NVD6XN+qpArrxCTJYxMgk1/2oOr1fvN2I1+pW7LxwuS1prPdmkfD4w+buYrjdnF
	pIZ4qBzLq93gMA8BpMnePQjEri7HHi
X-Received: by 2002:a05:7022:90b:b0:11b:9386:a3c0 with SMTP id a92af1059eb24-12781f1c63cmr499869c88.43.1772007269817;
        Wed, 25 Feb 2026 00:14:29 -0800 (PST)
Received: from Hurricpc.localdomain ([73.223.85.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af2edd7sm13595195c88.8.2026.02.25.00.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 00:14:29 -0800 (PST)
From: Eric Zhang <zxh@xh-zhang.com>
To: linux-sparse@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	dan.carpenter@linaro.org,
	chriscli@google.com,
	ben.dooks@codethink.co.uk,
	rf@opensource.cirrus.com,
	torvalds@linux-foundation.org
Subject: Re: [RFC PATCH] pre-process: add __VA_OPT__ support
Date: Wed, 25 Feb 2026 00:14:12 -0800
Message-ID: <20260225081413.2480484-1-zxh@xh-zhang.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225072731.GA3093958@ZenIV>
References: <20260225072731.GA3093958@ZenIV>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Feb 25, 2026 at 06:40:03AM +0000, Al Viro wrote:
> Your variant will break with __VA_OPT__ following #. It won't do the
> right thing with ## either, AFAICS, in case when __VA_OPT__ token list
> is empty.

Thanks for the review Al! Wow|Hummm, supprised now they support case 
like foo ## __VA_OPT__(arg), and I just noticed you've pointed it out
in the previous reply.

Maybe split parse_expansion() into two passes could fix it, smth like
  1. Convert __VA_OPT__(...) → TOKEN_VA_OPT_START...TOKEN_VA_OPT_END
  2. Run the existing #/## handling, with handle_hash() and
     handle_hashhash() taught to recognize the new markers

For # __VA_OPT__(), a stringify flag on TOKEN_VA_OPT_START could
signal substitute() to stringify or produce "" depending on whether
varargs are empty.

For ## adjacent to __VA_OPT__, the existing Concat/Placeholder state
machine in substitute() should handle the empty case naturally once
the ## is properly converted to TOKEN_CONCAT in pass 2.

> Another problem is that having no __VA_ARGS__ in the body should
> *not* be treated as "vararg is empty"

Missed in the test case, but it seems like it can work in the current
version.

> I got stalled waiting for gcc folks to respond, then sidetracked to
> other stuff.  I'll resurrect that stuff later this week.

Then I will look forward to your approach :)

Eric
