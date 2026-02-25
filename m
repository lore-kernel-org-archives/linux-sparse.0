Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6034C156F45
	for <linux-sparse@vger.kernel.org>; Wed, 25 Feb 2026 22:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772057780; cv=none; b=pSDj5fC2KIcJ4s7tuIk1w6Ft1AkOKvs/laSW2ns2A4idieZI+Ir8bTSISSwvXF+yG2VVJ/WfQ9MGFtfzPwTG3sP/iwq23x8tzbqkXAyBkXbYXoFUEVNKCzvhaQ3ZWL8yoT18kLtnpn35WeOicuLgpbBtFrKoc+xEyGpNxNrm0p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772057780; c=relaxed/simple;
	bh=/l+rBO1GuQ2V4BNzJHXe5QbkJbodhqC+fF1WNQ44fyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfBDXDSOrGkb9BHU/fKNMGSRwKKtRlRrYAllgZSJZlaajf6V/9cVBz305gxZ/33l34hFP1Lb8dx8AepMnde5ezTgZAYZuD1xVCQflT40elXkiYOxgJwC4n8PKBpQRCa3bxYbFOu+vjP3J913tqqdgiddf1Dj0Slqie8VIAOEpUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tFBuDM3u; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="tFBuDM3u"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=b+uYMn4H2eTp12dlD8rqgCDax1QcKKCMow6DiZp9C9o=; b=tFBuDM3uPXelG6kC9N5ZdypUti
	llD4uZln9XcGwj0GGPKvee6cS0/8Zh4NL65dTD+XZmu2vaPfPA14FITHAZmn74acL9XoexTwggXsW
	G/XvIQIV+IrMqF8t7e1soJBk47DfGPQ5wErRxPz3+2qWaoVAIAlynqL9BTcAz2YzOcqyJ5obaUzVm
	NxPJpvZo/fkb9HeoiTM+q8J/a0EQOhm3bqy7tjkh1+UXH0yKrLIYwM/V9U+kHB5qYYCBxASWKpOZi
	U5F451pJ7lGgDC78me/aB1BQWavS/Gj5yigKu59BuZaFdpV/4LFXX0HTHcTCplf4RHUpoF98LhguB
	I2kQGzTA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vvNDX-0000000FNhy-1Rpt;
	Wed, 25 Feb 2026 22:18:51 +0000
Date: Wed, 25 Feb 2026 22:18:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Eric Zhang <zxh@xh-zhang.com>
Cc: linux-sparse@vger.kernel.org, dan.carpenter@linaro.org,
	chriscli@google.com, ben.dooks@codethink.co.uk,
	rf@opensource.cirrus.com, torvalds@linux-foundation.org
Subject: Re: [RFC PATCH] pre-process: add __VA_OPT__ support
Message-ID: <20260225221851.GE1762976@ZenIV>
References: <20260225072731.GA3093958@ZenIV>
 <20260225081413.2480484-1-zxh@xh-zhang.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225081413.2480484-1-zxh@xh-zhang.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Feb 25, 2026 at 12:14:12AM -0800, Eric Zhang wrote:

> For # __VA_OPT__(), a stringify flag on TOKEN_VA_OPT_START could
> signal substitute() to stringify or produce "" depending on whether
> varargs are empty.

IMO it's better to turn that into
	TOKEN_VA_OPT[<token-list>]
and
	TOKEN_QUOTED_VA_OPT[<token-list>]
with list hanging off the cannibalized token.  Interpreter (substitute())
can easily keep track of where it is.

FWIW, the way they patched __VA_OPT__ into 10.5.1 is unfortunate -
I can understand wanting to keep the changes localized, but it ends
up very convoluted ;-/  In part it's due to the way ## and # evaluation
order is left unspecified, but... ouch.

Basically, #__VA_OPT__(<token-list>) is treated the following way:
it's "" if va-opt is suppressed, otherwise we
	* do argument substitution in <token-list>
	* [unspecified, but everyone does that] process # and ##
in the token-list.
	* do *NOT* remove placemaker tokens
	* do *NOT* rescan
	* stringify the resulting token list, same way we would if
that token list had been passed as an argument and we were processing
#<that argument> (as per 6.10.5.2[3]).

## vs. __VA_OPT__ is similar; the tricky part is placemaker treatment.
For normal arguments it's either a non-empty list or a solitary placemaker;
here we might have placemakers with non-empty list.

#define F1(X, Y, ...) Y ## __VA_OPT__(X X) ## Y
#define F2(X, Y, ...) Y ## __VA_OPT__(X) ## Y
F1(,a,_)
F2(,a,_)

We get a ## placemaker placemaker ## a (i.e. a a) or a ## placemaker
## a (i.e. aa) respectively.  Approach without explicit ## tokens
at expansion time is easy to adapt to that - we just interpret the
translated token-list hanging off __VA_OPT__, then return to the rest
of the body; state is updated as usual.  Quoted __VA_OPT__ == run the
interpreter (starting from Normal) on the token-list, then feed that
to stringify() and use the result as if it came from quoted argument
(note that concatenation with previous token *is* possible -
L ## #__VA_OPT__(something) is not invalid).

Since __VA_OPT__ can't nest, it's easy to save the body->next into a
local variable, set body to body->va_opt_list and, after the main loop
check if that local variable is non-NULL.  In that case we just set body
to that, clear that variable and go back to the beginning of the loop.
Quoted ones get a recursive call...

NOTE: substitute() is the second hottest loop in the entire thing; only
tokenizer is hotter.  And gcc is too enthusiastic about the inlining
around that function, ending up with bad register spills, along with
a bunch of stalls.  Worse, decisions are sensitive to minor changes in
places textually far away, making it a real bitch to deal with.
Makes for fun reordering the commits in local queue... ;-/

> > Another problem is that having no __VA_ARGS__ in the body should
> > *not* be treated as "vararg is empty"
> 
> Missed in the test case, but it seems like it can work in the current
> version.

AFAICS you won't even try to expand it at expand_arguments(), so the
reference will remain NULL.
