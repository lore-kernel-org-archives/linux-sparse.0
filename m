Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8974F2D6409
	for <linux-sparse@vger.kernel.org>; Wed, 25 Feb 2026 06:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772001453; cv=none; b=ed4oPIZssLtDvqk8a0pAq05FCBgE7YnebKBUjDrZFf7zJ21Ppf6ti65FU/Toh9k3KBk3YWCr/+9wL6vjXu6Z8EnYJ9fa6KcAmHGJOPT85ReIg9r8meV8bn3D/nZFM3x+v7AGh27B6tpoRmz5k46NmW9eGpekMpwsqm311c5ppX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772001453; c=relaxed/simple;
	bh=Ry9xIKoEeO89/INo6kK/1jFg9yU1cvUa9h3W5KtbeFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FadIKgPD8Mo7pOvx/iTvyJKN1OaKVQpjWfIsT24/TGMrPW/EEs7MWp6TRdauSzcsouk4PTN++MvVHVg0lSw5xiVUJE3WDB9DBHq5gPfUB0y3PvEW8IO0c/pTr7OWPAvUgPLriHav66cpAB5XCrTU+JJS1f4PRM2bZvy5hBu8/Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=avIPLZWN; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="avIPLZWN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aSPsNZTlQlQ1hYj163I7HAukG3MPg51nPgwW76lz+qk=; b=avIPLZWN5VFmnIQ59GdF4wINeQ
	dGeggTSKYksEJFxFTFv4+orQUn33+7aVL5tIxRojtL4f3x394YjREz6BUYJ4Y1rojjVLUoENTqtt3
	rccE8HdyT1YXOMHQklDuhoIrQalq92K7rPqJdMXen5rQhg7VJcuXdUfjfYeIgrfgHhZEj+40/PiDP
	KdT0n/QOh1f7MecOMC2X3pD3SyUJVrFiAsnH7GTRqM1X21JSAy0fXOJ4QElRdy4aGBX6tZaYBaDLx
	VmgskzB2tQAa/ARfZCQJmnex4HAcb/QppGCaQIPtbjS1zJNZpOuFLrOyyJd8tFOJo3E/f77k4K2Gw
	yuN2H26g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vv8Z1-0000000Cxdu-1VeU;
	Wed, 25 Feb 2026 06:40:03 +0000
Date: Wed, 25 Feb 2026 06:40:03 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Eric Zhang <zxh@xh-zhang.com>
Cc: linux-sparse@vger.kernel.org, dan.carpenter@linaro.org,
	chriscli@google.com, ben.dooks@codethink.co.uk,
	rf@opensource.cirrus.com, torvalds@linux-foundation.org
Subject: Re: [RFC PATCH] pre-process: add __VA_OPT__ support
Message-ID: <20260225064003.GD1762976@ZenIV>
References: <20260225033639.GA2924820@ZenIV>
 <20260225052950.2444262-1-zxh@xh-zhang.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225052950.2444262-1-zxh@xh-zhang.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Feb 24, 2026 at 09:29:50PM -0800, Eric Zhang wrote:
> Add __VA_OPT__ support (C23 6.10.5) including some tests.
> 
> At expansion time, substitute() checks whether the variadic
> argument is empty: if so, skip the region between the markers;
> otherwise, process the enclosed tokens normally.
> 
> Signed-off-by: Eric Zhang <zxh@xh-zhang.com>
> ---
> Discussed this with Chris during lunch yesterday and got curious
> about the problem, so made a few attempts.  Introducing
> TOKEN_VA_OPT_START/END feels a bit like an anti-pattern, but I
> couldn't find a cleaner way to handle it without new token types.
> Happy to hear suggestions.

Your variant will break with __VA_OPT__ following #.  It won't do the
right thing with ## either, AFAICS, in case when __VA_OPT__ token list
is empty.
