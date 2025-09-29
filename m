Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824A52F879
	for <linux-sparse@vger.kernel.org>; Mon, 29 Sep 2025 00:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759107455; cv=none; b=PyYHq7ctklFtHXKBA4i3e5C8uP5r+ZY1TFrJ12wkwneykcr0LUTL9++ftmwPywbbqz0yUI7MEhE2YFltfB3ImiKX2jt33HLo1Rbt/BjEKpRQAoVqc2t7h9Niwtp8ZHtRjR2NMh/S1yJO5CjNNCMRVq9cn+gdzfcozhEha54LNTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759107455; c=relaxed/simple;
	bh=/65gQOy0CJmaPmaU8JLyRaEMVMBS3PWpkz64O2OKDyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bK5l/KhC4FbRIb9dOYjQVrxwRQ/fmUcmAWljIBb94+XFOzoOpmahzUwG2q/UV7axv24eFpeF/b6iP2bbM3RG7AcD4eActQ1oEjOFbEPv2c5IdL9eW7/LYBp4LxnOjapjMksIhtNdy8k922gylNEfATcT5ueXrQnwuf9SJrhczM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPlex5fq; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPlex5fq"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3381f041d7fso964648a91.0
        for <linux-sparse@vger.kernel.org>; Sun, 28 Sep 2025 17:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759107451; x=1759712251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0pmc2Lc82M3eFhlN4GJeI08sWXBtOBhSoENeY7vxLZ8=;
        b=cPlex5fqahDa7H9orwAr+yQFsattwk+RnfDp+P/7uAJsE55rvk9gUYD5nPLAS28eTr
         43FfHNqr9Zpe1L5BP/wDddtyB0eWNJ3WZnJnSStkno42UkuV5N+8ILO0vDzH/Wj2829T
         0PYCXQ/LqmIgZ7eLXWBmFrWq2hAeowJ2OTaAV7zvqfFpSwNe3a7js814F2NZYPIyScoi
         JVGYjxNH2I+uUj3ApdqqyqQ4OebvPbiMPkiHLj/XrScIbmHnhpYZN/30JLQAG9tTpqIt
         C7suYDA68hlFp9xRkt3OEVN3nCx7aYgkk0b/em6KMfBv78c1wL0cgVPg6gOopXgArX7F
         veXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759107451; x=1759712251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0pmc2Lc82M3eFhlN4GJeI08sWXBtOBhSoENeY7vxLZ8=;
        b=Eg3ON5IL6CyUdkKkTJCTHyvPAecGGKG0+x34YutWiAC67IrLKvADsYgLncOQZaNH9S
         461Yapht736lbi31k8EIrbQoJdno2e/YYxsCafcNOcje7QlS0I0OPRw1krmYk6diyAV3
         j4vxb958yMTYYFYsSFYcUaXE7X8W0nOnIGqKfM57eu/H9tLl3q63OoBL/jsiNBGTMY39
         aMxYk8G1K6N5fOrNlyfvc459mwGTmP2HF4MEB1DMUnvi9valVCHou2YO/Y3yydU7xl4z
         Zb74xjAjYJRPrZ6I8A3d15Yt1BdFzQqWmQOfUmypZCko0gvDOn12Mx3kHP98eU0DqFVH
         oKjA==
X-Gm-Message-State: AOJu0YweeI85r9bLZYXUHUhTw/kp2M9qqWxGa7QDvJPnBiPx4ssN0JCF
	ftnZxq5aPlovLzjTZh6URK1OLFlxS1fdwHLJ7GiMJ7mQxxTaOFajzzC/RlaldkdEYMo=
X-Gm-Gg: ASbGncslUD5W2qgKVSlL6FiAXEEnJaqsUsAx11yjgqN8uVFc6O1C/voJv9BhLWjQSC7
	9z1yMwnSVUWXaSEI9H34RzYGLSkkb5o2mQ6yepj6SRnE9xyZjSoiEd7Rbvk9cvZnTjxkZ6e+Vg0
	Li1Bg3OMix694A6IRI0KfnNLphH5b4k1M3TBWiCmH6D7SZbCv/gdx3SMp/QuwlwmmWUQhLC6WgI
	tHDedZRCKQKTMa92I7fV6H48m68/3vZ1OSAKWfvmy0NIydL1Lnqk+4mQkN5PpM/LukNhjXNdxOZ
	Mhg7NMvDBEux7eY+d8ywaKwiymlV0Vd6x2YP/7Hm4KUw5Lwtc7yBmkFBdceSoAnjY2dCK4CI/O7
	4DGSIEgcZk7zFMgoSZTlu0dEcTqMv7IBguIU1bfhioQdEzxDBzywDYqI4pUwNVElP8XmonBPzur
	9pyIQoTpNn357CEdXBqgDzVbtOrjA=
X-Google-Smtp-Source: AGHT+IFRtV49rO8Tgwd4l8PJGrBX1gu0aSLA+yt6xTUy1PhpfjUFCni0tzwZeTI6QjX59bgszXbjDA==
X-Received: by 2002:a17:90b:4ac2:b0:32d:e027:9b26 with SMTP id 98e67ed59e1d1-334564bcf13mr14148778a91.13.1759107450974;
        Sun, 28 Sep 2025 17:57:30 -0700 (PDT)
Received: from localhost.localdomain (c-24-130-67-127.hsd1.ca.comcast.net. [24.130.67.127])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b23634sm9684268b3a.66.2025.09.28.17.57.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 28 Sep 2025 17:57:30 -0700 (PDT)
From: Changyuan Lyu <changyuan.lv@gmail.com>
To: sparse@chrisli.org
Cc: linux-sparse@vger.kernel.org,
	Changyuan Lyu <changyuan.lv@gmail.com>
Subject: [PATCH] doc: update the instructions for mailing list subscription
Date: Sun, 28 Sep 2025 17:57:27 -0700
Message-ID: <20250929005727.18121-1-changyuan.lv@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Majordomo commands are deprecated as per
https://subspace.kernel.org/vger.kernel.org.html#what-happened-to-majordomo.

Signed-off-by: Changyuan Lyu <changyuan.lv@gmail.com>
---
 Documentation/index.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index e29a5643..4c810787 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -56,8 +56,8 @@ You do not have to be subscribed to the list to send a message there.
 Previous discussions and bug reports are available on the list
 archives at https://marc.info/?l=linux-sparse.
 
-To subscribe to the list, send an email with
-``subscribe linux-sparse`` in the body to ``majordomo@vger.kernel.org``.
+To subscribe to the list, send an email to ``linux-sparse+subscribe@vger.kernel.org``,
+check `Subspace <https://subspace.kernel.org/subscribing.html>`_ for details.
 
 Bugs can also be reported and tracked via the `Linux kernel's bugzilla for sparse
 <https://bugzilla.kernel.org/enter_bug.cgi?component=Sparse&product=Tools>`_.
-- 
2.50.1 (Apple Git-155)

