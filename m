Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6FE1D90B3;
	Mon,  2 Dec 2024 17:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160904; cv=none; b=hnyINPmjWfycBzQGJe8VPx1ae7P7YpRPojJr3ELsEa2fiGHrrXCcL5yJJdMb9gyvcEVHz13embUNO3QW5YMd/5jBQtNYPHV+C1bvVe9of/Np1JAAp8Qp8oI5UBgjAKc2lPvVNxD5RFFyjmJJIhvt4cbTe+5zOyS8JjZByVNDt/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160904; c=relaxed/simple;
	bh=5SkdVpyxMkwcefHUvrmeRmooVspzWLLjyCNkLAyYF/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JlYSDkUvLpeILBF+771Th+HASIVKqkavtmXhk0lskC5/c7TAzlz1H41IWjBOoiuTIqP8hkcC8tXAcm961M0aC8P7aCxR0wCvXmOO0hj5i0hEDparm7DRjnEpdRKEj6paLzyIlSMzIlNxFBrIqut93Hk+fP8gLvgrTwdOFd+sNzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krYcOchp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krYcOchp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB054C4CED6;
	Mon,  2 Dec 2024 17:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733160904;
	bh=5SkdVpyxMkwcefHUvrmeRmooVspzWLLjyCNkLAyYF/4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=krYcOchpdZfTOGmmZmYXGkkzng0VBYzBaTIPS/JdWNiJdmt/4S7+V2deZeuJtDiHJ
	 5bOfjWx9PMCJkw4vWMJA+j7RGJgyQT3MCvZz+ywWGgXkUPQ1I8zhp2RRNDd7wmPgUC
	 KVr3TdRx7r3vS7sNZQQ4VuZSeMJ1Co4MyFc7SbZRWDfa4cIk4lQ19T0FRsrpwOa17T
	 JopKvCO/OnNKT3V7n07PfE9Ll3My7kWEoWbthp4JMgarfO7M35ovTZ+SUQIDeAkdh8
	 VxQs0KDQFLoqYMNE9XZ9vIlYg+Eia5POewyoXqK+ltXanlAIbCfNk8+zvx51tcJKic
	 OeLS9BafEnm7Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CC9D7833C;
	Mon,  2 Dec 2024 17:35:03 +0000 (UTC)
From: Vincent Mailhol via B4 Relay <devnull+mailhol.vincent.wanadoo.fr@kernel.org>
Date: Tue, 03 Dec 2024 02:33:23 +0900
Subject: [PATCH 01/10] compiler.h: add statically_false()
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-is_constexpr-refactor-v1-1-4e4cbaecc216@wanadoo.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1089;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=MUJOQQOOJL9dYDVaPT65KhZRSmD+ZVJ1pjvxSAixArY=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDOm+74/KH7/U7qegXjXTofXb3TYljXrmuVYbMjW/tLXe4
 w0P49vQUcrCIMbFICumyLKsnJNboaPQO+zQX0uYOaxMIEMYuDgFYCKiExj+h59n32w4XUS9Q6Hd
 rUTL9LrKv/cufhltT6M9vi38WfriOSPDth1s9Y4XTgudV69oFplrmhzR2RRm0jljjlHtl08TxWX
 ZAQ==
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
X-Endpoint-Received: by B4 Relay for mailhol.vincent@wanadoo.fr/default
 with auth_id=291
X-Original-From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reply-To: mailhol.vincent@wanadoo.fr

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

For completion, add statically_false() which is the equivalent of
statically_true() except that it will return true only if the input is
known to be false at compile time.

The == operator is used instead of the ! negation to prevent a
-Wint-in-bool-context compiler warning when the argument is not a
boolean. For example:

  statically_false(var * 0)

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 include/linux/compiler.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 469a64dd6495fefab2c85ffc279568a657b72660..a2a56a50dd85227a4fdc62236a2710ca37c5ba52 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -314,6 +314,7 @@ static inline void *offset_to_ptr(const int *off)
  * values to determine that the condition is statically true.
  */
 #define statically_true(x) (__builtin_constant_p(x) && (x))
+#define statically_false(x) (__builtin_constant_p(x) && (x) == 0)
 
 /*
  * This is needed in functions which generate the stack canary, see

-- 
2.45.2


