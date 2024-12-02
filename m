Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5420B1B07AE;
	Mon,  2 Dec 2024 17:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160905; cv=none; b=HIkmDi/7MXgDiT/fJpwFO57DNq65fm4/rhrf5/+N9cfMtrN6inmNfQ558FU+odDZBgAH8N519y3FLD+99isD0JpGUE8AzjPn3bsln2fBp8AVriBheTJIlXk+JC4NiG6ic4UhxbAkLvi9OXUVN6GSMbJU0+xp4Yzu/NrUMDVdu+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160905; c=relaxed/simple;
	bh=yr8nPgorqsKZslW18S7DrfbJzdSBjOy5Dm3FgmZaCBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kcg11sOe3MO5XqAGKUblfAxwMZDMKwxCjyxbiV2pKZMoypqZrk5I8mLPRlO5i85d1HXviQnFyuWqmkPruUpSX/WXp8TRBqHcczi1w4NZZbrcJmqnV09COkpDMo2etFAKfX4nqMHnD7src/ISlNdsthp8MGqIEGbvack5ouYe6DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXO4sW7K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXO4sW7K"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6DCAC4CEE1;
	Mon,  2 Dec 2024 17:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733160904;
	bh=yr8nPgorqsKZslW18S7DrfbJzdSBjOy5Dm3FgmZaCBU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FXO4sW7K+gc2vwM1se4GLS2jISLC4Hv85218fTBlxgqHaepVn0KVqtw5xphianfNI
	 h+wVBnQYK0tMREorbt8f9+hmHMOkOSVx+q+E2s5zbRrnGuoCllEFGiWbUwo6Fjllmy
	 fCUyb8OgeS7twO7222857W4QWof1k1Sa8HgeTQwrLcD1Ei793+c8JCrdZ5RXLygiws
	 ZTk+5w6Tx5013RuYIOLIHRFEV6bNFL/FTUUdlecC4pe15aPkt4CYE2ksT3Nnc0r5qj
	 N5aHHomI55Mhxi7/41e44zKJc3dncVCnCU4vbjgHyJ8SVCvF77uaHJSsGp7/RVdgkQ
	 d6o3sa2MQfa2Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BE6D7833C;
	Mon,  2 Dec 2024 17:35:04 +0000 (UTC)
From: Vincent Mailhol via B4 Relay <devnull+mailhol.vincent.wanadoo.fr@kernel.org>
Date: Tue, 03 Dec 2024 02:33:31 +0900
Subject: [PATCH 09/10] coresight: etm4x: replace __is_const_expr() by
 is_const()
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-is_constexpr-refactor-v1-9-4e4cbaecc216@wanadoo.fr>
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
In-Reply-To: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 David Laight <David.Laight@aculab.com>, 
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Rikard Falkeborn <rikard.falkeborn@gmail.com>, 
 Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
Cc: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1152;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=2a9e0Sg1+HnRtDgEsb84OXVQoFxUHpuXTO0qI7avR5g=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDOm+749O6FPas2ybatTeWc7prF16x3VX6XbM9TgktOrU7
 v8zpTx3dZSyMIhxMciKKbIsK+fkVugo9A479NcSZg4rE8gQBi5OAZjIEUmGf4rH5jmVbpEP/Ddj
 A+/Sm/sTG/nmCVoanpxpWRL3vYGNfyIjQ/eqI0k+TNe37ZmStZpB6ZREi/BkBbfsadXL0zZxGHr
 +5wYA
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
X-Endpoint-Received: by B4 Relay for mailhol.vincent@wanadoo.fr/default
 with auth_id=291
X-Original-From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reply-To: mailhol.vincent@wanadoo.fr

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

is_const() is a one to one replacement of __is_constexpr(). Do the
replacement so that __is_constexpr() can be removed.

Refer to [1] for an explaination of why __builtin_constant_p() can not
be used as a replacement here.

[1] commit 4d45bc82df66 ("coresight: etm4x: avoid build failure with unrolled loops")
Link: https://git.kernel.org/torvalds/c/4d45bc82df66

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/hwtracing/coresight/coresight-etm4x.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 9e9165f62e81fe5a87d35b4e30bc23f93cb211ec..91cf81ac46f44418f76783c102477d08f9abc70f 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -492,7 +492,7 @@
 	({									\
 		u64 __val;							\
 										\
-		if (__is_constexpr((offset)))					\
+		if (is_const(offset))						\
 			__val = read_etm4x_sysreg_const_offset((offset));	\
 		else								\
 			__val = etm4x_sysreg_read((offset), true, (_64bit));	\

-- 
2.45.2


