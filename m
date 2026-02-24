Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EB73806C2
	for <linux-sparse@vger.kernel.org>; Tue, 24 Feb 2026 11:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771934202; cv=none; b=k6DFK5xIyR9bjA+Ds4Dp0r2nx8gn7EvG2PkAdlkzZuYqdIxZEzNlb+B3THm1eaeA2RgpThxcbpnihp7MVFQmLrNhOTvql5GqK2u1zdn5qQnweYoOGn1QnB3BdfTN728jqJT2A6BzIaGERCp/KW2VYjnY8OywkEc/5g7eiDmjqVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771934202; c=relaxed/simple;
	bh=2VgeoYDCZOLeq+8z7/qfjHRPDf2xbbYZFSKEGm3e9Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmepCj9682mmyyQLzRz5nHpCk/F1HHK4C8Hpvg1ubDGIDYMbWiQbNN01nHpKJX3AkmICkNiF64TEjdHhXu1O9z87DMOESRRJBOjjxW0Pp8gM+cwN1Pai6ye5T0J2gVL3vMdfrEw1nQz5/f69af6Qk1OHf5n6zzxvf9v0OwIKBd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PVJ0Ob05; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PVJ0Ob05"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4807068eacbso42483285e9.2
        for <linux-sparse@vger.kernel.org>; Tue, 24 Feb 2026 03:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771934199; x=1772538999; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l7AhyxP2LtafPuMOdfkBmaBTE3WdIaGB2Sjoh2bnLfg=;
        b=PVJ0Ob05tVNNwzuAF2qYX+XCANFIJf6pYksH9+OxSJczR4Zcgup4Q3uD7ud30bOOt/
         5VI3P09G74kb2QmzP0uYPhzKNuFjN8njYnk4d/6Bo+M89OywNVjfn/GyyAFz2qGbtvvV
         Sgu+XOW22IxHr32eTJm12ZkDAyjl/PflCN+i51nNUUikrelQG6B9lViINQq7oE5lf4Bz
         B2FjQ4+3RXzsRcsiKIoMDeajQOu1kJy2uywkjiDf4N6nijnR69wfo4yUJczw8w9+m/6a
         EAit214IMFr1ce6r4zbHScTD1KYOvbUFwl1JWGwsEYXW0rQKtBcaG7SShNDPegXbKvCZ
         VOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771934199; x=1772538999;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7AhyxP2LtafPuMOdfkBmaBTE3WdIaGB2Sjoh2bnLfg=;
        b=Lz30f0N5lg665o8twcFVxZtY+PfjnMn0inPmiL9uVqdF9+lEb2oH7j3G+kGj3UKAlG
         3dGB4huRZ/hdg4kjVWJNPdvqn1j0Kg7e2bOApdL4Y9GFhgZw7y2uQgGPbyhiaMmrTzAA
         2zwzdLxHDbKEQW2I3Y+zeX5HkAqbJn08wjT3wDQZUxRVvYT14LQNvTyadC/9WzClSbbh
         MFSXzh4XoFvmONyILMvSHsA126rCqzfm+PeTU8mrGn5yW+5RhAlPvy3wZV48ro2mvqk9
         Qo1XtjINjDMqeYJAzDYwHPNrFVdFqXM10GPFsAx0n4YXYJen153PR3+ijoVzpk6e+u2x
         wxqA==
X-Gm-Message-State: AOJu0YzMPz+LyFfZz+QLJSqw99cb7dfXHVoe5HX0f5K49UJUO/Q1MxzK
	3tz5BNt/kvgbiO9lFZmfmC+xuhFJJlmH7Ut0yDHq+7ZbRkTdsJSI3H/CqYrsmERYs30=
X-Gm-Gg: AZuq6aIu49zfe/tV7xmhPnBig/IrrRxoulH1YIy09gUcKdAg1V3J8QzXHyu0NMDatGk
	UC4S7619IxbLC/hZn0zbmmrDQCOjNGVcjjo9GigVhdrGCD608BNAnkfxhXPennGoFwPfrQF+Azi
	9smRtk4BKQDS7EInmbBgzGLlntbFsxo65hGEpoYIi0P0xSu2X4t3XauZQjL1lAmBtQFCbZxxtTH
	LUSNMPv7zq9YvFRjeXIAbyR8nLKiuhCN7WGtwc65BnzrhizEAi2CH36VTFo3uJjDyCCXfhd/8kx
	K0kFa+0q49j1ovLaQEzXvVUp514UCCGPchpbTxST+QxuktwfwfwkDt7aPxPJFLw6ReLebxS7uyd
	P1IOgMuoPR3yZ1Li066Vb0IshhEgplhWj9ma8uBaSTEG6lyWDEP491Y1GkGgO6U9Bhx3ZEZLoz1
	jjrtQFPJqlN+D8Jpn3/9ZfyP/Cu9/H
