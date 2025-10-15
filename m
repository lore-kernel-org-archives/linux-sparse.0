Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D647A32A3D9
	for <linux-sparse@vger.kernel.org>; Wed, 15 Oct 2025 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760533707; cv=none; b=g6U8KbEhR7fGYUU+Z7CM23Y6w/1AbGw2VeUABrRampWYcbfG2yPgc9EKewBBUWjO/rWTHg9Y5+OSqx+/mmGj/lJtn+3XLSTaBFKihgI3eUMvfRvkSCgrmgJWQy+pzXViZ3/whD6e/tiC5Q0sLhEq95q9lP0o/710bSuI4Pkp/f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760533707; c=relaxed/simple;
	bh=uJZCcSO4ZzIFTetml8qQBG5qetwn1iUwyc+ULXXLg4g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IUhURAiSQZL2Jc5AmOz/gfku51uH9LIPhvSMLCa6UxHNkVmacWki3GqGIWyfOKKvTrVsSdCl7U33JoV+PoMSwEZPISC5Ia7VfHGMOyEXMpWTJxqyHvB5bsvyj62hRRPk+hYzGdaCTPaWQHQ5nA3LXParx5pwcCDY1cBhRUo11J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ksdC20rh; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ksdC20rh"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4257aafab98so5457411f8f.3
        for <linux-sparse@vger.kernel.org>; Wed, 15 Oct 2025 06:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760533704; x=1761138504; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3XFi3xy/0iOfTR/VXPqCk1gz0693H4eWmw+YtRPk9qE=;
        b=ksdC20rhN/C97CvHh8y8o4eNisWpwxfHlZnLhhictv42aM8KZsFszOyoSgLzioFO13
         1YTkhmLJmWZy2AgPZ/DHyJ57iH1nVhrmhtMRtwTarZaCUYHhP3xihXM01vY97AKznZCd
         2GS5KqO6Yst3uHM1Xm9hIg0waVMVCycOg523YaXnaY0G3PfcoCoJtU97GTSpDNcCluYW
         B0UekkxKhR5856Z+yGLXMvraIuljlRq7YEeGocSop7jjs7+9l0S5jtX/L3kROkG7Jn9Z
         j3PJg08LM9OTU/xBGVtc9pezNyoUxDsSyXY6iYY9FcNFCr38uEUYZAeexL1w79XjE01d
         T1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760533704; x=1761138504;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3XFi3xy/0iOfTR/VXPqCk1gz0693H4eWmw+YtRPk9qE=;
        b=HQVnR1btwRYHWN3fTF+W49Yqqe2I9jILTx846I6cEv67PK5syNrtL7BuVlxoV8T0DG
         qqu8g3UU4m/oB3Itx8C+5VzLc8iBid/aiFSLmAG9O5NTntTlkDnYAr5xR49cbdYhnAA1
         R+z2WPluK39bUeISNAd2F3+jQGtY8m3cDuTEdWClAFS6GfKzUdi3gRRduWHWoGcbd0aK
         cS21JBZ1A4ITb/IG1M+B36bxbq5vlmF97bFZchAR08Ha48j5VvuDSfYEYJVbR53zUouU
         c4Oy4tGD74AFQFyyWXgZAPrLM3bC3U611qKxwxTgZfwZCI9FR06vo3ve3edJw77RUBMd
         Vj4g==
X-Gm-Message-State: AOJu0Ywcvf5QltDMDwGFGbniAizFNHvy/4RK7J7TWw3lF3NgnKujIzGS
	roWtKsRkaKbSsHL47DuUaBehSJPbpLTnEgorXUsYU57qRNiEeF745eF03sEARUZ4IZxS9mADm48
	x79GK
