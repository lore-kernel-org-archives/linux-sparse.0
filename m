Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47ED366549
	for <linux-sparse@vger.kernel.org>; Sun, 15 Mar 2026 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773588907; cv=none; b=FK8s6KwW6ruUW3frijFokiiv9FLkG85Qyl6baSYnl3qGqZIAgSVYdssZtFx1mUYuhnqbXDOa1Y5fhObWXLEkIuYduZO4d0lD2zaDePddcyLGVlk5C9+11oR+SfzVXilogqA7HjjVOJ0ESVdRbiDahmtilzcg55LG8lU7V+k9eI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773588907; c=relaxed/simple;
	bh=3nHPrYkE6pv/4/1DfTqq5Q/6zKZT5WTy5/adihmLhkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SSFvNDqcccf1lKcP/9ZR04f20WyAmVziKen5SGiUee+cZ9p2F1tv50c7jX8lJN2VIr6SNfGiuBAoy1Ms+ashtHv46c8rmSdqI5ACw4yuiAL5GHyLzq4dVfz1n9G8oL8kTc3FgRFMUe5kYR+nTOreE8hqhQCLVvpAvw1MUv1lF94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBEQXfuc; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBEQXfuc"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4852ff06541so41616065e9.2
        for <linux-sparse@vger.kernel.org>; Sun, 15 Mar 2026 08:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773588904; x=1774193704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hrjvjumYltVAwXhuOZhtsO0BdLVs+pjJ01okEnUOrY4=;
        b=KBEQXfuc1oANajJPNvi66E74peC1ZFSLfs2UOjyAXIkoOXvl2BFzmv5uGrYcPV6fdC
         uxKT2CMC8Q2PN4XvvFvSg18hXY4Iv9C4r4XcWSbEVQy+++vCqj/+RoElcIz2q7t3oG/S
         mFc17D6Qzn66qK7SRG2eLkaCNwL9VeERSyhFmg4uzmEgvi7zj8RODcF2CqsJLZmrli6L
         BgnLY4oxHHYyhq/BjTTz7To94baCFev9tlUA/EdH913fHP57YKTYG5mUp5WV39sxMCZx
         W0FuqFwYcjCfKi+OkNkAELcP4OTHGphda1U/1F5BXhmHgz7eMh/XAke5PuZ11zG36r9V
         1rug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773588904; x=1774193704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrjvjumYltVAwXhuOZhtsO0BdLVs+pjJ01okEnUOrY4=;
        b=sAAeMGz6TzRVwO2OnUyM9tMj6TNzQBqaHQMmYmKl1KhiUKOqKhnAH3piBNFDsvLreA
         Ig6l2N7Te4XApHqkftuHDfN6K1RLisyzMgeRzwj1HI6rBgGB7JHG4R2h4EP87CGWwPHW
         f/wWip0tRkxMsR0nNhqT6TSt42k1Qa6nEZOn4WmsrBPW/feTpPUUcxhiLQloPcDU/Mb0
         z86BU0u/QMR691WAXFVYXBE/SHdWbTUmf3M8YlThf3wgoNMdhIAY7EW42HPtoji1vZgA
         AA60/FPrPmIN9HQ7qK+NEArABkrJ9oPEJsNkjFbZq0D5c0ktgtKips5Ilg+U6axk+zhE
         k9eg==
X-Gm-Message-State: AOJu0YxAWtROipGkig2GA3qPyD3jgBaz0zVORTLzc25fMyPnCLIvxQy4
	kaAGwB182OQj2sU5Jil1f84H/eky6rLqEnh2TQl1vil1ChIi+UlzTycx
X-Gm-Gg: ATEYQzxnB3AZWmChWz2IlbPzTxPsfJuB21IhQZa7/rd/FbakF/IJdyN62xsYzjryA+/
	xsEX1T5R+KPAFfBp6TvBBlyc0wW6musDPNk2pYUwNa2hYKtE6iGMOk6/XUWNEHr+vnIAyyOID9p
	madru9Bbndlx8+Bziygne2G1yDaZkk2zsi6WS/Y3r5GZyatxelwQLFL8Y/o+g+TpFvsYx8jRLaK
	5TR1ewzDuhCgbuTH0GxC0GkUjTjWYDVU3UEbjC1k5HXDFRNQXf8aV53BrZK41w7Qspbx7zQoYm1
	1rot4tEB399h4vaghS5loenJ5cUduj72oapOz9zEm06rO6LHWpOcx2kQh+nFoNmuolSf7HYnKjw
	E4JzIFH76S3/zqps35lqSl1r8co0ddx42PMb38Dlp/9c9tGUY9+kJq1PmRf/k4Wp5Rf7GSf0oi5
	IkIPylhnWrtdDxWS+9ketvXr9gTyPXDhyVbK+Rke1Aj4Zb5YGccfogCpzadytsokAKh83BVsTTL
	8aOnolqSLOohILGsYKS1SrV9VFatg==
X-Received: by 2002:a05:600c:468e:b0:485:3f58:d9d with SMTP id 5b1f17b1804b1-48556714b67mr162467565e9.32.1773588904175;
        Sun, 15 Mar 2026 08:35:04 -0700 (PDT)
Received: from DESKTOP-TILNSD1.localdomain ([139.47.104.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ad1e4esm455446475e9.8.2026.03.15.08.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 08:35:03 -0700 (PDT)
From: Kit Dallege <xaum.io@gmail.com>
To: Chris Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kit Dallege <xaum.io@gmail.com>,
	Claude <noreply@anthropic.com>
Subject: [PATCH 5/9] compiler.h: add missing kernel-doc for data_race() @expr parameter
Date: Sun, 15 Mar 2026 16:34:53 +0100
Message-ID: <20260315153453.48535-1-xaum.io@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the @expr parameter for the data_race() macro that was missing
from the kernel-doc comment.

Assisted-by: Claude <noreply@anthropic.com>
Signed-off-by: Kit Dallege <xaum.io@gmail.com>
---
 include/linux/compiler.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index af16624b29fd..4ae001bb6442 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -171,6 +171,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 
 /**
  * data_race - mark an expression as containing intentional data races
+ * @expr: the expression to execute with data race checking disabled
  *
  * This data_race() macro is useful for situations in which data races
  * should be forgiven.  One example is diagnostic code that accesses
-- 
2.53.0

