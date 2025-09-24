Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4682D6409
	for <linux-sparse@vger.kernel.org>; Wed, 24 Sep 2025 09:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758706078; cv=none; b=V+KxoDlg5pTnhUIR74tZfu3Y+RyuW3jyX3IJ+iDINED0tfvZGsmw75o1iWl+KxKozDTOdnlKcYw9Yc7Ru3qAcg4fyEcq5POk9jLGv8xuI2AzAYtosT4sM42dyXr6v7t0sEM56xLw18vvO8a5pWC5beV/up9o00WJG/tqGZXAB1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758706078; c=relaxed/simple;
	bh=utsrchJpGurUtpT4n5jP4NcUFmxYGduWdjy9GtmUQYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gyGRtgnA+nlRUQuTZGcn1+pZmQDGJv8tkUf+KLeO0k0z2p7eEPaDh/oTqcQ/o0k9Y5pqY1yYfgdL250jnigV+hChQN6A5KHnAvivTZu4IskqUQ09Ws4W78Qz03IPM6g5kCDopg+weA5oNLZAH4qGZEKmHvfe9QgLJ4cGbp6f1fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pD0TfttA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pD0TfttA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A48AC19424;
	Wed, 24 Sep 2025 09:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758706078;
	bh=utsrchJpGurUtpT4n5jP4NcUFmxYGduWdjy9GtmUQYg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pD0TfttAMgzHBu3dWwpsS5sB/qZYpp30Q+Ajx5vI/Pjum7ozJHhFux/f3ugC+UWCI
	 0DQ/8pO6/jwXX+z3UMf29uefMw0kG7DS+uNhElQVng0CpaLKcbEHuFvNk0EOtXWKdl
	 ExEsHigqtjyjbtlfIfsn0Flm4S1YO9Q0ty6+MezdM70v6ifAu1bJayORHYMvafS1Qz
	 Quc8scazUild2kDU4JpktINbfGo+8FpQzKtVoGZ3YyTDYL9+fhM8Fl65h9nR6TVmMO
	 hMXLion8ec5jDknWTUD9vUr4yYs0jZdA/V4Tc9B/w/LDwJNInIVtYsNztjCyYxveHN
	 f82jtvssCVlkQ==
Message-ID: <78229b37-a816-4128-b0be-ca73d9c05da7@kernel.org>
Date: Wed, 24 Sep 2025 18:27:56 +0900
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vadidation: add used-to-be-signed unit tests
To: Chris Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>
References: <CACePvbWQVBNQAAreW-Mzkp8ircGtV+K=gNk39HmUC0TNDOBCwQ@mail.gmail.com>
 <20250922155415.3289196-1-mailhol@kernel.org>
 <CACePvbXaHKH5Vp+j53pk6494pgDEABQpZ_gOo9_nmCZ4gjxUHw@mail.gmail.com>
Content-Language: en-US
From: Vincent Mailhol <mailhol@kernel.org>
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <CACePvbXaHKH5Vp+j53pk6494pgDEABQpZ_gOo9_nmCZ4gjxUHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/09/2025 at 16:03, Chris Li wrote:
> On Mon, Sep 22, 2025 at 8:54 AM Vincent Mailhol <mailhol@kernel.org> wrote:
>>
>> Add unit tests for the new used-to-be-signed check as introduced in [1]:
> 
> Applied and pushed on sparse-dev repo. Can you please take a look if I
> am doing it correctly on the sparse-dev?

I just checked out sparse-dev. I re-run the tests and everything looks fine!

> Linus has one more debug print line, can you add it for me and submit
> an incremental patch? It should be just a one liner. I will squash it
> with your change. I can ping you on the other email as well.

I replied in the other thread. That one line is already in the final patch ;)

> I intend to use sparse-dev as the unstable sparse developer repo. It
> will always be based on sparse repo but the commit in sparse-dev can
> be rewinded. Patches will sit in the sparse-dev for about a week then
> move into sparse repo. The sparse repo is a stable repo, it will not
> rewind.
> 
> BTW, the recommended base to submit the sparse patches is the stable
> sparse repo unless you depend on some bleeding edge feature only on
> sparse-dev repo. Pull request please base on the sparse repo not the
> unstable sparse-dev repo.
Ack. At the moment, I am not planning to do more sparse development, this patch
will likely be a one shot. But I will keep this in mind if I either decide to do
another contribution.


Yours sincerely,
Vincent Mailhol

