Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B513F36EAA0
	for <linux-sparse@vger.kernel.org>; Tue, 24 Feb 2026 11:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771931252; cv=none; b=CNXO5q6OZI/DIuzW1rRjLpbmaHVJQDPkbTzTgQdCUUXqkgltKMdopVmpm0u1SMwYuidQXw+FEc7vGYqkdEY4tOcRsRgm+KI12MjN0jOJGBsjC0G7NrrJlWSGGZM//NTNHB2Xd1LTS4Sm2f9GgKbLsHUOBuCsQ8vwwz6WV3VSIkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771931252; c=relaxed/simple;
	bh=LBWJU4e2QZ+W6h6QOctKxqByUTS1FwQePgcfhSd2/WY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6wtTiTfC6M3UHJ/XfPUWbxNT35s497nS9Rqe5BWBVsvKQ0oH7nnu/W72qFVIMR68Mq+4IycccRQdiEOzOZwgDF8wzXf+WlmfsFEJbrRlWo2G/vmrsLnT1FKe887IPtpKGsyCvTu3FlzetJUl+TQhMVT7F08b2QizYG6GqAabbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QawdaXrr; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QawdaXrr"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43945763558so3320333f8f.3
        for <linux-sparse@vger.kernel.org>; Tue, 24 Feb 2026 03:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771931249; x=1772536049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/5ncd4TcdGK7Sah+X7/4jiaz6VRPHla2S8kBCrAzNWY=;
        b=QawdaXrr3vC+XBnI2xTaZDBwEGio3WnfFCuaEGafyBsZM58hE9a7HsgF9Mzymb5F7I
         kOn4aea28jRuF6bcHggWaruSvdi5jvErHwMo6s4ZKrpjkouba6D/l3YpMRMwD6z1jT1a
         cKyJpvQYWh46S2q87tD/kOAQCvM3j2z5W8ygMNz9BT93q980alHZPU/vsPCqpUnI5j1o
         6/MC1ZLAkTV0dpVWwxyheUB9wGTvCsMXiItZxNCfFtlY5B202mQQnyaWnqJn3h73w2hj
         ELdqmUCbDDP/JXHAzzSFXL8Zv1jTGQHb8pgFyvL78g94qhwrlupo7gHO9+DtOreOHh6a
         5q1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771931249; x=1772536049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5ncd4TcdGK7Sah+X7/4jiaz6VRPHla2S8kBCrAzNWY=;
        b=wysI22In/baJa9woEAu+lS4mx5oI62fQ9lj4s/nT8E2DaEMZy1O1LYet4eMipsFzzo
         h7sdLTmXn7KOTR6bs52ZrJpzx7RaUdP9Rn1HES9xzwouUKD+a/pasG0SbGoKs6mP3//O
         NI/6h/PCg3NTbIhYkUlo0XCndxHwKjT/srh4JV/Uy/aqIXxWW0zXwdpPo3wKXY4GHB2p
         m4zCCtGK2m1y8j/sDt3lh2PdYQyHxFT6Fvzoq2FOmzSZvHzGtV7YN0yG6tLIUOtdCnqT
         isWR3VA1YY9mTzjvE0CQdleDfzn4TX1i5Zc4K04mcHalbCneG/7kDBZTUuQyXwX/41Lw
         OgJA==
X-Gm-Message-State: AOJu0YzDCiVNIsZH/vs2OvC6NrcQJFOGjE+7HHrDA5gaN9+QibhCv66F
	20TKy2QTOyB5bQFyx6iSF1w4kpnNcdL2p7Gr3uiK3e1m6S8ju0Qs1sjjPy0Vx5/IF9k2ayG36tL
	rHQ+s
X-Gm-Gg: ATEYQzy3K62Y04cazSC7dY6nQNx/2VcruW5XvQ4PMPUl9tHFu8K53aZEt6Iw9pz9Rj+
	nLQvoAo7qUw89WJIxRYE0Bj20A9dc4n1MNWJWQLul7qxa7b/hUFJbidfCUUHhXhjhCvc4ecHhVX
	8L8deP0czVhLOb8n/fyp7/9DyOe3itl0rfvfINRevqZTwVXFGidBHyuy0vjEAMGQ+0rd0V3GSKR
	2faFXLJlKER7yA2oakbQRtNAXtFynpmENXHTIYjoobWeXeLgCSdMa4ysUd4kzhPT5aaD/8NHIKQ
	WE8XkKpdNl/kndyKns0uVqGVAXOaTPPZo/t86yVvd0t4BdLIQ/y2v6mILv1jXFrZhOnAG5KDvmF
	AIDsWNzBn5YdhQM75ktjSLnHKtPI14LJ9Erqb1XTcdO3JGelcCHjx3/nYkbZJIrM+7eIqEcSznw
	1CSE7kdPY24cMCD3aqhlmKAcDpAP+g
X-Received: by 2002:a5d:5f51:0:b0:435:9f1b:8d19 with SMTP id ffacd0b85a97d-4396f1942bcmr23244387f8f.38.1771931248798;
        Tue, 24 Feb 2026 03:07:28 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9f77sm27422434f8f.5.2026.02.24.03.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 03:07:27 -0800 (PST)
