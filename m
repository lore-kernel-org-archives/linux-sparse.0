Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3552F1FA852
	for <linux-sparse@vger.kernel.org>; Thu, 14 Nov 2024 10:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731579252; cv=none; b=rrPjVVDdtAkba0U360AFvA8K8iw2jI5Q2zBptpHoAYCOCbl/FbGxwo9DRSdkxzOBNXtjBdmNhrrvu3GqTX5fxkIQA24jMKqbr6RHN3yOFNEWtfqz/O2mFHxthx/My1dcdhgRhHc6lXQ6amWdAX8RzDYQE+AlGP8LuwI/kLK9lZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731579252; c=relaxed/simple;
	bh=dSbGdJiwEUXi9Xh8lFCFXoUamTfSFyRitw6uOIF/1bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pj4Dr9AkFv5FXGem72SGnwgTMUWaMZcFuSRvNdFqR8OyvODMJXoFJ46OWOwoMjT4PTr3saHmxXjNn7i9q2+WoE/wQKNg0fs7Anwk9QhlgNW783OU8Ho4DyZwfAlM2U4xkIZLeaSlhHF+eudYb1kKNdKGrxaPVCeaB1h9tdeS1vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=AWWj5aZ3; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="AWWj5aZ3"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so69699566b.0
        for <linux-sparse@vger.kernel.org>; Thu, 14 Nov 2024 02:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1731579247; x=1732184047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Qh66guiP2+W3P90czCrP0Yd6mEtiZrUEyp6TeAFrGw=;
        b=AWWj5aZ3XQ2FN1YnaZTl9bozWLTRQ+cpkU9vPcSQlWfaAobR/lHQxyWTfh4x9NvUUF
         YjxQWvo+P8NtLwtNLCH6N+ZiRJmRUicpnK9B+1Y/TUAvJdEkMN36HFQgYrXQ7xhBTcDs
         hXbgXUfOKmTREzPZJj62nuf7nuVyYCuZ0mGg5Cbk746zoV6H6WZIzJlmZP13GAKSzvF5
         lTqRMvk1Zjebs6lm9byxFdTYP1E4F4dW1cu+ZsrXeNOGO1mJKVUeZjLsJr/P9ehvMebh
         Luv0izz7Np8vhKvMNPBPRZm20XXCbOwmsBu9FIg7+UbTNeYXTam8nVrPcryXudnq/J/S
         Eqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731579247; x=1732184047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Qh66guiP2+W3P90czCrP0Yd6mEtiZrUEyp6TeAFrGw=;
        b=A4GgHvQ/0t7epegobZpOEEkOIWn46KlGelkhZPA1LjDsmB+ZuvTfCS37NTyvzF/on5
         /qzR32fxHFtgYexLrkm4Q2fKXDuvX9PBX3yedZ0eSXNIme3iogH3l8uJ1bXT3Q9uF7WP
         be1j31N0Bi2AzOzKbWCTzb8w1fYH9tO5HduQEGobkenzAohdrSN2if67Vdcr5MRe2vmz
         Mq8JNBQE4qyCWzmX7NOrjl3ODacVAeavJVXmM81otwlOKhnPgU10H0WwFIVmLmtyrX+h
         UMwGeNKMZbh4NTVSdIm4Yl/gri2w524ytn1acji9P6jQKYvteASs7n4n95Y807NWpe5G
         hzzg==
X-Gm-Message-State: AOJu0YzOL/TGmGyUqG8RZ85eiP6qXdQV+Y7XiTa9g8Nn9LuFfpuY6Yha
	6NhfBcInxB+upSCSm0x4x9+3vGkoAf+TN04dDOCFrCQO373aD8P07NvtzbkLQQY=
X-Google-Smtp-Source: AGHT+IGZ/bENGR3clUJzDy0XRQAhCZWJWR4K6HaxgiagGJjeiHFnxDuWeBfoKGVW3yIbUgd6POVG7w==
X-Received: by 2002:a17:906:4944:b0:aa2:c98:a078 with SMTP id a640c23a62f3a-aa20c98a0e9mr122886566b.57.1731579247440;
        Thu, 14 Nov 2024 02:14:07 -0800 (PST)
Received: from ryzen9.home (193-154-230-113.hdsl.highway.telekom.at. [193.154.230.113])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df26c84sm46139066b.35.2024.11.14.02.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 02:14:05 -0800 (PST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] compiler.h: Add missing include statement for build_bug.h
Date: Thu, 14 Nov 2024 11:14:02 +0100
Message-ID: <20241114101402.156397-2-philipp.reisner@linbit.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114101402.156397-1-philipp.reisner@linbit.com>
References: <20241114101402.156397-1-philipp.reisner@linbit.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

compiler.h defines __must_be_array() and __must_be_cstr() and both
expand to BUILD_BUG_ON_ZERO(). build_bug.h defines BUILD_BUG_ON_ZERO().
So far compiler.h lacks to include build_bug.h.

Fix compiler.h by including build_bug.h. With that compiler.h and
build_bug.h depend on each other.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
---
 include/linux/compiler.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 4d4e23b6e3e7..2d75e4892316 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -3,6 +3,7 @@
 #define __LINUX_COMPILER_H
 
 #include <linux/compiler_types.h>
+#include <linux/build_bug.h>    /* for BUILD_BUG_ON_ZERO() */
 
 #ifndef __ASSEMBLY__
 
-- 
2.47.0

