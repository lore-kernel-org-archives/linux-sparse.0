Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49683486433
	for <linux-sparse@vger.kernel.org>; Fri, 11 Sep 2026 22:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164895; cv=none; b=CnX5LeLllCE518jmnHDUv1B88Jb4Ese32rClj6oj6sD1vq8OfjbtuSolt7jZ8jSqlhB2+90cI8CCxrPxr0xThmea+kKrnyxON3dLc/rJchKYMBrc/bU/RRqHoRPuxXx84sevBeq+/Mh6wLtPXB4pGYMUw6HeVGsyczuln0y7544=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164895; c=relaxed/simple;
	bh=nqm+qgcrDbRH0g5TEzWGEqU1WZ6bbOniRLl1yX0/X+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3kEEqltGY/DCaFjdn9zb8QTVRP0BInkpHRRfKUeEmVwO4Be1t99oChq62a1FsdgrqE6cuaI8GpmvEUdM2t6cXPjK2NeUlnDKIxkL85v+QfOR4ag/Aoa4ok2MiTmkwaohAk08ynjck7OEgHhVfWaqRhDq1LresoddjBL9s2iS40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdgDJty3; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdgDJty3"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb752so310813a91.0
        for <linux-sparse@vger.kernel.org>; Fri, 11 Sep 2026 15:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789164890; x=1789769690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r2k+37bKOMj5uflztInqcHyMEmLHoz6JlZjzrLWxQac=;
        b=DdgDJty3eQhtWdUClp4cLd00Buf85QwNLXU3OHgNikurRiw2L5KM2f9WTlDwFxwU6G
         Me6ZUADl7lQfen3ltBad+mwrkDqALCHzYO91pwcfamIHeGDPy6HOf5YsaMvPvDJrb4qH
         eGAR5dqY7mFWyOQGj6HEaWa8se7Ctg8WpzN+ZA5CEPQcILhC30jrfmIAQXBK01ch/mzk
         /0ctkzIhf40ohV0ZD9hQ+cq70Q0oW882uemZ/hKCbpFCruIw3Wzozxz9QsmHw2N4yvWq
         rMeM3bhl8yVvYKSyKfZyfDbiW+5T6QfPsGDzhAEsw8aOqBE/IuFCiDTinjofMt+NC0gQ
         2J+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789164890; x=1789769690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r2k+37bKOMj5uflztInqcHyMEmLHoz6JlZjzrLWxQac=;
        b=YaWNf+WeHxexrYUOLvo5fvyqYVFEjJGmpEmImh1t12ZOObS3F04V7Tvv43yWrFikDU
         lgshHJCZv4iEQ2pEDQtH42FltABARR8PEsBB7gWxsxBpJyuZpggam8643iCPg427sxzS
         ctF8IOoztdIW8OjB2N0fToj79LDms80pgpv6OSqRJk4D8nGbmYzHO76eRdBxiAP5C3UK
         3uhds5WxOVNEhjczYZnQCTFgv1hW9JxbUVtyDXi4rsqAycCJOm49JuNKbfv3m24ohPkO
         6EasWa9mXKiVgG+YFTswhsIJhS2c62bC9SY/zQaqoeJG7pHJM9YX+AekHChbuFD46oxW
         kIIw==
X-Forwarded-Encrypted: i=1; AKwUvBxxdvj8nJOJrtTNVow5QJ2BLncOl3eEvKi9uRVY2CWOKW9siK1QCvQFNItj5CmdudtqSsvrThuXIls+kN0=@vger.kernel.org
X-Gm-Message-State: AFuF++mBmNhnSyxWsK/VmxPfy9skv4ZwACr7L6KdtzDDzygGFp4bM8Ay
	jCLwraIDdxQBqffDXo68Pv9a37ipKNSPNau3kNhjfF4E5xj3KAA5E8oV