Date: Tue, 24 Feb 2026 14:07:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: linux-sparse@vger.kernel.org, Chris Li <chriscli@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] sparse: add support for __VA_OPT__
Message-ID: <c3758782a34bf9ea174a573b50d6af4916edfea8.1771930766.git.dan.carpenter@linaro.org>
References: <cover.1771930766.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771930766.git.dan.carpenter@linaro.org>

The linux kernel has started using __VA_OPT__ so lets add support for it.

What it does is it adds an optional thing, normally a comma, if the
__VA_ARGS__ parameter is not empty.  So if you have at least one argument
but possibly more then you could create a macro like:

#define test_args(a, ...) printf(a __VA_OPT__(,) __VA_ARGS__)

If you call test_args("foo\n") it expands to:

printf("foo\n");

but if you pass two arguments test_args("foo %d\n", 2) it expands to:

printf("foo\n" , 2);

I guess if you wanted instead of a comma then you could have an empty
__VA_OPT__() or you could pass random things like __VA_OPT__(a b c).  I
don't know why you would do that.  In this case, "a" is a macro argument
so that has to be expanded out.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 ident-list.h  |  1 +
 pre-process.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/ident-list.h b/ident-list.h
index d65668108385..bffc4038a75d 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -66,6 +66,7 @@ IDENT(c_static_assert);
 __IDENT(pragma_ident, "__pragma__", 0);
 __IDENT(_Pragma_ident, "_Pragma", 0);
 __IDENT(__VA_ARGS___ident, "__VA_ARGS__", 0);
+__IDENT(__VA_OPT___ident, "__VA_OPT__", 0);
 __IDENT(__func___ident, "__func__", 0);
 __IDENT(__FUNCTION___ident, "__FUNCTION__", 0);
 __IDENT(__PRETTY_FUNCTION___ident, "__PRETTY_FUNCTION__", 0);
diff --git a/pre-process.c b/pre-process.c
index 05a5a79396a8..94710301ce17 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -643,11 +643,49 @@ static int handle_kludge(struct token **p, struct arg *args)
 	}
 }
 
+static struct token *get_VA_OPT(struct token **p, struct arg *args)
+{
+	struct token *t = (*p)->next;
+	const char *expected;
+	struct token *ret = NULL;
+	struct token *dup, *tail;
+
+	if (token_type(t) != TOKEN_SPECIAL || t->special != '(') {
+		expected = "(";
+		goto error;
+	}
+	while (true) {
+		t = t->next;
+		if (eof_token(t)) {
+			expected = ")";
+			goto error;
+		}
+		if (token_type(t) == TOKEN_SPECIAL &&
+		    t->special == ')')
+			break;
+		dup = dup_token(t, &(*p)->pos);
+		if (!ret)
+			ret = dup;
+		else
+			tail->next = dup;
+		tail = dup;
+	}
+
+	if (tail)
+		tail->next = &eof_token_entry;
+	*p = t;
+	return ret;
+error:
+	sparse_error(t->pos, "__VA_OPT__ error: expected '%s'", expected);
+	return NULL;
+}
+
 static struct token **substitute(struct token **list, struct token *body, struct arg *args)
 {
 	struct position *base_pos = &(*list)->pos;
 	int *count;
 	enum {Normal, Placeholder, Concat} state = Normal;
+	struct token *va_opt = NULL;
 
 	for (; !eof_token(body); body = body->next) {
 		struct token *added, *arg;
@@ -697,6 +735,10 @@ static struct token **substitute(struct token **list, struct token *body, struct
 
 		case TOKEN_MACRO_ARGUMENT:
 			arg = args[body->argnum].expanded;
+			if (va_opt && !eof_token(arg)) {
+				list = substitute(list, va_opt, args);
+				va_opt = NULL;
+			}
 			count = &args[body->argnum].n_normal;
 			if (eof_token(arg)) {
 				state = Normal;
@@ -716,6 +758,11 @@ static struct token **substitute(struct token **list, struct token *body, struct
 			continue;
 
 		case TOKEN_IDENT:
+			if (body->ident == &__VA_OPT___ident) {
+				va_opt = get_VA_OPT(&body, args);
+				continue;
+			}
+
 			added = dup_token(body, base_pos);
 			if (added->ident->tainted)
 				added->pos.noexpand = 1;
@@ -1234,6 +1281,8 @@ static struct token *parse_arguments(struct token *list)
 	while (token_type(arg) == TOKEN_IDENT) {
 		if (arg->ident == &__VA_ARGS___ident)
 			goto Eva_args;
+		if (arg->ident == &__VA_OPT___ident)
+			goto Eva_opt;
 		if (!++count->normal)
 			goto Eargs;
 		next = arg->next;
@@ -1312,6 +1361,9 @@ Enotclosed:
 Eva_args:
 	sparse_error(arg->pos, "__VA_ARGS__ can only appear in the expansion of a C99 variadic macro");
 	return NULL;
+Eva_opt:
+	sparse_error(arg->pos, "__VA_OPT__ can only appear in the expansion of a C99 variadic macro");
+	return NULL;
 Eargs:
 	sparse_error(arg->pos, "too many arguments in macro definition");
 	return NULL;
-- 
2.51.0

