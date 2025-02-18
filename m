Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D8426770D;
	Tue, 18 Feb 2025 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739884888; cv=none; b=g8ijM5FUjUtC7n5HAnA02cRO+oAzhCtfmSvjZAtwbXZp59EPuxqyZ3OtFbTZAY86YXI47gZXGZJJj9J/c2I/Jxpu7n+aCuqh4NiDvLEZkgix1f42EBOo1XUDIdsNzhpPMfmagNwPNrCD2boPYgKuS5R2VZR+RSQ7gxGz0MMrsu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739884888; c=relaxed/simple;
	bh=g0p4ztj3j9EdFIQHmS4Ci7FELv3r1tJrkUHQnoz7tOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNOQ0uf5uR6VBmAJvI0HvuAIs34JCEl83YHjrGiJgsOG8tFpf113CqkVatxH85kdHjbVjcxtLKJfRZDSgsV1V8qOKFKKDhGvADUy3jAHR7Tl0/zOiMbiAlNwMVyKJFOPJTG+PEMtqIHfzsPFInlyqwj+6qvS7Ank/zE2lO3kex4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqwTfOfO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqwTfOfO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C89C4CEE6;
	Tue, 18 Feb 2025 13:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739884888;
	bh=g0p4ztj3j9EdFIQHmS4Ci7FELv3r1tJrkUHQnoz7tOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gqwTfOfORw1x/FZ5qPJzTkFGqb396tnZPN3eXPwpnvgWxSePaVdnYfU9EgfaJhnaL
	 cDmaNLb5vsde/zNBaIQeXoFAZyk3EMTj2+CxMenx/xddWWTNC7cHZVTOu4C8ucuKbG
	 6RRLXNqP4JQn7QS60bjeX6ObTemNhl/NU3Ic9kh20StEQb1lkJFO1U65XBmZpc/LFh
	 ZVGu0KVzEnl1rIRnkw72PTVaRc6+g/ajlfoEBTAbRGD5xejZO8Nqp3KJt5SPPiTznu
	 PYDYqMOp87SJfN6vk5ZrBrrQApbJA/FZr3kwd0/Q5gWl+0I4gVgF4VoLvLTSZPsogF
	 QQiPjdmEWEzJQ==
Date: Tue, 18 Feb 2025 13:21:23 +0000
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Purva Yeshi <purvayeshi550@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	skhan@linuxfoundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
	linux-sparse@vger.kernel.org
Subject: Re: [PATCH net-next v2] af_unix: Fix undefined 'other' error
Message-ID: <20250218132123.GT1615191@kernel.org>
References: <20250210075006.9126-1-purvayeshi550@gmail.com>
 <20250215172440.GS1615191@kernel.org>
 <4fbba9c0-1802-43ec-99c4-e456b38b6ffd@stanley.mountain>
 <20250217111515.GI1615191@kernel.org>
 <bbf51850-814a-4a30-8165-625d88f221a5@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbf51850-814a-4a30-8165-625d88f221a5@stanley.mountain>

On Mon, Feb 17, 2025 at 05:14:14PM +0300, Dan Carpenter wrote:
> On Mon, Feb 17, 2025 at 11:15:15AM +0000, Simon Horman wrote:
> > So, hypothetically, Smatch could be enhanced and there wouldn't be any
> > locking warnings with this patch applied?
> 
> Heh.  No.  What I meant to say was that none of this has anything to do
> with Smatch.  This is all Sparse stuff.  But also I see now that my email
> was wrong...
> 
> What happened is that we changed unix_sk() and that meant Sparse couldn't
> parse the annotations and prints "error: undefined identifier 'other'".
> The error disables Sparse checking for the file.
> 
> When we fix the error then the checking is enabled again.  The v1 patch
> which changes the annotation is better than the v2 patch because then
> it's 9 warnings vs 11 warnings.
> 
> The warnings are all false positives.  All old warnings are false
> positives.  And again, these are all Sparse warnings, not Smatch.  Smatch
> doesn't care about annotations.  Smatch has different bugs completely.
> ;)

Thanks for clarifying :)

Based on the above I'd advocate accepting the code changes in v2 [*].
And live with the warnings.

Which I think is to say that Iwashima-san was right all along.

Reviewed-by: Simon Horman <horms@kernel.org>

[*] Purva, please post a v3 that updates the commit message as per
    Jakub's request elsewhere in this thread:
    https://lore.kernel.org/all/20250212104845.2396abcf@kernel.org/

