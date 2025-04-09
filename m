Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2C1259C;
	Wed,  9 Apr 2025 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744215300; cv=none; b=PQKhHnBj4q0M7DpbdwcN4yOxZjZA7eOCrRUhjMMET7GplW49RkFbaORrPjU61l7tLRvCKgSPSgfqQ1UDkM/dP+ncP8UGyZWZwrvh+AgwjGs5AtyPXfZOMttGA7X6oFyGso/QWzDd/qFt2ooO6OFakf55UreF61xJwrBicjqVSmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744215300; c=relaxed/simple;
	bh=GFhgPvjeV+4kxWhSShAi/VAKJZTLcNpslJPf5qiw/K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fg1CF/qDZbc2vH0UuDdWv/64TlsKNd//ENI86GIXJ8XZT+043ShPgfhYylCsLYb+Lh/GaLe/4w4qZ4UC3kSsUni8R6S4onuvHSQxpsAum8+4ZYIDcdjTRWsQ4tjCQd+MXVbIazBtfBewK4VrjtJZwNtVmqIGNrGF4KgOGhWNAto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OF0OEXQc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OF0OEXQc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA347C4CEE2;
	Wed,  9 Apr 2025 16:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744215299;
	bh=GFhgPvjeV+4kxWhSShAi/VAKJZTLcNpslJPf5qiw/K8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OF0OEXQcUT0pLP4/uoSEHSkPMIp/MtXq726IkvPUc672dL1SlJttj8vtOtyuNle8Q
	 dHnVY2tZqSBQ3kqZstj1jPckjVJ1NN+lRRUVmum7DT3UOIzKa0LpJNLPxv6sF0Edcb
	 h1V9RKvggw0a3qAg7G4C6ISb8wv35HfAgX6KWJifZ5qu8Nu0qliJK7N9soQRr1iVg/
	 8kgfKsCYKL4xYse7wcC7zjp4Du2zly4eWZOKpqZ4FP+p2OKs2Irru4pgege7wObNjO
	 Jg1RKKOGYLGox6w7tZTto8HcEj3TSflEcIC+xLMvjJbftTt+U6mHlkLhfdYxn64Wu1
	 5/yHBeADu5noA==
Date: Wed, 9 Apr 2025 09:14:56 -0700
From: Kees Cook <kees@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
Subject: Re: [PATCH v2] build_bug.h: more user friendly error messages in
 BUILD_BUG_ON_ZERO()
Message-ID: <202504090914.BC7A6BD89@keescook>
References: <20250329-build_bug-v2-1-1c831e5ddf89@wanadoo.fr>
 <202504070945.BAC93C0@keescook>
 <9dc6f94e-c739-4fdf-8e43-4386d35e02e5@wanadoo.fr>
 <202504081202.7CA5DBE@keescook>
 <4c01c2a6-5271-41e4-8013-836e59aeae6d@wanadoo.fr>
 <Z_aBjSP4WB062Ii9@yury>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_aBjSP4WB062Ii9@yury>

On Wed, Apr 09, 2025 at 10:17:49AM -0400, Yury Norov wrote:
> On Wed, Apr 09, 2025 at 09:26:41PM +0900, Vincent Mailhol wrote:
> > +To: Yury Norov
> > 
> > On 09/04/2025 at 04:03, Kees Cook wrote:
> > > On Tue, Apr 08, 2025 at 10:23:53PM +0900, Vincent Mailhol wrote:
> > >> On 08/04/2025 at 01:46, Kees Cook wrote:
> > >>> On Sat, Mar 29, 2025 at 01:48:50AM +0900, Vincent Mailhol wrote:
> > >>>> __BUILD_BUG_ON_ZERO_MSG(), as introduced in [1], makes it possible to
> > >>>> do a static assertions in expressions. The direct benefit is to
> > >>>> provide a meaningful error message instead of the cryptic negative
> > >>>> bitfield size error message currently returned by BUILD_BUG_ON_ZERO():
> > >>>>
> > >>>>   ./include/linux/build_bug.h:16:51: error: negative width in bit-field '<anonymous>'
> > >>>>      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> > >>>>         |                                                   ^
> > >>>>
> > >>>> Get rid of BUILD_BUG_ON_ZERO()'s bitfield size hack. Instead rely on
> > >>>> __BUILD_BUG_ON_ZERO_MSG() which in turn relies on C11's
> > >>>> _Static_assert().
> > >>>>
> > >>>> Use some macro magic, similarly to static_assert(), to either use an
> > >>>> optional error message provided by the user or, when omitted, to
> > >>>> produce a default error message by stringifying the tested
> > >>>> expression. With this, for example:
> > >>>>
> > >>>>   BUILD_BUG_ON_ZERO(1 > 0)
> > >>>>
> > >>>> would now throw:
> > >>>>
> > >>>>   ./include/linux/compiler.h:197:62: error: static assertion failed: "1 > 0 is true"
> > >>>
> > >>> This is so much easier to read! Thanks for this. :)
> > >>>
> > >>> If no one else snags it, I can take this via the hardening tree for
> > >>> -next once -rc2 is released.
> > >>
> > >> I discussed about this with Andrew by DM.
> > >>
> > >> Andrew can pick it up but for the next-next release. That is to say,
> > >> wait for [1] to be merged in v6.16 and then take it to target the v6.17
> > >> merge windows.
> > >>
> > >> If you can take it in your hardening-next tree and have it merged in
> > >> v6.16, then this is convenient for me.
> > >>
> > >> Just make sure that you send it to Linus after Yury's bitmap-for-next
> > >> get merged: https://github.com/norov/linux/commits/bitmap-for-next/
> > > 
> > > Could this land via Yury's tree?
> > 
> > Hi Yury,
> > 
> > I have this patch:
> > 
> > https://lore.kernel.org/all/20250329-build_bug-v2-1-1c831e5ddf89@wanadoo.fr/
> > 
> > which depends on commit b88937277df ("drm/i915: Convert REG_GENMASK*()
> > to fixed-width GENMASK_U*()") in your bitmap-for-next tree.
> > 
> > I discussed this with Andrew (by DM) and Kees. Because of the
> > dependency, it would be convenient if this patch went through your tree.
> > 
> > What do you think?
> 
> Sure, I can merge it. Please everyone send your tags before the end of
> week.

Thanks!

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
