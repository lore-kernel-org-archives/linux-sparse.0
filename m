Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0130D287268;
	Thu, 19 Feb 2026 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771520453; cv=none; b=Gh7kvwVnv/Ag+sGiAAksERSm8vPTw/5YXHIUTG/oovmOvBrAI5bG5E0Ix8KYdI5atMsTfDoppmzjVaZVEOAST8j7Kbz09hgw6Cv7HMLXH5uKM913jEVLNczBYKFoRIIQBUARyyu3xzCP6plxNpOD0TdMihyL585HA2Zz7Hi4Y6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771520453; c=relaxed/simple;
	bh=jTyHBqqXEcKEtopsua1iY7DytSLkpwKrXrn4CUuv8SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4tqbjjM7nECpaxwTkjeHydtEoxvcY9SZxJ7FWxt/dLeyym5xNF+hdYcbSSv6K7B8r2itTrU6Thd7SX/whk8KCWL12bky2MungXch6SbJ6A5UV77nhCgHFYpF4NSsA1qVdRhjLjkQ46gjoxsmbLmaB0K+igtTercOnIl0696yYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clavPsrq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clavPsrq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E61C4CEF7;
	Thu, 19 Feb 2026 17:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771520452;
	bh=jTyHBqqXEcKEtopsua1iY7DytSLkpwKrXrn4CUuv8SI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=clavPsrqbyCrka37XkhPrcXGn6/n7tADKPGzr3ZDTzLbXrB4G5Uc2CQ0XI679lPLz
	 zV7X8o2skq5FA+Qjd8SDukL8mn+sAIpw4aj7ifLac92MB2Vrs+X6Y7NfUD7T5itpro
	 I832kURNJ/U2XL8TqHZp7bNjrQs+aqVKrFiV4kX+fUPbjTF8o2iqjgUAp9HMkDGgns
	 9f8/VfS256dgKP0FqBeBkNbe+641tbHwU62CiWqjQgYFCAKdBTtsHEnDlbTEynHrv1
	 fYw96q5MU7KutEM581TG0a9LbRgIgeB5C227LG3JL3mjL3aphQc+j9OynIw0IUuG4j
	 xtlMY2JPU3ivA==
Date: Thu, 19 Feb 2026 18:00:48 +0100
From: Daniel Gomez <da.gomez@kernel.org>
To: Chris Li <sparse@chrisli.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Sami Tolvanen <samitolvanen@google.com>
Cc: linux-sparse@vger.kernel.org, Aaron Tomlin <atomlin@atomlin.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] builtin: mark __builtin_strlen() as integer constant
 expression
Message-ID: <aZdAxZR-c8PY_uEL@macos>
References: <20260219-fix-builtin-strlen-v1-1-3ec3efc0cda7@samsung.com>
 <CABCJKuf8jh_yxQcR1=uMeuWOueXyoM5=L-QpTuBenRi_MZK_Gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABCJKuf8jh_yxQcR1=uMeuWOueXyoM5=L-QpTuBenRi_MZK_Gg@mail.gmail.com>

On 2026-02-19 08:41, Sami Tolvanen wrote:
> Hi Daniel,
> 
> On Thu, Feb 19, 2026 at 8:11 AM Daniel Gomez <da.gomez@kernel.org> wrote:
> >
> > From: Daniel Gomez <da.gomez@samsung.com>
> >
> > Commit ae83f3b72621 ("module: Add compile-time check for embedded
> > NUL characters") in the Linux kernel added static assert checks for
> > __builtin_strlen() inside MODULE_INFO() macros. But sparse does not mark
> > the result as CEF_SET_ICE during evaluation, making these assertions
> > fail with:
> >
> >     error: static assertion failed: "MODULE_INFO(...) contains embedded
> >     NUL byte"
> >
> > Fix by marking __builtin_strlen() as an integer constant expression at
> > eval time. This matches other builtins like __builtin_constant_p() or
> > __builtin_safe_p().
> >
> > Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> > ---
> > Discussion:
> > https://lore.kernel.org/all/aTc9s210am0YqMV4@agluck-desk3/
> 
> It looks like Al had a more complete fix for this issue, but I guess
> it never ended up in the sparse repo?
> 
> https://lore.kernel.org/all/aUV7kyjxlijuy5sC@agluck-desk3/
> 
> Sami

Chris, Al,

Can you please take a look? If Al patch is the correct approach, any
chance you can send it and fix this?
