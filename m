Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC59165F17
	for <linux-sparse@vger.kernel.org>; Wed, 13 Nov 2024 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731519025; cv=none; b=eAd5H7Rl5S+8CZOq7LcTFAG/H9Ec21nKp3UBu/atvPIMCz7zcwBfPydL0oo0ztOKYYDxiPICCKB3gqxrItq+Q7wivxbwz0qcfeLg6pCM1op+PTTJV10KTWsam+U6k5pFEjEnqp+CQQrVZQs254SJV9E+CDMZgkXKinyAfNVmEfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731519025; c=relaxed/simple;
	bh=PwfHx4AF8ld/SKw0YKnmiiYM5VeZ7ME6TNFBrnt8Twk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WXjan0QqDOF1sHcwGNnHuy7oA3lgOMQGZlmP4VVrU3yTJjVB64ld3VFbKrj9Xomb6jSPYTG0Lw3OZCmHJ+WhMANadqp9ZTCS64ue3iZB6Xf91XToH5RuCPWxPxnZfGIZodhHCALZyOWw1I3IvFli3R+2Syf73kyTERrjBvOv8Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Nc7rWx06; arc=none smtp.client-ip=80.12.242.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Nc7rWx06"
Received: from localhost.localdomain ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id BHBhtnfvcYmvZBHBztEx3p; Wed, 13 Nov 2024 18:30:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731519014;
	bh=pM/L8af+pYG7ktkzsToPr37ePWA0GwmVusU7tEiF/R4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Nc7rWx06q5P239h3z+XSDD++dgCIwAHntxvPJBs6aZSaJYVBxlyagWLQ1JYGA8RKC
	 CIp+WsC6aycH21zWzU4gPZD7So5OOhZOO/6ma7+d5gT+BRzV1w1H0x3h+klFJDz6RJ
	 CF/pMUqnqBgGyUCgHjACJRQpvizyDmAygjF7bEoYsM+sTrtgNA7T4l2m2/zOqzhUx+
	 B7kXhBu9z2us8trhttDdl5qdwADR1vx3/b3uTMJ3Dp/LvNVNJ/bo+S7cDSGi6Gugle
	 +2CK9rpvT1hCqVLzS3jnOKrs3yzNc3v+AMkdp0hpFxQKCibcfn/k5PIiuZUnxZnKLU
	 IPZV4XJGIYwCA==
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 13 Nov 2024 18:30:14 +0100
X-ME-IP: 124.33.176.97
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sparse@vger.kernel.org,
	Rikard Falkeborn <rikard.falkeborn@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v4 0/2] add const_true() to simplify GENMASK_INPUT_CHECK()
Date: Thu, 14 Nov 2024 02:18:31 +0900
Message-ID: <20241113172939.747686-4-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2456; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=PwfHx4AF8ld/SKw0YKnmiiYM5VeZ7ME6TNFBrnt8Twk=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOkmj5g92+UOfdPZt0jhr93FRbdfbHK643Xx+S5XnQ2Tt 3+rL3fu6ihlYRDjYpAVU2RZVs7JrdBR6B126K8lzBxWJpAhDFycAjARNXVGhlVHhLsbOU68Vth2 ff6Su3mTuOSXyJrznm19nGA0YWbwt0qG32xxn+yaD39emn/J9hWD2YqqHY3+EdcnbJjXNSP/6CE VBmYA
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

The first patch introduces a new variant of statically_true() named
const_true() which rely on __is_constexpr() to produce a constant
expression result which can be used in BUILD_BUG_ON_ZERO() and other
macros which expect a constant expression as input.

The second patch applies this newly created const_true() to
GENMASK_INPUT_CHECK().
---

** Changelog **

v3 -> v4:

   - rename _statically_true() into const_true().

   - fix incorrect subject in the first patch.

   - s/Declare/Define in first patch description: macro are defined,
     not declared.

   - move the godbolt link with the tautology folding examples as a
     footnote into the patch description (was after the --- scissors
     in v3).

   - add more examples of tautologically true expressions in the first
     patch description.

   - Rewrite the paragraph in the macro comment which compares
     statically_true() with const_true() and add code examples
     directly into that comment.

Link: https://lore.kernel.org/all/20241112190840.601378-4-mailhol.vincent@wanadoo.fr/

v3 -> v3 RESEND:

   - send email using the smtp.wanadoo.fr gateway. Note that this may
     appear as smtp.orange.fr which is an alias (both have the same IP).

Link: https://lore.kernel.org/all/20241112140454.518823-4-mailhol.vincent@wanadoo.fr/

v2 -> v3:

   - split the single patch into a series of two patches.

   - add explanation of why _statically_true() is needed in addition
     to the existing statically_true(). Explain the pros and cons of
     each.

   - use __builtin_choose_expr() in _statically_true(). The
     _statically_true() of the v2 works perfectly fine when used in
     conjunction with BUILD_BUG_ON_ZERO() but fails if used, for
     example, in arrays or in static_assert().

Link: https://lore.kernel.org/all/20241111164743.339117-2-mailhol.vincent@wanadoo.fr/

v1 -> v2:

   - introduce _statically_true(), taking inspiration from
     statically_true() as introduced in commit 22f546873149 ("minmax:
     improve macro expansion and type checking").

Link: https://lore.kernel.org/all/20240609073513.256179-1-mailhol.vincent@wanadoo.fr/

Vincent Mailhol (2):
  compiler.h: add const_true()
  linux/bits.h: simplify GENMASK_INPUT_CHECK()

 include/linux/bits.h     |  5 ++---
 include/linux/compiler.h | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

-- 
2.45.2

