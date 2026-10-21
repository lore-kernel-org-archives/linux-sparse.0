Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.62.254.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590873;
	b=lUTfEH2yJ6EQIO5Htc4ZSSBNhYJHnlOJkiJ5maU/LeRge3WRMDr+1mRzmXG1prBdnDZJ
	 4VB0RFktr3uMFsQLvIPPYVDDiYwcQZpe5E+4pLNB5yJ9CrX6XafUh49zR7h0f42nQWHhP
	 /8CoeJ/J6uY3zxNY4/rskJWpVlRlRyzHugqP1yDdByx4d6w1chnMEtof1xxB9ZIVmdldr
	 ZGPG2Y9kP0VddA8KYErsrffInkXYr3UXhAD9qHL1QFANNDsgPUOnCYTa4eyZ7jCxd9mDk
	 m3Tn+UT+Ytfkber0SDz6AnuplLQK+iJL14wwjkwyaJ8ycl79DjFuUnaYsHNZfyTFDsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590873;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=9K92xG1pY6Eai+RJQI2vza/e0JEDoJ26POal0rn4oig=;
	b=Lx0zOGN+dkP6UdJkMUuRaZ8YIbEi8AAkzqYMrsul4YWDmUj8RezsC9HZEQbvIdaokfqk
	 eLKGsOVNV9O3uAFm3k06v6ooIu448zLsIJhdEppEDPqmsD+MoewHSBA5F/qpPcJrqt/by
	 vOoBXtxS9VFXE9lom2XaHIiRkqtnBYJbFWcac9IvY5wCnLlxIs/aMgNuoF1GcNny9gWbx
	 h/2+jNcWrqI1xrtVp761fJtU7ADupFuuanKcskiktKK893QsVCHFiImZpJ2En01weutr0
	 Qh00uyOwn1+mI5oqpziL7zS2WjYIB4/3bB608O02BHv/q31CKEBAX9SNAYllXBU7/ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ilvokhin.com;
	spf=pass smtp.mailfrom=ilvokhin.com;
	dkim=pass header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=cFJ+5rHD;
	arc=none smtp.remote-ip=178.62.254.231
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B41606A31E
	for <linux-sparse@vger.kernel.org>; Wed, 21 Oct 2026 13:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52B41606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=cFJ+5rHD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1792590871;
	bh=9K92xG1pY6Eai+RJQI2vza/e0JEDoJ26POal0rn4oig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cFJ+5rHDFjhxlxAzEdbnE7ePSahjsR6oAMtpHl5qn3RjHA924acBLaL4ir+doKFCu
	 hrH+Wb6H21r9AYafnHx4Ijc5bC5wZ6tpDssrw79XDyefzSY1f/dzxqeh7qrXUYDSdy
	 ADaA3rN5S71DlzY9RS+45vwtZ/WTMW71XsG6SUgM=
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id C51B3FB95C;
	Wed, 21 Oct 2026 13:54:31 +0000 (UTC)
Date: Wed, 21 Oct 2026 13:54:30 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-sparse@vger.kernel.org
Subject: Re: [PATCH 05/20] builtin: Bound argument array iteration in
 declare_builtin()
Message-ID: <atjEFtoLmSqgPBcZ@shell.ilvokhin.com>
References: <20261019175633.415493-1-bvanassche@acm.org>
 <20261019175633.415493-6-bvanassche@acm.org>
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
In-Reply-To: <20261019175633.415493-6-bvanassche@acm.org>

On Mon, Oct 19, 2026 at 10:56:18AM -0700, Bart Van Assche wrote:
> Bound the loop over entry->args[] in declare_builtin() with
> ARRAY_SIZE(entry->args) before reading entry->args[i], and remove the
> sentinel member _args_null_tail from struct builtin_fn.
> 
> Prevent out-of-bounds array reads past the end of struct builtin_fn's
> six-element args[] array when declaring six-argument builtins such as
> __atomic_compare_exchange_n, avoiding AddressSanitizer bounds errors.
> 
> Fixes: 935cf032524f ("builtin: use a table for the builtins")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Dmitry Ilvokhin <d@ilvokhin.com>
