Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572346AA7;
	Sun, 17 Nov 2024 05:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731821202; cv=none; b=kMuUopXjG5jRix7gDwyuiZZhIbnK0QNYgIEgtEmj7j8l/w2hhE1mMbFqb9xZSP64nfQxtB2I/8gblBYqjn3oSfm3Jc06iUAYiCMBNuE3p8K43bXUcz7u0979jjlyBTgXsTp1ZbtEF85SqQhSgLHJ5bxgBMw9YYZzgFxr3EdQZkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731821202; c=relaxed/simple;
	bh=RJxiXFXQu4UdQqTOlJG7VZ5TbO+8ahl6FEJzpLSDedQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MSNE3dlx4VFtLEFFpn4E2FGWb89rAECuPpxuSvH1MBVhVvZMUIjWNg8ByMNFcOVVl0YGqO9HKsECnz9RggkiP1PiClZsf2xOzGtooB/t6ZGd6uFK0z+Vvs188UxfPA+rgSNIgvSg0K7s30rtZFFfuzS28sP8FvI3mUf4V3XrHeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHocZkkc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHocZkkc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF46C4CECD;
	Sun, 17 Nov 2024 05:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731821201;
	bh=RJxiXFXQu4UdQqTOlJG7VZ5TbO+8ahl6FEJzpLSDedQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cHocZkkcroXT7Go/mutUNrj0dsotAznMn9t27WQ8ILEIfqqND2on2FpDbXsBiGM5M
	 9Jt9pYhtaF5EvN59lKSJYBwk3/CiStgMlqmreS3Fb9vQEVEg7qC2Ym0ZKNoxahHidn
	 pLlp4XVxLdkda+V2xGnQ+pfP1GOtgqqpaJeyHNVWBo1dpadAJ4lD/3aiYYNYjwXWi+
	 FMWOfDWaMbVmlb/HRxFp3zfSYwaE6hpnjNgCoosYmhWzZG+N6Qkm25YxtPHGRslCdW
	 GMrRTCZAgiDxFeLUw1o6TKsqTy0Pj+COf7JpFp+eA+rzmA1IN/aSFUXtCFy8hrg4P/
	 gJrHgOF4vN3fA==
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Philipp Reisner <philipp.reisner@linbit.com>
Cc: Kees Cook <kees@kernel.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	linux-sparse@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compiler.h: Fix undefined BUILD_BUG_ON_ZERO()
Date: Sat, 16 Nov 2024 21:26:33 -0800
Message-Id: <173182119158.650820.5112435274770871325.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115204602.249590-1-philipp.reisner@linbit.com>
References: <CAHk-=wiPZmd1hrsUoP+9vPg2=E0Jj6Li77_BZcV9GocbJg8fag@mail.gmail.com> <20241115204602.249590-1-philipp.reisner@linbit.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 15 Nov 2024 21:46:02 +0100, Philipp Reisner wrote:
> <linux/compiler.h> defines __must_be_array() and __must_be_cstr() and
> both expand to BUILD_BUG_ON_ZERO(), but <linux/build_bug.h> defines
> BUILD_BUG_ON_ZERO(). Including <linux/build_bug.h> in
> <linux/compiler.h> would create a cyclic dependency as
> <linux/build_bug.h> already includes <linux/compiler.h>.
> 
> Fix that by defining __BUILD_BUG_ON_ZERO_MSG() in <linux/compiler.h>
> and using that for __must_be_array() and __must_be_cstr().
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] compiler.h: Fix undefined BUILD_BUG_ON_ZERO()
      https://git.kernel.org/kees/c/d7a516c6eeae

Take care,

-- 
Kees Cook