X-Received: by 2002:a05:600c:3484:b0:483:3380:ca11 with SMTP id 5b1f17b1804b1-483a95ee3fdmr173388085e9.33.1771934199067;
        Tue, 24 Feb 2026 03:56:39 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483b8791a0esm57581935e9.0.2026.02.24.03.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 03:56:38 -0800 (PST)
Date: Tue, 24 Feb 2026 14:56:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-sparse@vger.kernel.org, Chris Li <chriscli@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH] sparse: add support for __VA_OPT__
Message-ID: <aZ2R8k1MRiPwJwOC@stanley.mountain>
References: <cover.1771930766.git.dan.carpenter@linaro.org>
 <c3758782a34bf9ea174a573b50d6af4916edfea8.1771930766.git.dan.carpenter@linaro.org>
 <29424a96-4c7c-4076-99bc-903cd857f89a@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29424a96-4c7c-4076-99bc-903cd857f89a@codethink.co.uk>

Oh, sorry, Al's branch changed that code more than I imagined.  I would
resend the patch, but I need to figure out this GCC warning...

  CC      pre-process.o
pre-process.c: In function ‘substitute’:
pre-process.c:785:16: warning: function may return address of local variable [-Wreturn-local-addr]
  785 |         return list;
      |                ^~~~
pre-process.c:687:31: note: declared here
  687 |                 struct token *added, *arg;
      |                               ^~~~~

Anyway, here is what I've forward ported.

regards,
dan carpenter

---
 ident-list.h  |  1 +
 pre-process.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/ident-list.h b/ident-list.h
index 3c08e8ca9aa4..556d4050c88d 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -65,6 +65,7 @@ IDENT(c_generic_selections);
 IDENT(c_static_assert);
 __IDENT(pragma_ident, "__pragma__", 0);
 __IDENT(__VA_ARGS___ident, "__VA_ARGS__", 0);
+__IDENT(__VA_OPT___ident, "__VA_OPT__", 0);
 __IDENT(__func___ident, "__func__", 0);
 __IDENT(__FUNCTION___ident, "__FUNCTION__", 0);
 __IDENT(__PRETTY_FUNCTION___ident, "__PRETTY_FUNCTION__", 0);
diff --git a/pre-process.c b/pre-process.c
index 4e322855d600..364c68489a84 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -638,11 +638,50 @@ static int handle_kludge(const struct token **p, struct arg *args)
 	}
 }
 
+static struct token *get_VA_OPT(const struct token **p, struct arg *args)
+{
+	struct position base_pos = (*p)->pos;
+	struct token *t = (*p)->next;
+	const char *expected;
+	struct token *ret = NULL;
+	struct token *dup, *tail = NULL;
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
+		dup = dup_token(t, &base_pos);
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
 static struct token **substitute(struct token **list, const struct token *body, struct arg *args)
 {
 	struct position *base_pos = &(*list)->pos;
 	int *count;
 	enum {Normal, Placeholder, Concat} state = Normal;
+	struct token *va_opt = NULL;
 
 	for (; !eof_token(body); body = body->next) {
 		struct token *added, *arg;
@@ -692,6 +731,10 @@ static struct token **substitute(struct token **list, const struct token *body,
 
 		case TOKEN_MACRO_ARGUMENT:
 			arg = args[body->argnum].expanded;
+			if (va_opt && !eof_token(arg)) {
+				list = substitute(list, va_opt, args);
+				va_opt = NULL;
+			}
 			count = &args[body->argnum].n_normal;
 			if (eof_token(arg)) {
 				state = Normal;
@@ -711,6 +754,11 @@ static struct token **substitute(struct token **list, const struct token *body,
 			continue;
 
 		default:
+			if (token_type(body) == TOKEN_IDENT &&
+			    body->ident == &__VA_OPT___ident) {
+				va_opt = get_VA_OPT(&body, args);
+				continue;
+			}
 			added = dup_token(body, base_pos);
 			if (token_type(body) == TOKEN_IDENT &&
 			    added->ident->tainted)
@@ -1094,6 +1142,8 @@ static struct token *parse_arguments(struct token *list)
 	while (token_type(arg) == TOKEN_IDENT) {
 		if (arg->ident == &__VA_ARGS___ident)
 			goto Eva_args;
+		if (arg->ident == &__VA_OPT___ident)
+			goto Eva_opt;
 		if (!++count->normal)
 			goto Eargs;
 		next = arg->next;
@@ -1172,6 +1222,9 @@ Enotclosed:
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

