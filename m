Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F20158553;
	Tue,  8 Apr 2025 19:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744138988; cv=none; b=Al0gNKGOX3f1wG8TnnfYcDtIXWR3cf+sUyf1RLRKp1Klr6tzaI8oTuXNTdt3dx5DG8r+1135Ek3/Z520BC2DW9JG2etgitI11rSvyyR4WI4p5avuV1za4cPhFvt+cXvJsPKL1JQcA2cxTgKwiHSyYIrerdQP9FlmiYN1Pt0LVSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744138988; c=relaxed/simple;
	bh=t4FrvMuDefXty/PRkKfSsxRKuBYF7zijbehdwboarCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/5TSUC4sw3A6KGPswAt9N0yzICmANx0UhkdnXBw6fiiQ4EzmnOq4cOBXoHW/iaK3kwsyqw9L2LeoYmxlZnMS2WUkEiIGNtYmeQHC9P9KKNDNMMN7JZdFfy90IBuuvQdIX+fHvLH0pZyH4VFGaCNEyFfeHF6y4yOo3KoA2f3ZmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGZFbWKM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGZFbWKM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB62C4CEE5;
	Tue,  8 Apr 2025 19:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744138987;
	bh=t4FrvMuDefXty/PRkKfSsxRKuBYF7zijbehdwboarCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tGZFbWKMmsuRvv1/kF0cm6PL/kZTjwao/mGQG3sdcs2ax5/Wz6GxUt8o2GnBmeR8p
	 LiktLY3Jjy/5lr7PQ+5MWSx0R5c9liKJ1xsgqIKmfDzK3+kl9i/CmlQi1YYhetwdlE
	 ZxE8Ln6TLDJmTjOXCcQvR8E0iyABh2uekw5CDpzLjA1CTiXvp5CXzEaHA8zgRefJMO
	 kRvHTaZ9YtsbVA/B4dMnXhZKI591hzFxrTdvzavbx1CbBCM6VkVGci0hNLop0Z6JV7
	 IlSIxO3VoQB+DA3c5o9pnjdYHPqWikNEkzbi4YiHpoLkYP4syZxzW/OGYOguwA5zkG
	 CbEpDWf9jAQiw==
Date: Tue, 8 Apr 2025 12:03:04 -0700
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
Message-ID: <202504081202.7CA5DBE@keescook>
References: <20250329-build_bug-v2-1-1c831e5ddf89@wanadoo.fr>
 <202504070945.BAC93C0@keescook>
 <9dc6f94e-c739-4fdf-8e43-4386d35e02e5@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dc6f94e-c739-4fdf-8e43-4386d35e02e5@wanadoo.fr>

On Tue, Apr 08, 2025 at 10:23:53PM +0900, Vincent Mailhol wrote:
> On 08/04/2025 at 01:46, Kees Cook wrote:
> > On Sat, Mar 29, 2025 at 01:48:50AM +0900, Vincent Mailhol wrote:
> >> __BUILD_BUG_ON_ZERO_MSG(), as introduced in [1], makes it possible to
> >> do a static assertions in expressions. The direct benefit is to
> >> provide a meaningful error message instead of the cryptic negative
> >> bitfield size error message currently returned by BUILD_BUG_ON_ZERO():
> >>
> >>   ./include/linux/build_bug.h:16:51: error: negative width in bit-field '<anonymous>'
> >>      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> >>         |                                                   ^
> >>
> >> Get rid of BUILD_BUG_ON_ZERO()'s bitfield size hack. Instead rely on
> >> __BUILD_BUG_ON_ZERO_MSG() which in turn relies on C11's
> >> _Static_assert().
> >>
> >> Use some macro magic, similarly to static_assert(), to either use an
> >> optional error message provided by the user or, when omitted, to
> >> produce a default error message by stringifying the tested
> >> expression. With this, for example:
> >>
> >>   BUILD_BUG_ON_ZERO(1 > 0)
> >>
> >> would now throw:
> >>
> >>   ./include/linux/compiler.h:197:62: error: static assertion failed: "1 > 0 is true"
> > 
> > This is so much easier to read! Thanks for this. :)
> > 
> > If no one else snags it, I can take this via the hardening tree for
> > -next once -rc2 is released.
> 
> I discussed about this with Andrew by DM.
> 
> Andrew can pick it up but for the next-next release. That is to say,
> wait for [1] to be merged in v6.16 and then take it to target the v6.17
> merge windows.
> 
> If you can take it in your hardening-next tree and have it merged in
> v6.16, then this is convenient for me.
> 
> Just make sure that you send it to Linus after Yury's bitmap-for-next
> get merged: https://github.com/norov/linux/commits/bitmap-for-next/

Could this land via Yury's tree?

-- 
Kees Cook
