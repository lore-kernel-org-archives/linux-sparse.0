Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E71929E0F8
	for <linux-sparse@vger.kernel.org>; Wed, 25 Feb 2026 07:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772004300; cv=none; b=A5a5aiFPPIMXxumUERe/67mmuuulPfUHLIXi4ZXd/65ZqZj8oHxEWlljY58KupvfCXCUm+xtHg/WYdOr5bMesIIyXOswVzc5TWJiw+cT9dH963hShTkXqWBJoi4VF80c7r9I7K7J94XFrwUf8DTbPhq3QSkIDBiGfcrM4cX/cw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772004300; c=relaxed/simple;
	bh=Oqi5DG4r61vuh1reHl/LBnFsVRHS2pdWORvLAyFr4Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZUL850xmUX/VmdS8kpaZ/YayQJH0NpfbmwUol6DnTOktgq6pNsjSG9iRJsrAaAHK1QB+arye/TbKHgTXn2rfK2zM4Cf8yM9a5aMO4RP/RfkoJrSZ5mx9Cpm68geVao4LRYAjtOBoKU1Fa1r4C2iwdSrcxaKDE70bpzzsH24ugU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=a4BFuDnG; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="a4BFuDnG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sm2KoQtCmW31q0nIJcEzaVLgwCQ1N3kX0W++tvjDtP0=; b=a4BFuDnGok75CQNjR+8RfzGyVv
	2/t+eb7y7EBXOmXJTA/pydRxFtJusC4F9S+65sGOZL413VE4ebmX4cn11cMHM/ipxx0wBJILAjPD4
	zJRz5JobmweAt4MGuyso1PDZOKEALx/sq73PSjGZyIwdhvZRRtDbdutBpQ/j+lmt4gXGegO5sCwWl
	SkRb5ZF+mMo0Lh2zGlE030DEUd2CYUAXOur0LsQYy97KmCR3xz1KIgvwCZfkbhGm0FnqndteoB2Y7
	5W6fB6GDBeSfKl0kxDetf1LH2JY53704tB7LwsXouZWrLvLDi1ic59sAcuNwiIJR0eoQRplVPlyBI
	Kgzvwpbw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vv9Ix-0000000Czw3-2T23;
	Wed, 25 Feb 2026 07:27:31 +0000
Date: Wed, 25 Feb 2026 07:27:31 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Eric Zhang <zxh@xh-zhang.com>
Cc: linux-sparse@vger.kernel.org, dan.carpenter@linaro.org,
	chriscli@google.com, ben.dooks@codethink.co.uk,
	rf@opensource.cirrus.com, torvalds@linux-foundation.org
Subject: Re: [RFC PATCH] pre-process: add __VA_OPT__ support
Message-ID: <20260225072731.GA3093958@ZenIV>
References: <20260225033639.GA2924820@ZenIV>
 <20260225052950.2444262-1-zxh@xh-zhang.com>
 <20260225064003.GD1762976@ZenIV>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225064003.GD1762976@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Feb 25, 2026 at 06:40:03AM +0000, Al Viro wrote:
> On Tue, Feb 24, 2026 at 09:29:50PM -0800, Eric Zhang wrote:
> > Add __VA_OPT__ support (C23 6.10.5) including some tests.
> > 
> > At expansion time, substitute() checks whether the variadic
> > argument is empty: if so, skip the region between the markers;
> > otherwise, process the enclosed tokens normally.
> > 
> > Signed-off-by: Eric Zhang <zxh@xh-zhang.com>
> > ---
> > Discussed this with Chris during lunch yesterday and got curious
> > about the problem, so made a few attempts.  Introducing
> > TOKEN_VA_OPT_START/END feels a bit like an anti-pattern, but I
> > couldn't find a cleaner way to handle it without new token types.
> > Happy to hear suggestions.
> 
> Your variant will break with __VA_OPT__ following #.  It won't do the
> right thing with ## either, AFAICS, in case when __VA_OPT__ token list
> is empty.

Another problem is that having no __VA_ARGS__ in the body should *not*
be treated as "vararg is empty" - if there's a __VA_OPT__ in the body,
you must expand the vararg, no matter what.
