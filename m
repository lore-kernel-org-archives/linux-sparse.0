Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CECB79CD
	for <linux-sparse@vger.kernel.org>; Wed, 25 Feb 2026 03:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771991353; cv=none; b=nFeGHW22aYcaIBbXXMjOS5icbzU/V7ZekpiBgWkwxN/Om9RtZ6ZRTJW13WB/f6VWAHoOxtFwMoIxKR6TYR20l+HFbuKYnMNVq7zFPf/VLXYwSidb1ZMSy3+OXwNVkSBPcsmFHguVl40fM8VAsVPH1RcKxdCTV8UdDI/Uiyz5hJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771991353; c=relaxed/simple;
	bh=10uQf+A+ararwghYgsf4shGlB3MmV/GhkOSh1YqLGiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdAIjLhQwo9zBiIrrm/EeuvPSWaVZTTunOhDRvkfyuxBH9it5dknX6XDpkXsnEL4ucpaoCdJATo4MxKvPg+hSmgYhxnUxZWGe1uWxQEnM7Bs8nVnzHasiE6tLeJrxHCYQHVhx7DqTVDkCXA2GwaKLuCmM3tgP02QZkgeRLjcQcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=c3jXb3Np; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="c3jXb3Np"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ykb1AIsVhEGRGvO8PxYenoUo3E+IYdtZj5KjDerj68I=; b=c3jXb3NpV9u8vxwETLBtFoanVj
	zkYGRZlo/a3uUvTvoZvfv7GXOYGxt0Duhwl9hjmTCNgUaZwfQKnSXMDepzP8rDb+Ic1Y7JIdtyPdc
	YI01dPQx/0WOeZ2eFzv28BB8m4fhz+vmVb03YPKlMIpzMW6V9hXs6bvY8lZa2Fr/v6pvpC9xDhUWC
	Rm/DjAtbyTzDN7/EPx2OAj8VKuP+19rfRAtSZ07sbgVQ/4s1LSqY0vMl8fp492qMkj851eCVBuaV5
	KFVlReA3pSeBdrkmLHDyvTlhY8EJrqyMYLOqZNPSipVFC4eFoIbAiKvqkFN0S0soiEtHJVhUOXXzi
	//+mxDGQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vv5w8-0000000CJYk-0iM1;
	Wed, 25 Feb 2026 03:51:44 +0000
Date: Wed, 25 Feb 2026 03:51:44 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ricardo Ribalda <ribalda@chromium.org>, linux-sparse@vger.kernel.org,
	Chris Li <chriscli@google.com>, Hans Verkuil <hverkuil@kernel.org>
Subject: Re: Sparse not supporting kzalloc_obj() and friends
Message-ID: <20260225035144.GB2924820@ZenIV>
References: <CANiDSCuKGUNdT4f9tOuohe2wZeP4MmooJAJn2Q=oyAWL4v9Lng@mail.gmail.com>
 <CAHk-=wgxgo8SugrnA4s=Pz0TPj32Ea0pdO=uU_N+-V6Y826spg@mail.gmail.com>
 <CAHk-=whTb01surrXakL7rgyoELuPDkqvTdh_ttNrr5rtirwopQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whTb01surrXakL7rgyoELuPDkqvTdh_ttNrr5rtirwopQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Feb 23, 2026 at 08:35:40AM -0800, Linus Torvalds wrote:

> instead, with a dummy empty argument to make the gcc ## trick work.
> It's smaller and denser, so it's actually superior in that sense, even
> if it feels a bit less natural than the __VA_OPT__ model.
> 
> Ricardo, can you verify that that trick works for you?
> 
> Al, comments?

I'll resurrect that branch and post it - hopefully would get something
usable by the weekend.  The main stumbling point had been getting
the interplay with side effects of expansion right - both the __COUNTER__
mess (gccism, with nothing resembling a clear semantics) *and*
the possibility of failure in expansion that had been attempted for no
reason.  Example of the latter:

#define A(X) X
#define B A(
#define Z(X,...) __VA_OPT__(X)
Z(B)

Use of Z obviously has empty vararg (not just after expansion - there's
nothing to expand).  So that __VA_OPT__(X) in its body should be
expanded to an empty token list, _without_ ever expanding the token
list (X) under __VA_OPT__.

Attempt to expand it would fail - it gets to A(, i.e. to use of
a function-like macro with unterminated argument list.

C23 is pretty clear about *not* trying to expand X in that example;
clang handles it correctly, gcc fails.  Reported to gcc bugzilla,
got pretty much no response, then got sidetracked ;-/
