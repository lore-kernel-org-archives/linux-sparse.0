Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F9B21147B;
	Mon,  7 Apr 2025 16:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744044402; cv=none; b=oPUzTXsMuMQJ7H8vfUnPPud++nArbp7ukjdYzB4yt8cWpj89IQC9IIj+B45mvUBoU/EfmjHZMuArroRhlVgT82z8X0cJNBP9vfK+PN/MD4Q3arMY7QPBP/8pubcBarb6Qpd8HrbRbBAZyWFy8rGJl3of/BDnCwHHaUNsiOfVuFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744044402; c=relaxed/simple;
	bh=gtCxwqcwHV7JMLc4dhr/qLUcE6NGcfly15hO6N+cHNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gd8ajVqR/Ws+8SAJqq1zG1STUVQXRsbJ2MT1cW1UIn+fQkABwbLjFa/PCmmzvOdPe8/ZXX3i0CLUanwTbkx43P1m9t7fVoetkF1/A0Nj8KVqUkU/xepjySiJ3u/17ITskx6RlUKsoMKKdUqzAbF1gKVo5msEc6JwjfQDXJk+z+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4JNxyPx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4JNxyPx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324C0C4CEE9;
	Mon,  7 Apr 2025 16:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744044402;
	bh=gtCxwqcwHV7JMLc4dhr/qLUcE6NGcfly15hO6N+cHNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d4JNxyPx07oVp+2MnlbNyxuH8d+smt6L5XHAQ8UpN1CKyCSi3AwKsM6EZ+uC2iQ0j
	 nmLkj1+hr4Af/zKfth7pDuGSwgetchf7KGBTtoZDwGD1z80aJykfSvymrVE6xgzdLb
	 Txzz4yX7KCgwyMG/pnugmDFc/RnDZn0vEy2QuR4CLCoqBl5HKtxzc0CFKQImvMya6F
	 74+UkL8FN7JeHpSTTxiZl27qrwEHQU0y3wQf7oFTd3/GN72CJ7CY5Exf8HlHLBFJBT
	 HJI6mNHZ+Hu7c/mh43zese+btOlP12X32mbbeG6gz/fVh4SmQx3uaxsstjtmUJQqOh
	 MWzPQchjUcU2A==
Date: Mon, 7 Apr 2025 09:46:39 -0700
From: Kees Cook <kees@kernel.org>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
Subject: Re: [PATCH v2] build_bug.h: more user friendly error messages in
 BUILD_BUG_ON_ZERO()
Message-ID: <202504070945.BAC93C0@keescook>
References: <20250329-build_bug-v2-1-1c831e5ddf89@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250329-build_bug-v2-1-1c831e5ddf89@wanadoo.fr>

On Sat, Mar 29, 2025 at 01:48:50AM +0900, Vincent Mailhol wrote:
> __BUILD_BUG_ON_ZERO_MSG(), as introduced in [1], makes it possible to
> do a static assertions in expressions. The direct benefit is to
> provide a meaningful error message instead of the cryptic negative
> bitfield size error message currently returned by BUILD_BUG_ON_ZERO():
> 
>   ./include/linux/build_bug.h:16:51: error: negative width in bit-field '<anonymous>'
>      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
>         |                                                   ^
> 
> Get rid of BUILD_BUG_ON_ZERO()'s bitfield size hack. Instead rely on
> __BUILD_BUG_ON_ZERO_MSG() which in turn relies on C11's
> _Static_assert().
> 
> Use some macro magic, similarly to static_assert(), to either use an
> optional error message provided by the user or, when omitted, to
> produce a default error message by stringifying the tested
> expression. With this, for example:
> 
>   BUILD_BUG_ON_ZERO(1 > 0)
> 
> would now throw:
> 
>   ./include/linux/compiler.h:197:62: error: static assertion failed: "1 > 0 is true"

This is so much easier to read! Thanks for this. :)

If no one else snags it, I can take this via the hardening tree for
-next once -rc2 is released.

-- 
Kees Cook
