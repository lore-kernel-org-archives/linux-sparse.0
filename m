Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93040366572
	for <linux-sparse@vger.kernel.org>; Wed, 18 Mar 2026 06:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773815918; cv=none; b=mWyQbu2sOILSzIthwzJRWuRHpGBI6uKp0Ysux9NGLL9YltH9G2bYiB8cp/3RYXvqclqzrY1hAa2/EugqMgoffNjY7yrcSa89AauX7gYZkPKCFtXoiG35Ay5PesIt3EbxskyigkFZELdXpy79o3N/T7CjRfEXZUJKWL8P8niE7gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773815918; c=relaxed/simple;
	bh=JSKHGrlqsKnrsVhXbMdiahs3quAeSPF7dE3mzYMVCP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBZyqO0WsOyDKOjakHqWv5snY9SwgJYen3ZwOHsBTMB5lYijw8S+j/N6pPcPuRfEnjbWoLz43NRaRYchtnBTJI8L/uwklk7Pn6CyfJGOm7kzUpZJr22ctamKCRdhIV7hwv7ZwfoMasxV+nZwDYrfea2O50Runx0gmhgKkpwCfA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xh-zhang.com; spf=none smtp.mailfrom=xh-zhang.com; dkim=pass (2048-bit key) header.d=xh-zhang-com.20230601.gappssmtp.com header.i=@xh-zhang-com.20230601.gappssmtp.com header.b=e59yv5j/; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xh-zhang.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xh-zhang.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xh-zhang-com.20230601.gappssmtp.com header.i=@xh-zhang-com.20230601.gappssmtp.com header.b="e59yv5j/"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2c0e3a2605fso1749688eec.0
        for <linux-sparse@vger.kernel.org>; Tue, 17 Mar 2026 23:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xh-zhang-com.20230601.gappssmtp.com; s=20230601; t=1773815917; x=1774420717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSKHGrlqsKnrsVhXbMdiahs3quAeSPF7dE3mzYMVCP4=;
        b=e59yv5j/qPjLOU0G0lYvEBvuGUGEfylOoX6gX1ZCNoa5kCvOupDZZNi4TcG2KHUn42
         /2pglw9RSATwFEiuX4laK6+L+s1UUZyJHMnrGGc1JmvAsWoIX+1yOu94PDVxkQUQLjuy
         7r2a216nUY+4gDN1zg3nfdjFMrhev6O2c2ULBt5FcMjols5BASCC+gTBmCjG+0OZqe65
         l+8L5wApeApEBpdK2ZgX3GZOTukKDDqCCzRkOiRgMSZLqcqo95DPCW2cy1hm4redY/XT
         8GncoWyBFtt7uJCHANeV50QsqdC0TRMTTr+jlqi+/MsxAvWXgW3gealW6KPieqOezUcv
         MLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773815917; x=1774420717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JSKHGrlqsKnrsVhXbMdiahs3quAeSPF7dE3mzYMVCP4=;
        b=qJoY5MXl6UjR+pez1lnTXebcETmUc1ZDDzrOq7VXv3Asq2MEQiKtK1NKH+dLyMQIfR
         51ZrrpVKi1MzD2+A2A+OXnOo6avXXQ923KGkdOYvYCw1hAoJH6uFkqktApvzfyXqNvsG
         7dOek/wxIPDjzfKiQzeiCcTq1qsoUxhJRAALXKjMpAnzYAObIisYnYwXIyZqvqlV7Fic
         sxmH0jNSgUsxTAEagVv6S83RuAuPf0Ch1o+8n/AP+3MQbsegmEGFHaUXik24BF3+RsRl
         5BzapWouoSwCmvOzFLqvEM/xEp4WRONiNxcmzJAsOzxTHiwSsxUEt3uBTjnfJkKMwda1
         cgFg==
X-Gm-Message-State: AOJu0YzCbts+8pB+9Abcb7YTeVXkyh+Tl7jPMstRQr/nCGhuBrAOo1ot
	dlu7bP0rq1yk+T6Rz9Ct+y15mUBzDaiOpzMjhcflbcOjQxVi9TIT9X8h25SJVg3u9k8=
X-Gm-Gg: ATEYQzy8wE4FBnHZ1oXEncpCHI39Rw2SCEMN1kfll/n4z/xdrrkNOALZG1HSKKpl1N1
	N/HNIP/MfrAQwGDfAFQLHdnU6gAFGF8iCIR5ZQw9Z7k9ot2fBFFprc2h17IbL9JDK2v05N2g+D4
	FblBR7jf4ctNzm6OExGcG7SYBjO711DOItwN8kju3zUgTrTKyORcYe+D62T3j16sJVNqXqNbhmv
	V5Ewm/wAd2fP0wsqNlN+12fuUfclzxpNnIwBfMyCbmLTWAwzv1rJyG8kfxn59nW3FmqVqZplwlx
	yCEDvrFcKLMKeZpYaD6LkI/Mp2cB0/Hse6tSnjHS76Exjo00Y69j+SnS0n2G8QPCaNQwrGrEIxT
	PCW72q3GqG/fiauVqpwVOgyH30ZO7LX4vUG1Zt88so60udLC7FhJvgCCTfViN6FOaOFOHKiJliX
	m9YkijrR3r6RyCr9p4l13DSWQaGbWyBzzMtwLFPNGixg==
X-Received: by 2002:a05:7300:2d24:b0:2c0:da6f:55e0 with SMTP id 5a478bee46e88-2c0e510f680mr1062265eec.27.1773815916542;
        Tue, 17 Mar 2026 23:38:36 -0700 (PDT)
Received: from localhost.localdomain ([73.223.85.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e53b5235sm2539194eec.8.2026.03.17.23.38.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Mar 2026 23:38:36 -0700 (PDT)
From: Eric Zhang <zxh@xh-zhang.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-sparse@vger.kernel.org,
	sparse@chrisli.org,
	torvalds@linux-foundation.org,
	dan.carpenter@linaro.org,
	Eric Zhang <zxh@xh-zhang.com>
Subject: Re: [RFC PATCH] pre-process: add __VA_OPT__ support
Date: Tue, 17 Mar 2026 23:35:20 -0700
Message-ID: <20260318063520.56727-1-zxh@xh-zhang.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316065622.GA607739@ZenIV>
References: <20260316065622.GA607739@ZenIV>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---

On Mon, Mar 16, 2026 at 06:56:22AM +0000, Al Viro wrote:
> That turned out to be trickier than I hoped, but I've got something that
> works.

Nice! It is much cleaner than what I had in my RFC :) I've tested the branch
against tests cases in my previous RFC and some new tests, no regression.

Tested-by: Eric Zhang <zxh@xh-zhang.com>
