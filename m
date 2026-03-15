Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C203750D4
	for <linux-sparse@vger.kernel.org>; Sun, 15 Mar 2026 17:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773594576; cv=none; b=Uc7vQUtxALgLeWe3RpSM5bCsYFfXoogfLvCs2iL70qH0r/F7gBx+8fj9YfAKS95g2nRy4SJHknNzTFEK/arIrbOZTQNZEyVHD00FhqwauTURsSz4GRd2zcaJnt9TBs+oW13vRYicYO4Z/HgAqqLr3G8nzBzrMJVYhUneK2gLJ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773594576; c=relaxed/simple;
	bh=uGEKaHVj5p0PcWSAv/4mPcoT5h+9/8QdSr7eh4aaJkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HBtuaGuM1nRxHWAbzm4nryytK239To+CxRgH1zQ983s7qCGTp8nh6xzEPkjT8cPgDirSiMmrtv9QKyRnHmDFzBWZTJpSNqaZAKhPO6NP4iNZSKDD4GFPHRD6BuGoEdWl/JqWK6RnVq4Sv3v4hdhtE0s+loZpNGZQ1MIXD1fUG0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMPyGPko; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMPyGPko"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439c6fc2910so2933809f8f.0
        for <linux-sparse@vger.kernel.org>; Sun, 15 Mar 2026 10:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773594572; x=1774199372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=34SF/PLsMsU3YUR02wXTLJFGDh8ZBCdjliXWqPe0VBI=;
        b=CMPyGPkoX7vyfxq/ZBVNhRJ0qW7fAd04jeZ1RffSzOcRN91HZXsjaaJiw1SKR8IPTi
         eeORuhguKEQ0nx00zKJJ3UENHkZgX2hsck/rgVPT8MCkrv7k60gTpfPxPTjkoJMkZ3dM
         PW+0HAga9UADnnKxiIhH5iB9IogmPZbM7AaRi1vRRW4Y9lE6bU0X6ZImoRf6I7ScTWG+
         ht+ZUQ/wpWTt8zaqTOy9Ahy0zGgD2Js4Z0i14sLua48GnUdsaisOo3eFrOUCQ1Kn+bZi
         GqPZ8eVdosGl6ULYeJXTtDlyhaBc6uNxOM76kfp3XrqaRw7eQeP06CfgMOuRi+UH6zBP
         g2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773594572; x=1774199372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34SF/PLsMsU3YUR02wXTLJFGDh8ZBCdjliXWqPe0VBI=;
        b=MuMWUw/slKtTx50zjZBSb586Mn659UP2/dCz5Wqc8788mn9xLCt6Kr6XjbI/xsb14Q
         v8XFegcJrKcUwtw34MfTZLvIkxejPfkVISv1ENsmJC9Xslf/H74Ts0a4sBVFSon1vq3I
         eFQgLPt+8Z8CSZYFokYo85WkCsoaGAhvwB6wOykVSgfrIeuBC5Wg0CVaArARveXQttlx
         6/VUsi41mjK8sWbeASTWqU5ECA8AaxnWweob5eNsPXAQWMh8M9EIbj2TGBCe5EcIWmTy
         vOLLnQShxTVmcly8gLDEkhxHcXaDq+JKCS8BiiK3sZlXFAvWO/6ZpPpaBOw76TTQA1Pw
         lLrg==
X-Gm-Message-State: AOJu0Yx5aUDVFeRbc+wWsPsAWjQe9HcAVoql5Z5U8IXsBqgqFOw6vOyA
	xQp4A62SqYKSEnDm43iSemsUHTAeC344AybZh+GcA9SwNvWnaOqaFn64
X-Gm-Gg: ATEYQzw86hPmEfP03GHMUcq+S4MfAzPfC+WuwG8xkek1xQjdrcMO7u4XP6No75EPcI8
	Xx9mueOPhiAHf2vcJlnyPgewaXQ46PVOOMF+Gk9aoDK49YWhqsB82Nh+BSeazZB/09HnZZgAt5+
	ChrX7sK6/5Qcbs0c9Ooqtj/B5a0IJ4nttGg1pv3gEvy2plckc/4af52izFy9Bd8PwIOuuZW76+Y
	Paz/Ug2jh9KfIhYnrj5jgHtcgYQOlYu8nUDMk3D8dH/hY6yU624H+D0vT75OVw6LdwE35L4Ednc
	Z+mi5TSP1nqi2kWON+Y6Zp8fQTq04wGRd+HHP1yiGlCTc+pIbznkxuJ3em5Y+YM7r0kWr6kVmr+
	M2sbalV1/cp2YIB5ndLUY2iIE5LvCNwkTHErA6ACsWJmdY132s7L5SLTHDhxsAZMr4+L/gBiHpE
	kU85hWE87M40ibyhFoVCUqjCZPDlSVe8kV79+dejzVQ8vvuTxhH8iQTF4PqbkcjWgjExffPiE0s
	FoHE7961xx84PPoT4YWjpwdTX2qxw==
X-Received: by 2002:a05:6000:310f:b0:439:b31d:c4e2 with SMTP id ffacd0b85a97d-43a04d7138emr20245408f8f.7.1773594572069;
        Sun, 15 Mar 2026 10:09:32 -0700 (PDT)
Received: from DESKTOP-TILNSD1.localdomain ([139.47.104.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe1a76e5sm34350279f8f.12.2026.03.15.10.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 10:09:31 -0700 (PDT)
From: Kit Dallege <xaum.io@gmail.com>
To: Chris Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] compiler.h: add missing kernel-doc for data_race() @expr parameter
Date: Sun, 15 Mar 2026 18:09:21 +0100
Message-ID: <20260315170921.65725-1-xaum.io@gmail.com>
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

Assisted-by: Claude:claude-opus-4-6
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

