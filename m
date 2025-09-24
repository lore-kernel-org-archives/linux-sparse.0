Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68595DF49
	for <linux-sparse@vger.kernel.org>; Wed, 24 Sep 2025 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758704069; cv=none; b=nnsuXUqarZII6PQ5BKjAIkFNOrQb53K8O3vuOYtGb3MATC694fOkakGu526PvV0uzFV5yn0PY72V8hz0R/7eRuXUIickqf6p4290ywflXfYkPGPpvzr/ROOzzA/pX2prUrJmK/snR0Ha1u7WOFzSbCT37wqJE5AobEE52of1WpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758704069; c=relaxed/simple;
	bh=M9G/FWIZsOSx37GWXWspG7ETCOQTKfn74LvHf78e544=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5iZqR/pQw+0lSnWtLNA1idqyJyLniZMY73CXHoU9xhwf6JdxMTpxjZBSLdfzqWuCCPuKAq6luPiUt2VVj1Iz8vjjJmcny0Uu9tdmNGFyFSjn5aQSotg48A5IzcBex0I0rOfEvOMKCzEh8Z3H4nNtRor87sxEToJ8wkOJ6LArmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVa5OEXN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVa5OEXN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309F8C4CEE7;
	Wed, 24 Sep 2025 08:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758704069;
	bh=M9G/FWIZsOSx37GWXWspG7ETCOQTKfn74LvHf78e544=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HVa5OEXNFkXnoDd/RjgMNBdMle9D5Zw6ztO0/gntpS5OORf5X9Y62zqiLmyyMSwU8
	 zNZAEF4qQQcltBpANBS/lFPEWzMEbiUbRKgJ8aCgO6UcsUW0XXMcuOLzYaDCaimL7N
	 B9HdAcg9lA9kTEBOBNRj28FB26gv5zspTFndPbgSqP/fHWncWZ0WIbivTxFYa7F093
	 WWbPWezNdKdZMbhlak7QzsFhI4P0lwr8K0krbNA6jSKGklAHy6QIS64I0XM/Dg9NPo
	 OuDYdgypoDx/ecEpjQR9xG4Sd56bcTwx4XU0RNpqSQht55Oe3grs4TAKZQK6XEe9BZ
	 88H4tgPrkrYqg==
Message-ID: <de44070e-e71e-4935-bd59-894b6833dbc5@kernel.org>
Date: Wed, 24 Sep 2025 17:54:26 +0900
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Warn about "unsigned value that used to be signed against
 zero"
To: Chris Li <sparse@chrisli.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>
References: <20250921061337.3047616-1-mailhol@kernel.org>
 <CAHk-=wh2G3LxBZe-8MhNL7g+KS3BHR0z-vKFNaEeV=XQmyEwcQ@mail.gmail.com>
 <CACePvbVYFNANx8pi9v85FHMGU3rtN4zOmnqSe-Et=s8ngh0Ltw@mail.gmail.com>
 <CAHk-=wgnre70y_EFdwMbxLcd3zzihFqFrDEVed7+P7cpUU74WA@mail.gmail.com>
 <CACePvbUKV2rkYLeoQO9bWCon2qFkmKWGuh_NqvTccn=XZz7usw@mail.gmail.com>
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
In-Reply-To: <CACePvbUKV2rkYLeoQO9bWCon2qFkmKWGuh_NqvTccn=XZz7usw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/09/2025 at 16:07, Chris Li wrote:
> On Mon, Sep 22, 2025 at 9:17 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> On Mon, 22 Sept 2025 at 05:10, Chris Li <sparse@chrisli.org> wrote:
>>>
>>> On Sun, Sep 21, 2025 at 8:16 AM Linus Torvalds
>>> <torvalds@linux-foundation.org> wrote:
>>>>
>>>> That's why I had added that
>>>>
>>>>         info(def->pos, "signed value source");
>>>
>>> Do you want such a line in the final patch as well? Seems worth it.
>>
>> Oh, absolutely. Some of the cases it reported were really hard to
>> understand without it.
>>
>> If it ends up being noisy, there could possibly be some heuristic like
>> "if the source is very close to the use that triggers it, don't bother
>> talking about it", but that would be a later tweak.
> 
> Vincent, can you add the above info() line suggested by Linus as
> incremental or full patches?

I think that there is a small confusion here. That line is already in the patch
inside simplify_unsigned_zero_compare(). I think that Linus was just explaining
why he added it in the original patch.


Yours sincerely,
Vincent Mailhol