X-Gm-Gg: AYBFou10WUeYVjtrAoyewJD8oChFZPVkeUzFcSmaW0WckB9Wz9xUrLH4gshQ5i6tOOA
	W2ZZyhCGfyeojv5CAReypumwU7d/jnBv6n5ApHVPSuRG+boFudz8VYQsn84o21379O3Q50G2m89
	YUwnGb/A/2oAeIpJxfga1ZFZAL9BUxM52PlGFLXSzo8xLbwjbxbEPNCM3WMjtkRTu0QY8iaVhoU
	V70Y1NCudEZcrL1QJ1p7fO6ziByu/DiOYA8lZF8deqjy3nI1No50zGvpYYx6L0OTr3nqy++8tPk
	UpaFtNWmG6Lx9qUFVXBnSK7ODzWk3HubowxxUie5QCOawNjDWNNFhCuslZzjnoDmjLh8VTCmfmx
	x+vmQAPDwytEUpVuR6MaaOsmY3CPwQVVqOCZIsiRPFj7hampL1zxL4f5cNVhaO3pymgFbg/Xk89
	bowD0VLQU/Sa2dd1e1xMMjIPEW/nC1ZG3DatTxjPycwb+5Dyby5Z8+epzr+UlaENbM288=
X-Received: by 2002:a17:90b:3c03:b0:398:de23:9af6 with SMTP id 98e67ed59e1d1-39d9c1db154mr11222277a91.15.1789164889827;
        Fri, 11 Sep 2026 15:14:49 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b8137fsm9073522c88.9.2026.09.11.15.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:14:49 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R. Howlett" <liam@infradead.org>
Cc: Yury Norov <ynorov@nvidia.com>,
	Chris Li <sparse@chrisli.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrew Ballance <andrewjballance@gmail.com>,
	Yury Norov <yury.norov@gmail.com>,
	linux-sparse@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	maple-tree@lists.infradead.org
Subject: [PATCH 1/3] compiler.h: add ASSERT_STATIC_STORAGE()
Date: Fri, 11 Sep 2026 18:14:41 -0400
Message-ID: <20260911221444.1523311-2-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911221444.1523311-1-ynorov@nvidia.com>
References: <20260911221444.1523311-1-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Static lock initializers rely on a persistent object address when lockdep
assigns a lock-class key. Using such an initializer for an automatic local
object can compile successfully but disable lockdep on the first lock
acquisition.

Add ASSERT_STATIC_STORAGE() for declaration macros that require
static storage duration. It declares an unused static pointer initialized
with the object's address. An automatic local object's address is not a
valid static initializer, so the compiler rejects it.

Mirror the helper in tools/include/linux/compiler.h because the userspace
radix-tree tests include the kernel IDA and Maple Tree headers with the
tools compiler definitions.

For example:

  void example(void)
  {
          int object;
          ASSERT_STATIC_STORAGE(object);
  }

GCC reports:

  error: initializer element is not constant
    name##_storage_check = &(name)
                           ^
  note: in expansion of macro 'ASSERT_STATIC_STORAGE'
    ASSERT_STATIC_STORAGE(object);

File-scope objects and static local objects remain valid. The helper takes
an object identifier and must be used as a declaration after that object
has been declared.

Link: https://lore.kernel.org/all/20260911155244.1406122-1-ynorov@nvidia.com/
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/linux/compiler.h       | 5 +++++
 tools/include/linux/compiler.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index cb2f6050bdf7..ef9036fa5413 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -275,6 +275,11 @@ static inline void *offset_to_ptr(const int *off)
 #define __ADDRESSABLE(sym) \
 	___ADDRESSABLE(sym, __section(".discard.addressable"))
 
+/* Enforce static storage duration. */
+#define ASSERT_STATIC_STORAGE(name) \
+	static typeof(name) * const __always_unused \
+		name##_storage_check = &(name)
+
 /*
  * This returns a constant expression while determining if an argument is
  * a constant expression, most importantly without evaluating the argument.
diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index f2f54b038168..03ecf9086643 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -73,6 +73,11 @@
 # define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
 #endif
 
+/* Enforce static storage duration. */
+#define ASSERT_STATIC_STORAGE(name) \
+	static typeof(name) * const __always_unused \
+		name##_storage_check = &(name)
+
 /*
  * This returns a constant expression while determining if an argument is
  * a constant expression, most importantly without evaluating the argument.
-- 
2.53.0

