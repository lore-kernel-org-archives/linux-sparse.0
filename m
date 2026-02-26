Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C0D389DEC
	for <linux-sparse@vger.kernel.org>; Thu, 26 Feb 2026 07:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772090834; cv=none; b=N3YMDJDIH4saYUwXG5xpcgoxaKFJdaiAQjh3SkrYJRS1w59deLx7mXMSuIOZwBITIxnVtoA4GNBt7Mr1gDbsRT8e+CArZ8LttoXhw/vhhyrhCNFJFdZhsOJccMZolf6u1zH9Acfi2Yku+smYNyb957yLATeYQEJbQmLbHO3Wtnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772090834; c=relaxed/simple;
	bh=2mh/PsVFkt5OYV2ariuVhVfRXvIFz+rcQax7r3tehYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIe2TmPqlud/jbsi7Mj+BOdZyfGeDoMKYR7H6s/pZZxk9lpRMqYFWXrG90DJf9a6SX5S1SuPZyy3bukjilO/xtG+buwX44k7waJ8U2xHZU1f1rSzWMmyDEOKxhsyE68DIyGDmzCc/aRIhhrauvYEZ5PHApvkiSFOliPzCGYmJUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RRuIibCv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RRuIibCv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cWRenWbkNvjJyBYkgfFXf0kgQ/OAx56Il7tV0me7JD8=; b=RRuIibCvHDELZhd8suSh7lFIL2
	xeV+ErVj28zjZBv6G1iduw8mBwBgatblOK4rMOeVmbGWCAMYFMNey8/0ADcaVDScsRw/74rjbc25r
	iZLcqDtKM6HmY9Ggh6jyf2zTUCJ4bS8999H3nQ4e4BP7Ovjq5wbtyZ6sNjZl8BQoVAg4KMeKjV7ic
	T4093+YE7dW80ahg1xluC/+t4Zw6m5kBZxH4mGc++QpXdte0g9NN/HrQ5pmKpIXVA//r00nC2VQAM
	0rPq3C+yT3rFoDZlNtcP21Svu5+kkXPDn/ggqo/31g62LEqbG4WgK/+YFxEYNS+0lsw3jmYTbm9Vf
	OAun7JFQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vvVof-0000000HP3g-3aD3;
	Thu, 26 Feb 2026 07:29:45 +0000
Date: Thu, 26 Feb 2026 07:29:45 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Eric Zhang <zxh@xh-zhang.com>
Cc: linux-sparse@vger.kernel.org, dan.carpenter@linaro.org,
	chriscli@google.com, ben.dooks@codethink.co.uk,
	rf@opensource.cirrus.com, torvalds@linux-foundation.org
Subject: Re: [RFC PATCH] pre-process: add __VA_OPT__ support
Message-ID: <20260226072945.GA4104757@ZenIV>
References: <20260225072731.GA3093958@ZenIV>
 <20260225081413.2480484-1-zxh@xh-zhang.com>
 <20260225221851.GE1762976@ZenIV>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225221851.GE1762976@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Feb 25, 2026 at 10:18:51PM +0000, Al Viro wrote:

> NOTE: substitute() is the second hottest loop in the entire thing; only
> tokenizer is hotter.  And gcc is too enthusiastic about the inlining
> around that function, ending up with bad register spills, along with
> a bunch of stalls.  Worse, decisions are sensitive to minor changes in
> places textually far away, making it a real bitch to deal with.
> Makes for fun reordering the commits in local queue... ;-/

FWIW, looking at that thing again, I wonder if we would be better off
with doing argument expansion on demand rather than doing it in
expand_arguments().  Should be doable with a bit of care - we'd need
to mark the TOKEN_..._ARG with several bits to decide whether we
want to duplicate or not, etc., but that's worth doing anyway -
better than playing with the counters.

Note, BTW, that collapsing TOKEN_..._ARG together, with "kind of argument"
moved into bits stolen from ->argnum improves code generation - that
switch by token type is _hot_ and it reducing the number of cases
gives a measurable speedup.  Sure, we don't want heavy work at #define
time - most of the macros are never expanded at all, but AFAICS this
kind of processing can be dealt with while parsing the body, with no
extra passes needed, etc.

I'm going down right now, will look into that tomorrow morning...
