Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D20A16EB4C;
	Mon, 17 Feb 2025 11:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739790920; cv=none; b=CeRHVXOE/0KlZXC1OnaG7Rmn3ByS9lX2Mda6ZpLUjkVP/31+qEUohLtILpe6HkFWTehhehEpdgL10BE0qu2bDZ/K9dMP4gaAmHWWrrV5PsCx8R598N3x/RkLtmU5ha7Fl/dnPOQG/wOufQUtMEIZvrIhsrlADQpX0uGxsrtP6ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739790920; c=relaxed/simple;
	bh=Hpg7QZjmh8wobkYw4CjDEQSIkL1AyleueMoYw/RF8Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UoBKJdXwBGdd3xlxWLppcJOtPfNS/LFyVlk6VgbWMPT9rrJwrYGpdetcUGkklDZR/hKYyzOS3v94xo4SPdvnAenCVR2L8ARq+2HAB5RJnucFJUhjifcZbqrAY9pZzmveQ0qAezSQAd+99GDDlA7NchcOhUlXDtsboamxwV2r7/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLlSIDOK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLlSIDOK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8DDC4CED1;
	Mon, 17 Feb 2025 11:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739790919;
	bh=Hpg7QZjmh8wobkYw4CjDEQSIkL1AyleueMoYw/RF8Yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RLlSIDOKcqigbaFLj3a6Fl5sYLw15vVDUiiniVWh6MnjT6Px4sQqOeiBhp1qCPUMA
	 foTA5x2qKNeHnVjSUZbyAN7oYutOW5kMzw/1nDM1k9Ko7afBwTxmOKXAYOoV2JWH11
	 NV76P6+GghbSgLCBn7TF82g0h7CkLjoPSnZ0FP1EUIWYpvd8w1zutYlwEBFAihuE8g
	 7HyHiUIBAwU8miq7u6PBs2HskmthdEdKoxYPHkRSN/sDqrfKyCeOa83zBQmhVT1Fdx
	 186o0TAxfY1Uy/9WSyvK6BjyepmwQfgJ5V7VbA1b0mlt01Eaq95o5r3JXERynrGZN0
	 r9ykfIYdOIv3A==
Date: Mon, 17 Feb 2025 11:15:15 +0000
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
Message-ID: <20250217111515.GI1615191@kernel.org>
References: <20250210075006.9126-1-purvayeshi550@gmail.com>
 <20250215172440.GS1615191@kernel.org>
 <4fbba9c0-1802-43ec-99c4-e456b38b6ffd@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fbba9c0-1802-43ec-99c4-e456b38b6ffd@stanley.mountain>

On Sun, Feb 16, 2025 at 10:33:38PM +0300, Dan Carpenter wrote:
> I've added the linux-sparse@vger.kernel.org mailing list to the CC.
> 
> On Sat, Feb 15, 2025 at 05:24:40PM +0000, Simon Horman wrote:
> > My understanding is that the two static analysis tools under discussion
> > are Smatch and Sparse, where AFAIK Smatch is a fork of Sparse.
> > 
> > Without this patch, when checking af_unix.c, both Smatch and Sparse report
> > (only):
> > 
> >  .../af_unix.c:1511:9: error: undefined identifier 'other'
> >  .../af_unix.c:1511:9: error: undefined identifier 'other'
> >  .../af_unix.c:1511:9: error: undefined identifier 'other'
> >  .../af_unix.c:1511:9: error: undefined identifier 'other'
> > 
> 
> Smatch isn't a fork of Sparse, it uses Sparse as a C front-end.

Sorry for my mistake there.

> This warning is really from Sparse, not Smatch.  The warning started
> when we changed the definition of unix_sk() in commit b064ba9c3cfa
> ("af_unix: preserve const qualifier in unix_sk()").
> 
> Smatch doesn't actually use these locking annotations at all.  Instead,
> Smatch has a giant table with all the locks listed.
> https://github.com/error27/smatch/blob/master/smatch_locking.c
> Smatch uses the cross function database for this as well if it's
> available.
> 
> Unfortunately, Smatch does not parse the unix_wait_for_peer() function
> correctly.  It sees that something is unlocked but it can't figure out
> what.  I believe the problem is that Smatch doesn't parse
> container_of_const().  Fixing that has been on my TODO list for a while.
> The caller used unix_state_lock() to take the lock and that has a
> unix_sk() in it as well.  So smatch doesn't see this lock at all that's
> why it doesn't print a warning.

So, hypothetically, Smatch could be enhanced and there wouldn't be any
locking warnings with this patch applied?

> 
> regards,
> dan carpenter
> 
> > Without this patch, when checking af_unix.c, both Smatch and Sparse report
> > (only):
> > 
> >  .../af_unix.c:1511:9: error: undefined identifier 'other'
> >  .../af_unix.c:1511:9: error: undefined identifier 'other'
> >  .../af_unix.c:1511:9: error: undefined identifier 'other'
> >  .../af_unix.c:1511:9: error: undefined identifier 'other'
> > 
> > And with either v1 or v2 of this patch applied Smatch reports nothing.
> > While Sparse reports:
> > 
> >  .../af_unix.c:234:13: warning: context imbalance in 'unix_table_double_lock' - wrong count at exit
> >  .../af_unix.c:253:28: warning: context imbalance in 'unix_table_double_unlock' - unexpected unlock
> >  .../af_unix.c:1386:13: warning: context imbalance in 'unix_state_double_lock' - wrong count at exit
> >  .../af_unix.c:1403:17: warning: context imbalance in 'unix_state_double_unlock' - unexpected unlock
> >  .../af_unix.c:2089:25: warning: context imbalance in 'unix_dgram_sendmsg' - unexpected unlock
> >  .../af_unix.c:3335:20: warning: context imbalance in 'unix_get_first' - wrong count at exit
> >  .../af_unix.c:3366:34: warning: context imbalance in 'unix_get_next' - unexpected unlock
> >  .../af_unix.c:3396:42: warning: context imbalance in 'unix_seq_stop' - unexpected unlock
> >  .../af_unix.c:3499:34: warning: context imbalance in 'bpf_iter_unix_hold_batch' - unexpected unlock
> > 
> > TBH, I'm unsure which is worse. Nor how to improve things.
