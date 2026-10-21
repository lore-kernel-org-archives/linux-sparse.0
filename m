Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.62.254.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792588929;
	b=UvkBpZMC4ZZOSCcf6toeHVvT5CM390mO6PDhwsoXHTpHBIMNxLzqBe7YHcaF91ElTeoU
	 TB5MgEQGJkeF4SuQAeBoenFmwDFVbx5XlRStV9Qq1p6n/RBbtIYS194B5BjsKjvxWBun9
	 ZG4fj7kYBwg6f1+wEtWmjuNLTtwUqzJOg7nJS1/92y7HsnVNoOAKON55gG7TpddTlgV96
	 GWJ93c+MWCMN14vKRdtOPyS6zuz54FuBEI8tzlQ9bx4KKACYgGk028kMikxH+WV9VO+ts
	 kYf72aVOABeL/pd7ufKeGhe1DwY6mLZlfpmEdGo91wAAhqTX5pWlS7xFLOxFpDbPGLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588929;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=65N90uPbM/sdMt8va6PqR38knOi26pRgfR4jLxN0nvk=;
	b=CsK0Ibt46gj0SeYEWRD9TRRkcdxczqdXYC64aukjVXhDL6LieiKkERZlNoFdW3YAu1DG
	 CiQ6+plEB5daBGUfcSnf7jLOQrCufox7oJwUD45ilfOot2L+GzqyErXo0uimY7msQzdbR
	 jn7CBVZ7/jhCXux0Kg4s4Ypi9CfRU2EQOAFSkfjclakhIqExXqdyJkc44l+huUB6OHgzR
	 Echx423gA0o6KwYqjfdCMzaijv255F2n0PPuMkd8KcOIilFcgSToTJdB0E/glfIMsvHzd
	 9ytzHYy5LOU57CXgl8FOIm9PhKCqF5qp+ppn+7IxL9q8aETyBxJSpekPiKt5LXC4+Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ilvokhin.com;
	spf=pass smtp.mailfrom=ilvokhin.com;
	dkim=pass header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=UixTt+x9;
	arc=none smtp.remote-ip=178.62.254.231
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21062606A31B
	for <linux-sparse@vger.kernel.org>; Wed, 21 Oct 2026 13:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21062606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=UixTt+x9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1792588927;
	bh=65N90uPbM/sdMt8va6PqR38knOi26pRgfR4jLxN0nvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UixTt+x9fMWQonWdwqfejMalpW1YMzckC1lRc4Wx6Syf1oTxdianh3UVszi3gnbq+
	 17QUSoZ/mwkt/OWg0EQdyBPHPToJk0VdmrjOPYDVd5HowDNNl/KFKAZKtJEki1EipV
	 4IWjbqernTRE2UQ0+/kKLeHq3e41yQYvv7mOVjOs=
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 6536AFB949;
	Wed, 21 Oct 2026 13:22:07 +0000 (UTC)
Date: Wed, 21 Oct 2026 13:22:06 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-sparse@vger.kernel.org
Subject: Re: [PATCH 03/20] bits: Guard against out-of-bounds bit shifts in
 bitmask helpers
Message-ID: <ati8fuonrmRJyF9o@shell.ilvokhin.com>
References: <20261019175633.415493-1-bvanassche@acm.org>
 <20261019175633.415493-4-bvanassche@acm.org>
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Post: <mailto:linux-sparse@vger.kernel.org>
List-Help: <mailto:linux-sparse+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sparse+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019175633.415493-4-bvanassche@acm.org>

On Mon, Oct 19, 2026 at 10:56:16AM -0700, Bart Van Assche wrote:
> Clamp bit widths to [0, 64] in bits.h and fix 64-bit shift calculations
> in bitmap.h to avoid undefined shift behavior on 64-bit integers.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Dmitry Ilvokhin <d@ilvokhin.com>
