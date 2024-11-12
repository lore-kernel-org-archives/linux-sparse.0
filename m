Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E06217659
	for <linux-sparse@vger.kernel.org>; Tue, 12 Nov 2024 19:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731438549; cv=none; b=eh5XEBwgng518mNspTewezOlQxed1i4yuZBpSr/Vju9ovc0PAZq/mDumrGU2TDQqySqmUaFqEUJga6EyHmuwsXxfdj91iApkQL0PbQh+ottJqZuyWtsewUtNFeraUdNklYhA21/GByRGX5rqXfdWGYnrBJe6rfsU/SOxcL1TCP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731438549; c=relaxed/simple;
	bh=nWRQjn91DNK5zz+b2an8tRM8K0bt+EfpoZOjFlH3LcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HPV17MS4rQoqRA6n3AYM5ZbSaYhLcbqOwj0ENagGj4GIxtDQ0NSlh9tgXnROK51guvF6/1Sj64jVXSvUDzPcbJmgJzQHZ/Jb7XA5lYr8mZl+5vn2jPviFcdl2pIyUbozswf97PXuJRyq52RjZQnJgeDDmtCrlixHLMfIC4y2KHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=fyix5Dcn; arc=none smtp.client-ip=80.12.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="fyix5Dcn"
Received: from localhost.localdomain ([106.146.16.70])
	by smtp.orange.fr with ESMTPA
	id AwFntjwiq18HRAwFxt29oF; Tue, 12 Nov 2024 20:08:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731438539;
	bh=Uh2aYyWQsACom5KFNN2Py5OBj+Ni+B3nIaWCn08jwsE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=fyix5Dcn66dN5sfw+t2A0lW+BbqoFqsYSiyIeuGSEYAVkP2lUE8crZDuMpYvHgK1f
	 8qzJPvS9biPCdNwRbDl4XjXdqg/OPWYN8oQCrEknyHOvKIbECQVDXIsLNYzJJPUyTf
	 N5TD8SNfYrYFCa+01CoWrZ10iXzAo8LF/vRr3K0p6PxwgD33rT0JF0os7z25ggjUQX
	 XSSVte5SCgpaHtq+KT0TbS1gAI4W//H3vjrHVq5tInS3tANv8VuzJFi1i4Q7MVwDhJ
	 QnPwyOHtVhg+V2j8hgkDmemWnBwDAggqGxxoTxqOJSPcpHXYm3dkZDjLn4lgalsial
	 tSUrResDQY+Sw==
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 12 Nov 2024 20:08:59 +0100
X-ME-IP: 106.146.16.70
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sparse@vger.kernel.org,
	Rikard Falkeborn <rikard.falkeborn@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RESEND PATCH v3 0/2] add _statically_true() to simplify GENMASK_INPUT_CHECK()
Date: Wed, 13 Nov 2024 04:08:38 +0900
Message-ID: <20241112190840.601378-4-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1657; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=nWRQjn91DNK5zz+b2an8tRM8K0bt+EfpoZOjFlH3LcI=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOnGy3dI3rgl/W3yxzfGv3s+PjgjE5Vt4m5UX5LMlzvhX afWgt6zHaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACYyQYPhn9bl1e33eD8EV3ZO jbiiOeN4r9nizc+73oc838yhJbwhvZ3hD8fuF2qRikY2a82NH7dYdfG2ceYr8K5caCnmUP4uU2Q 2IwA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

The first patch introduces a new variant of statically_true() named
_statically_true() which rely on __is_constexpr() to produce a
constant expression result which can be used in BUILD_BUG_ON_ZERO()
and other macros which expect a constant expression as input.

The second patch applies this newly created _statically_true() to
GENMASK_INPUT_CHECK().


** Changelog **

v3 -> v3 RESEND:

   - send email using the smtp.wanadoo.fr gateway. Note that this may
     appear as smtp.orange.fr which is an alias (both have the same IP).

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
  compiler.h: add _static_assert()
  linux/bits.h: simplify GENMASK_INPUT_CHECK()

 include/linux/bits.h     |  5 ++---
 include/linux/compiler.h | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

-- 
2.45.2

