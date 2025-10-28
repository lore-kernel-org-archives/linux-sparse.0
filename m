Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678F61F4C8E
	for <linux-sparse@vger.kernel.org>; Tue, 28 Oct 2025 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761656767; cv=none; b=c9mMaKCZz9OySkRuPWegiyPSZSlmOUsLtqKP7dYkHSk8PtQV39nkzqO+vzjDUWjnPsITMyrroQLNDZN8+nhgcKYqv0oOw9jxCIZu4LTSi+g4qEfAy6ek/i2wg1uGTU16WeY273TNp+q16id3aXcGniv67BCUOZGRXpmXAgjIX+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761656767; c=relaxed/simple;
	bh=pIYe+DRRSe9p3Rc2Xnth6sCFfDDjHkwbG2H0cnXAvaU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=axq1KXN6dnDvKUTxW7k4peQU/Ocs94CnFS8lJB2bZlNc4xcH3S4YezeZPdF1wE+rJAokDwS0IlOZmMAn4/z7A63GrSrOO6Iamc0+ls/76qpB/253hAT7Zlb44V+qM3GUSIwPV+e6karieWYd+lZOVO0kVxKIN33V0xwS0ucjw4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YPfJPyUx; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YPfJPyUx"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so4132576f8f.0
        for <linux-sparse@vger.kernel.org>; Tue, 28 Oct 2025 06:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761656763; x=1762261563; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/PcpfQ+wYChhPhMa5A96WtVYws88AgVqFTGAAhbmkNM=;
        b=YPfJPyUxiXVvpfN/plObFsCxu8Xolwp9vDCL74w0PXvitcTD/XtqX4vO5ZFdcGYP34
         zQF0ulzCZUqQP5gz2+G3dyLSWYbvv2SVldjuSzmcER5tLr0WXFMn+PYMqNjeBqWtpp5e
         O2p+pOu/MQr3CNYer7FeDcqexuu7Y8ZozUOPe6I1B0mIxPAcXGcN3WKL21bhKzGFODw/
         rBCaysvRBLEoi6XsiDSibsPISk+Dx4WmRpMut0zCo8nRtSkYQirOCdH5E6BZvsrNQdww
         2m70Q7G49sE5++wKxBR1v319GOp0DH7MfraVke6K8/UpcdCmKLbFfe2X+vf6p0A39YLY
         rvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761656763; x=1762261563;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/PcpfQ+wYChhPhMa5A96WtVYws88AgVqFTGAAhbmkNM=;
        b=DldeK4XNbGEfD1EtpWafCi8sRbAsGZ/c7paPCKv/V4rcuti4NXZmqO84ZqZtH4KBg3
         +RgmoET0/m+vmCT0EdjE/AKc6cQzG7lFdOKVPfU5ykY9SqbSkNIYGN788JdCntj9LLbp
         5f1jNYPxv7LmI1c0j54fRy0yrt9bNmOwNnDZ2t6cpsDHlyAfbeU8SkFSlh7t556Yq4Dh
         UJtV85dEjTIK8q9NmooqxTVrjdf+zDABNXrSS6AgWyI4dgeHwo3e/YMWhD9rHdzkkNWV
         mt2DUDduXlvAVW+dDEqlUcXe5r6pcfU+2oloWPj1fZ3Xqy57C11W+hHv7tqyrWDPZJJL
         E4LA==
X-Gm-Message-State: AOJu0YyHXRLrNb8hbiR1/jczWmPos7nNso69D0XVghZQEWHRV/VRCGxc
	iDyiz6oTnscLUZdzh6Yuzf1JS5xDbCFbcvQL8E4C9ZTcJVv42RKZXjuchfcDP34l5GU=
X-Gm-Gg: ASbGncvxGjacIcQcYBXg6f1S2WoZqDHpGy9dgopT6WeA+taWaiKcAReHkpUGN3jdr1S
	zEz7Z2m89d9IzDXNUVxRdaGk6nynYNES8WVvJKG8+OJ74r2t8L5yRDj1hQmGzovFisZbSeIOtMc
	++W4sT2OlRxUWJZafIfBqhZbFCrX9SVpIkuKlun5RYnau8AzWYbPWUycGFM/Y+8Daj/Wc9IhQ2r
	JfnECsPTOx9hC0QHT7cEY7urMJjEeVtlOaF18JhjXgB2yBnDN2lkECYrtQbzL9IiahMh/Dw4mWj
	j/feMMvdtCIcit8CVQhaZJrams25FFFnVc31QaTO0bua0eFU6LIpWcnkSfR5aTI1YOuEWi1xWXM
	V1qqkbt501GE7bkVBCczYpMT34uau4c0QYWAmi3UsIfMpZRz3ub6lqgvGVo2RGSWZBabBcgZ7Yd
	XVqYve41zWOjJChr/Z
X-Google-Smtp-Source: AGHT+IFKgfLRbyuCQgcxt9mw/J60JsjKf8Fc9oHaIa6hk49SRfVpCJ1F2C+KMMCJHOzCvgIf2fXexw==
X-Received: by 2002:a05:6000:220b:b0:3ff:d5c5:6b01 with SMTP id ffacd0b85a97d-429a7e59e35mr2874598f8f.19.1761656763212;
        Tue, 28 Oct 2025 06:06:03 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429952d514asm20381502f8f.23.2025.10.28.06.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 06:06:02 -0700 (PDT)
Date: Tue, 28 Oct 2025 16:05:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Uros Bizjak <ubizjak@gmail.com>, Chris Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: [PATCH v2] symbol: preserve address space qualifiers with typeof()
Message-ID: <aQC_tw-8gLpf00yH@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

When we're parsing typeof(var) we then preserve the address space
qualifiers as well.  Otherwise it leads to warnings like this:

"warning: cast removes address space '__seg_gs' of expression"

Reported-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: Fix a NULL dereference because "base" can be NULL.  Sorry for not
running the validation/ tests...  :(

 symbol.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/symbol.c b/symbol.c
index 7060acb666d9..a42289226650 100644
--- a/symbol.c
+++ b/symbol.c
@@ -544,9 +544,12 @@ static struct symbol *examine_pointer_type(struct symbol *sym)
 static struct symbol *examine_typeof_helper(struct symbol *sym, bool qual)
 {
 	struct symbol *base = evaluate_expression(sym->initializer);
+	struct ident *as = NULL;
 	unsigned long mod = 0;
 
-	if (!base)
+	if (base)
+		as = base->ctype.as;
+	else
 		base = &bad_ctype;
 	if (base->type == SYM_NODE) {
 		mod |= base->ctype.modifiers & MOD_TYPEOF;
@@ -559,6 +562,8 @@ static struct symbol *examine_typeof_helper(struct symbol *sym, bool qual)
 	sym->type = SYM_NODE;
 	sym->ctype.modifiers = mod;
 	sym->ctype.base_type = base;
+	if (qual)
+		sym->ctype.as = as;
 	return examine_node_type(sym);
 }
 
-- 
2.51.0