X-Gm-Gg: ASbGncsxy1iWimI4o94jFCfvRO+6Xo86nI6LYkyoSZyuRdKnxpINlPrRc2dmyb7k9S7
	ahZGpUiCMossqd11dhYZ66mBR7/EN2KpYjdlVGO3gWxsU0RFl9w5lQKCOq4L8GNe2/8r5mz6oYn
	YaPRsJ63T6I3X5Gc0HQaq6SeilRlXtlrRMsvL+1eagnUG0ihl8rhCM402G/X7H164Kv6uW0d8Ne
	oMR3HRISfz86et6n8sQ45faO5ySSBf/x++2o+FaBEaz6bp1m55HQS0aFsK8/OI34BfMjxxowHRP
	ZPwXeit4E9WSBnPbAqntvFGlRmqcRlK15rUBQRbH1hvaMLT5qDEyemHDfUDIUfq2lir1TPV9Hrl
	gjJOTW5aIAtRIekvqsKX/vhwKJk7tpOI5Z3bV50ZkhvBOsNCv1zrsX6ab31vyYg==
X-Google-Smtp-Source: AGHT+IGzGDs128iRILNF7tjFOkKXU2kAw43z5Qu4RGqw2jof5rsqx+R5C8XPjobp3RGKj17HHMY9kw==
X-Received: by 2002:a05:6000:1445:b0:3f1:ee44:8c00 with SMTP id ffacd0b85a97d-42666ab9597mr19380548f8f.10.1760533697069;
        Wed, 15 Oct 2025 06:08:17 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-426ce589a21sm29787321f8f.23.2025.10.15.06.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 06:08:16 -0700 (PDT)
Date: Wed, 15 Oct 2025 16:08:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: linux-sparse@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>, Kees Cook <kees@kernel.org>,
	linux-media@vger.kernel.org
Subject: [PATCH] builtin: implement __builtin_strlen() for constants
Message-ID: <aO-cvXncl7dbnP_J@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

People are adding compile time asserts to check whether strings are
the expected length.  In GCC and Clang strlen("foo") is expanded at
compile time so this works, but in Sparse it triggers a "bad constant
expression" warning.  Implement expand_strlen() to handle string
literals.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/all/CANiDSCsBAq3Yx4ybarUb_1NkQ-bvfXvWqb-DfqXatkiYJFZWiQ@mail.gmail.com/
---
 builtin.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/builtin.c b/builtin.c
index 3a29c3aec8a6..9e8fa5964b37 100644
--- a/builtin.c
+++ b/builtin.c
@@ -596,6 +596,28 @@ static struct symbol_op object_size_op = {
 	.expand = expand_object_size,
 };
 
+static int expand_strlen(struct expression *expr, int cost)
+{
+	struct expression *arg = first_expression(expr->args);
+
+	if (!arg)
+		return UNSAFE;
+	if (arg->type == EXPR_SYMBOL)
+		arg = arg->symbol->initializer;
+	if (!arg || arg->type != EXPR_STRING || !arg->string->length)
+		return UNSAFE;
+
+	expr->flags |= CEF_SET_ICE;
+	expr->type = EXPR_VALUE;
+	expr->value = arg->string->length - 1;
+	expr->taint = 0;
+	return 0;
+}
+
+static struct symbol_op strlen_op = {
+	.expand = expand_strlen,
+};
+
 /*
  * Builtin functions
  */
@@ -775,7 +797,7 @@ static const struct builtin_fn builtins_common[] = {
 	{ "__builtin_strcpy", &string_ctype, 0, { &string_ctype, &const_string_ctype }},
 	{ "__builtin_strcspn", size_t_ctype, 0, { &const_string_ctype, &const_string_ctype }},
 	{ "__builtin_strdup", &string_ctype, 0, { &const_string_ctype }},
-	{ "__builtin_strlen", size_t_ctype, 0, { &const_string_ctype }},
+	{ "__builtin_strlen", size_t_ctype, 0, { &const_string_ctype }, .op = &strlen_op},
 	{ "__builtin_strncasecmp", &int_ctype, 0, { &const_string_ctype, &const_string_ctype, size_t_ctype }},
 	{ "__builtin_strncat", &string_ctype, 0, { &string_ctype, &const_string_ctype, size_t_ctype }},
 	{ "__builtin_strncmp", &int_ctype, 0, { &const_string_ctype, &const_string_ctype, size_t_ctype }},
-- 
2.51.0

