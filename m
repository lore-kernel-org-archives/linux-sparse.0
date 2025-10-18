Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB6C227563
	for <linux-sparse@vger.kernel.org>; Sat, 18 Oct 2025 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760780122; cv=none; b=ViOcM+fKB7DywUIy40yFFqh1FTm46yj21dbPEEGdfYhg17TEKGRab31Q5mIpGHNUA6Tgm45GmmkW5/lEg6vAymeQntprUVq8H24FJ1zo1ucg7/Otg2rpbVVW5Ls0CPOOGgwRX2wowmoNZI6unKnygHRaJkI/X2/BeOF62hF/bqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760780122; c=relaxed/simple;
	bh=znvtahQqXgq3MTKhE5NgcFNfAJpY4NVppHeUrKUCbWg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GDi3sHOMmOvTD+dWgdfqyGq6sLsJWNqZmXYJZQjom1gsXms/PEspXczqemXKNLBdFpodNjAOvK9inYD7yDdpn8mEiu8cAG8NKH/j01KkNOusyFQ4SC+3YZdDiXiyWuW1ks/M0o/e0mc8RWr9Kf56eg0+js5iM+wvACiglbUdg0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eNCmbXfc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eNCmbXfc"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47117f92e32so14196475e9.1
        for <linux-sparse@vger.kernel.org>; Sat, 18 Oct 2025 02:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760780118; x=1761384918; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pV4u5UAYrzW+M8wBbriTJAOKzAb394DmWPRSYoZdVSg=;
        b=eNCmbXfcc4VbRLvlnAmW0NFXqZKu8JlPVCkKwGexOMd2NCHl5R78aEbi9cq3P2M/RI
         31K8oFXhbZpHhT1tsNoe3SqxBiZugZCUlhHHYsCBUXEfJGQqodhKamS7l7I7Rhqs+BIq
         98ttbhknWh77mEKUu9wAkMXadLdSk8+11ltWreSUZWy429JcocBMkryuhuNzQEpP/JRb
         ihC+fY5LxVX3yuznAR6cnVVG2idP8R1LUHWlJW/W/XfPaunMUDJlfuw6C8JboRr4zJIV
         tb+Lu/8F6OGXACBQgjhYNKWBig3Nm3/06VSR2+TtXcUn5nF92+14wkkmmapGVcmIgQA8
         Z0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760780118; x=1761384918;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pV4u5UAYrzW+M8wBbriTJAOKzAb394DmWPRSYoZdVSg=;
        b=mYkvdrkMyux0Zl7IOM2ogmvMKXCaO/GVPyTkmxlfqfvrUrGcnbJTkWy1KuUpb5TiP3
         F3JW/JgJq8+Sgub7EXfEc18Nl/todjV8+6i4O65iuq4BiWMuVG1RMU3k3xeGnoydn6l0
         f85HkhPO3fiN2dSivTgZkidNvM18To9C6xbVLFEVX27r5F5PZThjIqRTLNrQbfVkTVPK
         QHk4ge7HeofFL6KZKimFhE6QlycL37AR+D2QiiKCHOYMfniiRLhMJK7d3VRumF4b6qBh
         e/7f8UPkXFEriiMopbsN8kWVn9/qPbZfNLO+PLZRkO7dFlm55ZJ7VARoYbC8hrYHIPyx
         G2oA==
X-Gm-Message-State: AOJu0Ywt7gI1GiIv6B9cWubnVy9mk8r+lEBTDMxodvpK+NVfdvARylEz
	ivNBSdmb+5L39rafeNCcL1iMMubmE0DUEyQeCrlfqGgfpgFNGmcB4xXqjZmzSSgKBnQfHGWnOZi
	hadww
X-Gm-Gg: ASbGncuAVipgo2RzARcDrp2IrhCvdipT1EYw24CtHAKOlcAsXQhoSN03zcXfSfcrJYS
	uIdw/egZpeqaNlrpittmMYhTtRd67gTe8qoekzoJcX3a1o+vd3ZKc4jdecs/Qht+z9VCgwxYJ4b
	MXmUUYMEpePVBdOR1uB3H+GV/GrHXx0e/KDHSQMeAKdYkUmm/lTcm3iboBVfHag+1Fa+JyVX9JN
	NtHlvsmQ8CL3dBrF1slb0xCQh6kzqL77QaFCfH3YP5IKl++ioM6/Urdbvtf7D8HxF3WT9Cwz8ae
	igukhBdWjmlnJB5F8bf69TH4LnL3fAcVjvO9tFWsvUZwxL2IE0DdAa3nMZmZKRPoNNIyjHeU7S/
	10nv6aKerhStisy7X0p2OUq7xHIsP6B/sQC59HPR6iW8KbmdkB80YfmgeRYY0cJT5r6Xdwtn3WC
	bhF55WcQ==
X-Google-Smtp-Source: AGHT+IF60t/mm8zQjTMWh3sV0Z5Lyd0HPN6n3Q3/JEyUvog0C14Pjczi3w58F92xTYPE0a4QZdjLIA==
X-Received: by 2002:a05:600c:870b:b0:46e:3709:d88a with SMTP id 5b1f17b1804b1-4711791cb7amr55023245e9.33.1760780117845;
        Sat, 18 Oct 2025 02:35:17 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427f00b985esm4097116f8f.34.2025.10.18.02.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 02:35:17 -0700 (PDT)
Date: Sat, 18 Oct 2025 12:35:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: [PATCH] symbol: preserve address space qualifiers with typeof()
Message-ID: <aPNfUShPJ3zaAeYp@stanley.mountain>
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
 symbol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/symbol.c b/symbol.c
index 6a39e5487c17..301a6ed225d2 100644
--- a/symbol.c
+++ b/symbol.c
@@ -552,6 +552,7 @@ static struct symbol *examine_pointer_type(struct symbol *sym)
 static struct symbol *examine_typeof_helper(struct symbol *sym, bool qual)
 {
 	struct symbol *base = evaluate_expression(sym->initializer);
+	struct ident *as = base->ctype.as;
 	unsigned long mod = 0;
 
 	if (!base)
@@ -567,6 +568,8 @@ static struct symbol *examine_typeof_helper(struct symbol *sym, bool qual)
 	sym->type = SYM_NODE;
 	sym->ctype.modifiers = mod;
 	sym->ctype.base_type = base;
+	if (qual)
+		sym->ctype.as = as;
 	return examine_node_type(sym);
 }
 
-- 
2.51.0

