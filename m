Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F0331158A
	for <linux-sparse@vger.kernel.org>; Mon,  5 Jan 2026 08:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767603514; cv=none; b=O3H6PoaORzb0X6KBDaVVlA9tf/+8z5x/GfB+gEf9cd2jaqb6LHTEYhfGqZXOiOgWRn6Tpp0/lZ5wddmHRVsKzdKmpIS/zpeUbJwZUiqZ8yK0zXILUhjoiTWmKsB+EMKTuxzpqo3Z5l9dQ3mRpP3B31BN4kT5cHzA0CZt+LUNqT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767603514; c=relaxed/simple;
	bh=Ke0dg3OTm4cr9Q8cvG82NRjzQxbHzC6UWrNufE+YnDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UcwXTy0t/qXKob0HqfwpjUTOvMbl3wFe44FdzO/830RIy/GMmFaqEawal0Ho40nSUGD1FkadAk8MkV0l2BgkndGjHc1SecL6cr+UT7iQkNofRApfA69VhF5cD1K13LxVuPZ43Sn3KHyDzHXIBl1q82PaNwZQx4frlLawQu8Jt1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=DZaE6Q5/; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="DZaE6Q5/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Reply-To; bh=THe7Qo3G4jgGofKkIEfG/2LgAKoAiWP0ARxxrSJFy+I=; b=DZaE6Q5/ckvPib8t
	iqw2vb5hzbVQHFGdBZRHuQZ25kTygK/tR+De7r8SaxknMMrqpBmrUabv6slBVc9/4PHPSrBkBqj6A
	5kZsT/1NggAn/EMVph0y4r1cvE35I+wBXdfik2y5/jAPja6p24vwXZQuOw1K8a2CnGsGe2zA+oXKy
	2F4PdJ5AGfsWwa7p6pOXSQPJVt9rUx/y+DX81OmI8REH0nTWc0N9OlnaD3dM0eG4U4+4iBe71FpTx
	A8A/SzeeDxCTonlLAwH6/LqM6hkxo7X4YW46bfWUdfypz7HJuFc/7HC5DTNLmaAyQBv6DeqraVhT/
	z8JjnJdIlFIQU1x8Iw==;
Received: from [167.98.27.226] (helo=[10.35.6.194])
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1vcgPv-006h3g-QD; Mon, 05 Jan 2026 08:58:23 +0000
Message-ID: <30d94564-382e-4cfe-b7ae-6fcabf95847b@codethink.co.uk>
Date: Mon, 5 Jan 2026 08:58:23 +0000
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] add variadic format checking
To: linux-sparse@vger.kernel.org, sparse@chrisli.org
Cc: luc.vanoostenryck@gmail.com
References: <20251222160034.96188-1-ben.dooks@codethink.co.uk>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20251222160034.96188-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: ben.dooks@codethink.co.uk

On 22/12/2025 16:00, Ben Dooks wrote:
> Second version of this, I think mostly sorting the issues
> identified in review.
> 
> This series (which was initially sent back in 2020) adds the
> ability to deal with __attribute__((format) and checking the
> arguments to formatted variadic functions.
> 
> I have been considering adding a -Wformat-linux to this as
> the kernel now has a number of extra formatting options and
> checking the type of these would be useful. An even nicer
> extension would be some way of informing the compiler/sparse
> of these at compile time (but would need to get agreement on
> how to do this with the compilers too)

Having tested on the kernel, there's a couple of issues with
this code, that i've mostly fixed.

Adding kernel type checking didn't come up with anything on
my riscv build other than a few signed v unsigned.

> Ben Dooks (4):
>    parse: initial parsing of __attribute__((format))
>    add -Wformat
>    evaluate: check variadic argument types against formatting info
>    tests: add varargs printf format tests
> 
>   Makefile                               |   1 +
>   builtin.c                              |   4 +-
>   evaluate.c                             |  14 +-
>   evaluate.h                             |  10 +-
>   options.c                              |   2 +
>   options.h                              |   1 +
>   parse.c                                |  83 ++++-
>   sparse.1                               |   8 +
>   symbol.h                               |  10 +-
>   validation/varargs-format-addrspace1.c |  36 ++
>   validation/varargs-format-bad.c        |  18 +
>   validation/varargs-format-checking.c   |  21 ++
>   validation/varargs-format-position.c   |  32 ++
>   validation/varargs-format-prefix.c     |  19 +
>   validation/varargs-format-tests.c      |  55 +++
>   validation/varargs-type-formattest.c   | 117 +++++++
>   verify-format.c                        | 460 +++++++++++++++++++++++++
>   verify-format.h                        |   6 +
>   18 files changed, 887 insertions(+), 10 deletions(-)
>   create mode 100644 validation/varargs-format-addrspace1.c
>   create mode 100644 validation/varargs-format-bad.c
>   create mode 100644 validation/varargs-format-checking.c
>   create mode 100644 validation/varargs-format-position.c
>   create mode 100644 validation/varargs-format-prefix.c
>   create mode 100644 validation/varargs-format-tests.c
>   create mode 100644 validation/varargs-type-formattest.c
>   create mode 100644 verify-format.c
>   create mode 100644 verify-format.h
> 


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
